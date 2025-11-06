# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 

function Revoke-EntraBetaMcpServerPermission {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High', DefaultParameterSetName = 'PredefinedClients')]
    param(
        [Parameter(ParameterSetName = 'PredefinedClients', Mandatory = $false)]
        [ValidateSet('VisualStudioCode', 'VisualStudio', 'VisualStudioMSAL')]
        [string[]]$MCPClient,

        [Parameter(ParameterSetName = 'CustomClients', Mandatory = $true)]
        [ValidatePattern('^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$')]
        [string[]]$MCPClientServicePrincipalId,

        [Parameter(ParameterSetName = 'PredefinedClients', Mandatory = $false)]
        [Parameter(ParameterSetName = 'CustomClients', Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [string[]]$Scopes
    )

    begin {
        # Create headers for the request
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand

        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes Application.ReadWrite.All, Directory.Read.All, DelegatedPermissionGrant.ReadWrite.All, ' to authenticate."
            Write-Error -Message $errorMessage -ErrorAction Stop
            return
        }
        function Get-ServicePrincipal([string]$appId, [string]$name) {
            $sp = Get-MgBetaServicePrincipal -Filter "appId eq '$appId'" -ErrorAction SilentlyContinue -Headers $customHeaders | Select-Object -First 1
            if (-not $sp) {
                throw "Service principal for $name not found. App ID: $appId"
            }
            return $sp
        }

        function Get-Grant {
            param(
                [Parameter(Mandatory)] [string] $ClientSpId,
                [Parameter(Mandatory)] [string] $ResourceSpId
            )
            Get-MgBetaOauth2PermissionGrant `
                -Filter "clientId eq '$ClientSpId' and resourceId eq '$ResourceSpId' and consentType eq 'AllPrincipals'" `
                -Top 1 `
                -Property "id,scope,clientId,resourceId,consentType" `
                -ErrorAction SilentlyContinue `
                -Headers $customHeaders |
            Select-Object -First 1
        }

        function Update-GrantScopes([string]$clientSpId, [string]$resourceSpId, [string[]]$targetScopes) {
            $grant = Get-Grant -clientSpId $clientSpId -resourceSpId $resourceSpId | Select-Object -First 1

            if (-not $grant) {
                Write-Verbose "No existing grant found for this client."
                return $null
            }

            if (-not $targetScopes -or $targetScopes.Count -eq 0) {
                Write-Verbose "Removing entire permission grant..."
                Remove-MgBetaOauth2PermissionGrant -OAuth2PermissionGrantId $grant.Id -Confirm:$false -Headers $customHeaders
                return $null
            }

            $targetString = ($targetScopes | Sort-Object -Unique) -join ' '

            $currentScope = if ($grant.Scope) { $grant.Scope } else { "" }
            if ($currentScope -ceq $targetString) {
                Write-Verbose "Grant already has the correct scopes."
                return $grant
            }

            Write-Verbose "Updating permission grant with remaining scopes..."
            Update-MgBetaOauth2PermissionGrant -OAuth2PermissionGrantId $grant.Id -BodyParameter @{ scope = $targetString } -Headers $customHeaders
            return Get-Grant -clientSpId $clientSpId -resourceSpId $resourceSpId
        }

        # Constants
        $resourceAppId = "e8c77dc2-69b3-43f4-bc51-3213c9d915b4"  # Microsoft MCP Server for Enterprise
        $predefinedClients = @{
            "VisualStudioCode" = @{ Name = "Visual Studio Code"; AppId = "aebc6443-996d-45c2-90f0-388ff96faa56" }
            "VisualStudio"     = @{ Name = "Visual Studio"; AppId = "04f0c124-f2bc-4f59-8241-bf6df9866bbd" }
            "VisualStudioMSAL" = @{ Name = "Visual Studio MSAL"; AppId = "62e61498-0c88-438b-a45c-2da0517bebe6" }
        }

        function Resolve-MCPClient {
            param(
                [string[]]$MCPClients,
                [string[]]$CustomServicePrincipalIds
            )

            $resolvedClients = @()

            # Process MCP clients
            if ($MCPClients) {
                foreach ($client in $MCPClients) {
                    if ($predefinedClients.ContainsKey($client)) {
                        $clientInfo = $predefinedClients[$client]
                        $resolvedClients += @{
                            Name     = $clientInfo.Name
                            AppId    = $clientInfo.AppId
                            IsCustom = $false
                        }
                    }
                }
            }

            # Process custom service principal IDs
            if ($CustomServicePrincipalIds) {
                foreach ($spId in $CustomServicePrincipalIds) {
                    $resolvedClients += @{
                        Name     = "Custom MCP Client"
                        AppId    = $spId
                        IsCustom = $true
                    }
                }
            }

            return $resolvedClients
        }
    }

    process {
        # Get resource service principal
        $resourceSp = Get-ServicePrincipal $resourceAppId "Microsoft MCP Server for Enterprise"

        # Resolve MCP clients
        $resolvedClients = Resolve-MCPClient -MCPClients $MCPClient -CustomServicePrincipalIds $MCPClientServicePrincipalId
        Write-Verbose "Resolved $($resolvedClients.Count) MCP client(s): $($resolvedClients.Name -join ', ')" 

        $clientSps = @()
        foreach ($client in $resolvedClients) {
            try {
                $sp = Get-ServicePrincipal $client.AppId $client.Name
                $clientSps += @{
                    Sp       = $sp
                    Name     = $client.Name
                    IsCustom = $client.IsCustom
                }
                Write-Verbose "Found service principal for: $($client.Name)"
            }
            catch {
                Write-Warning "Could not get service principal for $($client.Name) (App ID: $($client.AppId)): $($_.Exception.Message)"
                continue
            }
        }

        if ($clientSps.Count -eq 0) {
            Write-Warning "No MCP client service principals could be found."
            return
        }

        Write-Host "Operating on $($clientSps.Count) MCP client(s): $($clientSps.Name -join ', ')" -ForegroundColor Cyan        # Process each client service principal
        $results = @()
        $allCurrentScopes = @()

        # First pass: collect all current scopes across all clients
        foreach ($clientSp in $clientSps) {
            $currentGrant = Get-Grant -ClientSpId $clientSp.Sp.Id -ResourceSpId $resourceSp.Id
            if ($currentGrant -and $currentGrant.Scope) {
                $currentScopes = ($currentGrant.Scope -split '\s+' | Where-Object { $_ }) | Sort-Object -Unique
                $allCurrentScopes += $currentScopes
            }
        }

        $allCurrentScopes = $allCurrentScopes | Sort-Object -Unique

        if (-not $allCurrentScopes -and $clientSps.Count -gt 1) {
            Write-Warning "No scopes currently granted to any of the MCP clients."
            return
        }
        if ($Scopes) {
            # Revoke specific scopes
            $scopesToRevoke = $Scopes | Sort-Object -Unique
            $invalidScopes = $scopesToRevoke | Where-Object { $_ -notin $allCurrentScopes }
            if ($invalidScopes) {
                Write-Warning "The following scopes are not currently granted to any client: $($invalidScopes -join ', ')"
            }

            $validScopesToRevoke = $scopesToRevoke | Where-Object { $_ -in $allCurrentScopes }
            if (-not $validScopesToRevoke) {
                Write-Warning "No valid scopes to revoke."
                return
            }

            $actionDescription = "Revoke scopes '$($validScopesToRevoke -join ', ')' from $($clientSps.Count) MCP client(s): $($clientSps.Name -join ', ')"
        } else {
            # Revoke all scopes
            $validScopesToRevoke = $allCurrentScopes
            $actionDescription = "Revoke ALL permissions from $($clientSps.Count) MCP client(s): $($clientSps.Name -join ', ')"
        }

        # Confirm action for all clients
        if ($PSCmdlet.ShouldProcess("$($clientSps.Count) MCP client(s)", $actionDescription)) {
            # Second pass: process each client
            foreach ($clientSp in $clientSps) {
                try {
                    $currentGrant = Get-Grant -ClientSpId $clientSp.Sp.Id -ResourceSpId $resourceSp.Id

                    if (-not $currentGrant) {
                        $results += @{
                            Client          = $clientSp.Name
                            Success         = $true
                            Action          = "No existing grant"
                            RemovedScopes   = @()
                            RemainingScopes = @()
                            Error           = $null
                        }
                        continue
                    }

                    # Get current scopes for this specific client
                    $currentClientScopes = if ($currentGrant.Scope) {
                        ($currentGrant.Scope -split '\s+' | Where-Object { $_ }) | Sort-Object -Unique
                    } else {
                        @()
                    }

                    if (-not $currentClientScopes) {
                        $results += @{
                            Client          = $clientSp.Name
                            Success         = $true
                            Action          = "No scopes to revoke"
                            RemovedScopes   = @()
                            RemainingScopes = @()
                            Error           = $null
                        }
                        continue
                    }

                    # Calculate remaining scopes for this client
                    if ($Scopes) {
                        $remainingScopes = $currentClientScopes | Where-Object { $_ -notin $validScopesToRevoke }
                        $actualRemovedScopes = $currentClientScopes | Where-Object { $_ -in $validScopesToRevoke }
                    } else {
                        $remainingScopes = @()
                        $actualRemovedScopes = $currentClientScopes
                    }

                    # Update the grant
                    $result = Update-GrantScopes -clientSpId $clientSp.Sp.Id -resourceSpId $resourceSp.Id -targetScopes $remainingScopes

                    $results += @{
                        Client          = $clientSp.Name
                        Success         = $true
                        Action          = if ($remainingScopes.Count -eq 0) { "All permissions revoked" } else { "Partial revocation" }
                        RemovedScopes   = $actualRemovedScopes
                        RemainingScopes = $remainingScopes
                        Error           = $null
                    }
                } catch {
                    $results += @{
                        Client          = $clientSp.Name
                        Success         = $false
                        Action          = "Failed"
                        RemovedScopes   = @()
                        RemainingScopes = @()
                        Error           = $_.Exception.Message
                    }
                }
            }

            # Display results
            $successCount = ($results | Where-Object Success).Count
            $errorCount = ($results | Where-Object { -not $_.Success }).Count

            Write-Host "`nResults Summary:" -ForegroundColor Yellow
            Write-Host "Successfully processed: $successCount client(s)" -ForegroundColor Green
            if ($errorCount -gt 0) {
                Write-Host "Failed to process: $errorCount client(s)" -ForegroundColor Red
            }

            foreach ($result in $results) {
                if ($result.Success) {
                    Write-Host "`n✓ $($result.Client): $($result.Action)" -ForegroundColor Green

                    if ($result.RemovedScopes.Count -gt 0) {
                        Write-Host "  Revoked scopes:" -ForegroundColor Yellow
                        $result.RemovedScopes | ForEach-Object { Write-Host "    - $_" -ForegroundColor Red }
                    }

                    if ($result.RemainingScopes.Count -gt 0) {
                        Write-Host "  Remaining scopes:" -ForegroundColor Yellow
                        $result.RemainingScopes | ForEach-Object { Write-Host "    - $_" -ForegroundColor Green }
                    }
                } else {
                    Write-Host "`n✗ Failed to process $($result.Client)" -ForegroundColor Red
                    Write-Host "  Error: $($result.Error)" -ForegroundColor Red
                }
            }
        }
    }
}