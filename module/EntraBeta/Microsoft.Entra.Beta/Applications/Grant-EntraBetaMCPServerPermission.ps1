# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 

function Grant-EntraBetaMcpServerPermission {
    [CmdletBinding(DefaultParameterSetName = 'PredefinedClient')]
    param(
        # Specifies the predefined MCP client to grant permissions to.
        [Parameter(ParameterSetName = 'PredefinedClient', Mandatory = $true, HelpMessage = "Specify a predefined MCP client to grant permissions to.")]
        [Parameter(ParameterSetName = 'PredefinedClientScopes', Mandatory = $true, HelpMessage = "Specify a predefined MCP client to grant permissions to.")]
        [ValidateSet('VisualStudioCode', 'VisualStudio', 'ChatGPT', 'Claude')]
        [string]$ApplicationName,

        # Specifies the service principal ID for a custom MCP client. Must be a valid GUID.
        [Parameter(ParameterSetName = 'CustomClient', Mandatory = $true, HelpMessage = "Specify a service principal ID (GUID) for a custom MCP client to grant permissions to.")]
        [Parameter(ParameterSetName = 'CustomClientScopes', Mandatory = $true, HelpMessage = "Specify a service principal ID (GUID) for a custom MCP client to grant permissions to.")]
        [ValidateNotNullOrEmpty()]
        [guid]$ApplicationId,

        # Specifies the specific scopes to grant. If not specified, all available scopes will be granted.
        [Parameter(ParameterSetName = 'PredefinedClientScopes', Mandatory = $true, HelpMessage = "Specify one or more specific scopes to grant to the MCP client. If not specified, all available scopes will be granted.")]
        [Parameter(ParameterSetName = 'CustomClientScopes', Mandatory = $true, HelpMessage = "Specify one or more specific scopes to grant to the MCP client. If not specified, all available scopes will be granted.")]
        [ValidateNotNullOrEmpty()]
        [string[]]$Scopes
    )

    begin {
        # Create headers for the request
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand

        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes Application.ReadWrite.All, Directory.Read.All, DelegatedPermissionGrant.ReadWrite.All' to authenticate."
            Write-Error -Message $errorMessage -ErrorAction Stop
            return
        }

        # Constants
        $resourceAppId = "e8c77dc2-69b3-43f4-bc51-3213c9d915b4"  # Microsoft MCP Server for Enterprise
        $PredefinedApps = @{
            "VisualStudioCode"         = @{ Name = "Visual Studio Code"; AppId = "aebc6443-996d-45c2-90f0-388ff96faa56" }
            "VisualStudio"             = @{ Name = "Visual Studio"; AppId = "04f0c124-f2bc-4f59-8241-bf6df9866bbd" }
            "ChatGPT"                  = @{ Name = "Chat GPT"; AppId = "e0476654-c1d5-430b-ab80-70cbd947616a" }
            "Claude"            = @{ Name = "Claude"; AppId = "08ad6f98-a4f8-4635-bb8d-f1a3044760f0" }
        }

        function Get-ServicePrincipal([string]$appId, [string]$name) {
            # Only use custom headers for MCP Server for Enterprise check.
            $headers = if ($appId -eq $resourceAppId) { $customHeaders } else { $null }
            
            Write-Verbose "Checking service principal for $name ..."
            $sp = Get-MgBetaServicePrincipal `
                -Filter "appId eq '$appId'" `
                -ErrorAction SilentlyContinue `
                -Property "id,appId,displayName,publishedPermissionScopes" `
                -Headers $headers | Select-Object -First 1
            
            if (-not $sp) {
                Write-Verbose "Creating service principal for $name ..."
                $sp = New-MgBetaServicePrincipal -AppId $appId
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
                -Property "id,scope,clientId,resourceId,consentType" `
                -ErrorAction SilentlyContinue |
            Select-Object -First 1
        }

        function Set-ExactScopes() {
            param(
                [string]$clientSpId,
                [string]$resourceSpId,
                [string[]]$targetScopes,
                [switch]$Additive
            )

            $grant = Get-Grant -clientSpId $clientSpId -resourceSpId $resourceSpId | Select-Object -First 1

            # Empty target scope list means caller wants to clear grant entirely.
            if (-not $targetScopes -or $targetScopes.Count -eq 0) {
                if ($grant) {
                    Write-Verbose "Removing existing grant because target scope list is empty."
                    Remove-MgBetaOauth2PermissionGrant -OAuth2PermissionGrantId $grant.Id -Confirm:$false
                }
                return $null
            }

            $incomingScopes = $targetScopes | Where-Object { $_ } | Sort-Object -Unique

            if (-not $grant) {
                # No existing grant – create with provided scopes (already additive by definition)
                $targetString = ($incomingScopes) -join ' '
                Write-Verbose "Creating new permission grant with scopes: $targetString"
                $body = @{
                    clientId    = $clientSpId
                    resourceId  = $resourceSpId
                    consentType = "AllPrincipals"
                    scope       = $targetString
                    expiryTime  = (Get-Date).AddYears(1)
                }
                return (@(New-MgBetaOauth2PermissionGrant -BodyParameter $body)[0])
            }

            $currentScopes = ($grant.Scope -split '\s+') | Where-Object { $_ }

            if ($Additive) {
                # Merge existing + incoming (add only missing)
                $mergedScopes = @($currentScopes) + @($incomingScopes) | Where-Object { $_ } | Sort-Object -Unique
                $targetString = $mergedScopes -join ' '
                $currentString = (@($currentScopes) | Where-Object { $_ } | Sort-Object -Unique) -join ' '
                if ($currentString -ceq $targetString) {
                    Write-Verbose "All requested scopes already present; nothing to add."
                    return $grant
                }
                Write-Verbose "Adding scopes. Existing: $($currentScopes -join ', ') | Incoming: $($incomingScopes -join ', ') | Result: $($mergedScopes -join ', ')"
            }
            else {
                # Exact replacement mode (not used when -Scopes provided per updated behavior)
                $targetString = $incomingScopes -join ' '
                $currentString = ($currentScopes | Sort-Object -Unique) -join ' '
                if ($currentString -ceq $targetString) {
                    Write-Verbose "Grant already has the exact scopes requested."
                    return $grant
                }
                Write-Verbose "Replacing existing scopes with: $targetString (was: $currentString)"
            }

            Update-MgBetaOauth2PermissionGrant -OAuth2PermissionGrantId $grant.Id -BodyParameter @{ scope = $targetString }
            return Get-Grant -clientSpId $clientSpId -resourceSpId $resourceSpId
        }

        function Resolve-MCPClient {
            param(
                [string]$PredefinedAppName,
                [string]$CustomClientApplication
            )

            # Process predefined MCP client
            if ($PredefinedAppName) {
                if ($PredefinedApps.ContainsKey($PredefinedAppName)) {
                    $clientInfo = $PredefinedApps[$PredefinedAppName]
                    return @{
                        Name = $clientInfo.Name
                        AppId = $clientInfo.AppId
                        IsCustom = $false
                    }
                }
                else {
                    throw "Invalid MCP client: $PredefinedAppName"
                }
            }

            # Process custom service principal ID
            if ($CustomClientApplication) {
                return @{
                    Name = "Custom MCP Client"
                    AppId = $CustomClientApplication
                    IsCustom = $true
                }
            }

            throw "No MCP client specified."
        }
    }

    process {
        # Get resource service principal
        $resourceSp = Get-ServicePrincipal $resourceAppId "Microsoft MCP Server for Enterprise"

        # Get available delegated scopes
        $availableScopes = $resourceSp.publishedPermissionScopes | Where-Object IsEnabled | Select-Object -ExpandProperty Value
        if (-not $availableScopes) {
            throw "Resource app exposes no enabled delegated (user) scopes."
        }
        $availableScopes = $availableScopes | Sort-Object -Unique

        # Resolve MCP client
        $client = Resolve-MCPClient -PredefinedAppName $ApplicationName -CustomClientApplication $ApplicationId
        Write-Verbose "Resolved MCP client: $($client.Name)"

        # Get service principal for the resolved client
        try {
            $sp = Get-ServicePrincipal $client.AppId $client.Name
            $client.Name = $sp.DisplayName
            Write-Verbose "Found service principal for: $($client.Name)"
        }
        catch {
            throw "Could not get service principal for $($client.Name) (App ID: $($client.AppId)): $($_.Exception.Message)"
        }

        Write-Host "Operating on MCP client: $($client.Name)" -ForegroundColor Cyan

        # Determine target scopes
        if ($Scopes -and $Scopes.Count -gt 0) {
            # Validate specified scopes
            $invalidScopes = $Scopes | Where-Object { $_ -notin $availableScopes }
            if ($invalidScopes) {
                throw "Invalid scopes (not available on resource): $($invalidScopes -join ', ')"
            }
            $targetScopes = $Scopes | Sort-Object -Unique
            Write-Host "Adding specific scopes (preserving existing grant): $($targetScopes -join ', ')" -ForegroundColor Cyan
            $additiveMode = $true
        }
        else {
            # Grant all available scopes (default behavior)
            $targetScopes = $availableScopes
            Write-Host "Granting all available scopes: $($targetScopes -join ', ')" -ForegroundColor Cyan
            $additiveMode = $false
        }

        # Apply the permission grant
        try {
            $grant = Set-ExactScopes -clientSpId $sp.Id -resourceSpId $resourceSp.Id -targetScopes $targetScopes -Additive $additiveMode
            
            if ($grant) {
                Write-Host "`n✓ Successfully granted permissions to $($client.Name)" -ForegroundColor Green
                Write-Verbose "  Grant ID: $($grant.Id)"

                # Display granted scopes
                $grantedScopes = ($grant.Scope -split '\s+' | Where-Object { $_ }) | Sort-Object
                Write-Verbose "  Granted scopes:"
                $grantedScopes | ForEach-Object { Write-Verbose "    - $_"}
                
                # Return the OAuth2PermissionGrant object
                return $grant
            }
            else {
                Write-Host "`n⚠ No permissions were granted to $($client.Name) (empty scope list)" -ForegroundColor Yellow
                return $null
            }
        }
        catch {
            Write-Host "`n✗ Failed to grant permissions to $($client.Name)" -ForegroundColor Red
            Write-Host "  Error: $($_.Exception.Message)" -ForegroundColor Red
            throw
        }
    }
}