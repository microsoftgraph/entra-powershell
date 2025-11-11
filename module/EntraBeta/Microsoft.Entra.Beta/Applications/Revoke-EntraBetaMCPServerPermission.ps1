# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 

function Revoke-EntraBetaMcpServerPermission {
    [CmdletBinding(DefaultParameterSetName = 'PredefinedClient')]
    param(
        [Parameter(ParameterSetName = 'PredefinedClient', Mandatory = $true, HelpMessage = "Specifies a predefined MCP client application to revoke permissions from.")]
        [ValidateSet('VisualStudioCode', 'VisualStudio', 'VisualStudioMSAL')]
        [string]$PredefinedClient,

        [Parameter(ParameterSetName = 'CustomClient', Mandatory = $true, HelpMessage = "Specifies the Application ID of a custom MCP client application to revoke permissions from. Must be valid GUID format.")]
        [ValidateNotNullOrEmpty()]
        [guid]$CustomClientAppId,

        [Parameter(ParameterSetName = 'PredefinedClient', Mandatory = $false, HelpMessage = "Specifies the specific scopes/permissions to revoke. If not specified, all permissions will be revoked from the MCP client.")]
        [Parameter(ParameterSetName = 'CustomClient', Mandatory = $false, HelpMessage = "Specifies the specific scopes/permissions to revoke. If not specified, all permissions will be revoked from the MCP client.")]
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

        # Constants
        $resourceAppId = "e8c77dc2-69b3-43f4-bc51-3213c9d915b4"  # Microsoft MCP Server for Enterprise
        $predefinedClients = @{
            "VisualStudioCode"         = @{ Name = "Visual Studio Code"; AppId = "aebc6443-996d-45c2-90f0-388ff96faa56" }
            "VisualStudio"             = @{ Name = "Visual Studio"; AppId = "04f0c124-f2bc-4f59-8241-bf6df9866bbd" }
            "ChatGPT"                  = @{ Name = "Chat GPT"; AppId = "e0476654-c1d5-430b-ab80-70cbd947616a" }
            "ClaudeDesktop"            = @{ Name = "Claude Desktop"; AppId = "08ad6f98-a4f8-4635-bb8d-f1a3044760f0" }
        }
        
        function Get-ServicePrincipal([string]$appId, [string]$name) {
            $headers = if ($appId -eq $resourceAppId) { $customHeaders } else { $null }
            $sp = Get-MgBetaServicePrincipal -Filter "appId eq '$appId'" -ErrorAction SilentlyContinue -Headers $headers | Select-Object -First 1
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
                -ErrorAction SilentlyContinue |
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
                Remove-MgBetaOauth2PermissionGrant -OAuth2PermissionGrantId $grant.Id -Confirm:$false
                return $null
            }

            $targetString = ($targetScopes | Sort-Object -Unique) -join ' '

            $currentScope = if ($grant.Scope) { $grant.Scope } else { "" }
            if ($currentScope -ceq $targetString) {
                Write-Verbose "Grant already has the correct scopes."
                return $grant
            }

            Write-Verbose "Updating permission grant with remaining scopes..."
            Update-MgBetaOauth2PermissionGrant -OAuth2PermissionGrantId $grant.Id -BodyParameter @{ scope = $targetString }
            return Get-Grant -clientSpId $clientSpId -resourceSpId $resourceSpId
        }

        function Resolve-MCPClient {
            param(
                [string]$PredefinedClientApp,
                [string]$CustomClientApplication
            )

            # Process MCP client
            if ($PredefinedClientApp) {
                if ($predefinedClients.ContainsKey($PredefinedClientApp)) {
                    $clientInfo = $predefinedClients[$PredefinedClientApp]
                    return @{
                        Name     = $clientInfo.Name
                        AppId    = $clientInfo.AppId
                        IsCustom = $false
                    }
                }
            }

            # Process custom service principal ID
            if ($CustomClientApplication) {
                return @{
                    Name     = "Custom MCP Client"
                    AppId    = $CustomClientApplication
                    IsCustom = $true
                }
            }

            return $null
        }
    }

    process {
        # Get resource service principal
        $resourceSp = Get-ServicePrincipal $resourceAppId "Microsoft MCP Server for Enterprise"

        # Resolve MCP client
        $resolvedClient = Resolve-MCPClient -PredefinedClientApp $PredefinedClient -CustomClientApplication $CustomClientAppId
        if (-not $resolvedClient) {
            Write-Error "Could not resolve MCP client." -ErrorAction Stop
            return
        }

        Write-Verbose "Resolved MCP client: $($resolvedClient.Name)" 

        # Get client service principal
        try {
            $clientSp = Get-ServicePrincipal $resolvedClient.AppId $resolvedClient.Name
            $resolvedClient.Name = $clientSp.DisplayName
            Write-Verbose "Found service principal for: $($resolvedClient.Name)"
        }
        catch {
            Write-Error "Could not get service principal for $($resolvedClient.Name) (App ID: $($resolvedClient.AppId)): $($_.Exception.Message)" -ErrorAction Stop
            return
        }

        # Get current grant
        $currentGrant = Get-Grant -ClientSpId $clientSp.Id -ResourceSpId $resourceSp.Id

        if (-not $currentGrant) {
            Write-Warning "No existing permission grant found for $($resolvedClient.Name)."
            return $null
        }

        # Get current scopes
        $currentScopes = if ($currentGrant.Scope) {
            ($currentGrant.Scope -split '\s+' | Where-Object { $_ }) | Sort-Object -Unique
        } else {
            @()
        }

        if (-not $currentScopes) {
            Write-Warning "No scopes currently granted to $($resolvedClient.Name)."
            return $currentGrant
        }

        # Determine scopes to revoke and remaining scopes
        if ($Scopes) {
            # Revoke specific scopes
            $scopesToRevoke = $Scopes | Sort-Object -Unique
            $invalidScopes = $scopesToRevoke | Where-Object { $_ -notin $currentScopes }
            if ($invalidScopes) {
                Write-Warning "The following scopes are not currently granted: $($invalidScopes -join ', ')"
            }

            $validScopesToRevoke = $scopesToRevoke | Where-Object { $_ -in $currentScopes }
            if (-not $validScopesToRevoke) {
                Write-Warning "No valid scopes to revoke."
                return $currentGrant
            }

            $remainingScopes = $currentScopes | Where-Object { $_ -notin $validScopesToRevoke }
        } else {
            # Revoke all scopes
            $validScopesToRevoke = $currentScopes
            $remainingScopes = @()
        }

        try {
            # Update the grant
            $updatedGrant = Update-GrantScopes -clientSpId $clientSp.Id -resourceSpId $resourceSp.Id -targetScopes $remainingScopes

            if ($remainingScopes.Count -eq 0) {
                Write-Host "✓ All permissions revoked from $($resolvedClient.Name)" -ForegroundColor Green
                return $null
            } else {
                Write-Host "✓ Permissions partially revoked from $($resolvedClient.Name)" -ForegroundColor Green
                Write-Host "  Revoked scopes:" -ForegroundColor Yellow
                $validScopesToRevoke | ForEach-Object { Write-Host "    - $_" -ForegroundColor Red }
                Write-Host "  Remaining scopes:" -ForegroundColor Yellow
                $remainingScopes | ForEach-Object { Write-Host "    - $_" -ForegroundColor Green }
                
                # Return the updated OAuth2PermissionGrant resource
                return $updatedGrant
            }
        } catch {
            Write-Error "Failed to revoke permissions from $($resolvedClient.Name): $($_.Exception.Message)" -ErrorAction Stop
            return
        }
        
    }
}