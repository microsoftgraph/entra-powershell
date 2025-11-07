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
        [ValidateSet('VisualStudioCode', 'VisualStudio', 'ChatGPT', 'ClaudeDesktop')]
        [string]$MCPClient,

        # Specifies the service principal ID for a custom MCP client. Must be a valid GUID.
        [Parameter(ParameterSetName = 'CustomClient', Mandatory = $true, HelpMessage = "Specify a service principal ID (GUID) for a custom MCP client to grant permissions to.")]
        [Parameter(ParameterSetName = 'CustomClientScopes', Mandatory = $true, HelpMessage = "Specify a service principal ID (GUID) for a custom MCP client to grant permissions to.")]
        [ValidatePattern('^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$')]
        [string]$MCPClientServicePrincipalId,

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
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes Application.ReadWrite.All, Directory.Read.All, DelegatedPermissionGrant.ReadWrite.All, ' to authenticate."
            Write-Error -Message $errorMessage -ErrorAction Stop
            return
        }

        function Get-ServicePrincipal([string]$appId, [string]$name) {
            $sp = Get-MgBetaServicePrincipal -Filter "appId eq '$appId'" -ErrorAction SilentlyContinue -Headers $customHeaders | Select-Object -First 1
            if (-not $sp) {
                Write-Verbose "Creating service principal for $name ..."
                $sp = New-MgBetaServicePrincipal -AppId $appId -Headers $customHeaders
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

        function Set-ExactScopes([string]$clientSpId, [string]$resourceSpId, [string[]]$targetScopes) {
            $targetString = ($targetScopes | Sort-Object -Unique) -join ' '
            $grant = Get-Grant -clientSpId $clientSpId -resourceSpId $resourceSpId | Select-Object -First 1

            if (-not $targetScopes -or $targetScopes.Count -eq 0) {
                if ($grant) {
                    Write-Verbose "Removing existing grant..."
                    Remove-MgBetaOauth2PermissionGrant -OAuth2PermissionGrantId $grant.Id -Confirm:$false -Headers $customHeaders
                }
                return $null
            }

            if (-not $grant) {
                Write-Verbose "Creating new permission grant..."
                $body = @{
                    clientId    = $clientSpId
                    resourceId  = $resourceSpId
                    consentType = "AllPrincipals"
                    scope       = $targetString
                }
                return (@(New-MgBetaOauth2PermissionGrant -BodyParameter $body -Headers $customHeaders)[0])
            }

            $currentScope = if ($grant.Scope) { $grant.Scope } else { "" }
            if ($currentScope -ceq $targetString) {
                Write-Verbose "Grant already has the correct scopes."
                return $grant
            }

            Write-Verbose "Updating existing permission grant..."
            Update-MgBetaOauth2PermissionGrant -OAuth2PermissionGrantId $grant.Id -BodyParameter @{ scope = $targetString } -Headers $customHeaders
            return Get-Grant -clientSpId $clientSpId -resourceSpId $resourceSpId
        }

        # Constants
        $resourceAppId = "e8c77dc2-69b3-43f4-bc51-3213c9d915b4"  # Microsoft MCP Server for Enterprise
        $predefinedClients = @{
            "VisualStudioCode"         = @{ Name = "Visual Studio Code"; AppId = "aebc6443-996d-45c2-90f0-388ff96faa56" }
            "VisualStudio"             = @{ Name = "Visual Studio"; AppId = "04f0c124-f2bc-4f59-8241-bf6df9866bbd" }
            "ChatGPT"                  = @{ Name = "Chat GPT"; AppId = "e0476654-c1d5-430b-ab80-70cbd947616a" }
            "ClaudeDesktop"            = @{ Name = "Claude Desktop"; AppId = "08ad6f98-a4f8-4635-bb8d-f1a3044760f0" }
        }

        function Resolve-MCPClient {
            param(
                [string]$MCPClient,
                [string]$CustomServicePrincipalId
            )

            # Process predefined MCP client
            if ($MCPClient) {
                if ($predefinedClients.ContainsKey($MCPClient)) {
                    $clientInfo = $predefinedClients[$MCPClient]
                    return @{
                        Name = $clientInfo.Name
                        AppId = $clientInfo.AppId
                        IsCustom = $false
                    }
                }
                else {
                    throw "Invalid MCP client: $MCPClient"
                }
            }

            # Process custom service principal ID
            if ($CustomServicePrincipalId) {
                return @{
                    Name = "Custom MCP Client"
                    AppId = $CustomServicePrincipalId
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
        $availableScopes = $resourceSp.Oauth2PermissionScopes | Where-Object IsEnabled | Select-Object -ExpandProperty Value
        if (-not $availableScopes) {
            throw "Resource app exposes no enabled delegated (user) scopes."
        }
        $availableScopes = $availableScopes | Sort-Object -Unique

        # Resolve MCP client
        $client = Resolve-MCPClient -MCPClient $MCPClient -CustomServicePrincipalId $MCPClientServicePrincipalId
        Write-Verbose "Resolved MCP client: $($client.Name)"

        # Get service principal for the resolved client
        try {
            $sp = Get-ServicePrincipal $client.AppId $client.Name
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
            Write-Host "Granting specific scopes: $($targetScopes -join ', ')" -ForegroundColor Cyan
        }
        else {
            # Grant all available scopes (default behavior)
            $targetScopes = $availableScopes
            Write-Host "Granting all available scopes: $($targetScopes -join ', ')" -ForegroundColor Cyan
        }

        # Apply the permission grant
        try {
            $grant = Set-ExactScopes -clientSpId $sp.Id -resourceSpId $resourceSp.Id -targetScopes $targetScopes
            
            if ($grant) {
                Write-Host "`n✓ Successfully granted permissions to $($client.Name)" -ForegroundColor Green
                Write-Host "  Grant ID: $($grant.Id)" -ForegroundColor Gray

                # Display granted scopes
                $grantedScopes = ($grant.Scope -split '\s+' | Where-Object { $_ }) | Sort-Object
                Write-Host "  Granted scopes:" -ForegroundColor Yellow
                $grantedScopes | ForEach-Object { Write-Host "    - $_" -ForegroundColor Green }
                
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