# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

function Add-EntraPermissionsToInheritToAgentIdentityBlueprintPrincipal {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$false, HelpMessage = "The Application ID of the Agent Identity Blueprint.")]
        [ValidateNotNullOrEmpty()]
        [string]$AgentBlueprintId,

        [Parameter(Mandatory=$false, HelpMessage = "The delegated permission scopes to request consent for.")]
        [ValidateNotNullOrEmpty()]
        [string[]]$Scopes,

        [Parameter(Mandatory=$false, HelpMessage = "The application roles (app permissions) to request consent for.")]
        [ValidateNotNullOrEmpty()]
        [string[]]$Roles,

        [Parameter(Mandatory=$false, HelpMessage = "The redirect URI after consent.")]
        [ValidateNotNullOrEmpty()]
        [string]$RedirectUri = "https://entra.microsoft.com/TokenAuthorize",

        [Parameter(Mandatory=$false, HelpMessage = "State parameter for the consent request.")]
        [ValidateNotNullOrEmpty()]
        [string]$State
    )

    begin {
        # Ensure connection to Microsoft Entra
        $context = Get-EntraContext
        if (-not $context) {
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes AgentIdentityBlueprint.UpdateAuthProperties.All' to authenticate."
            Write-Error -Message $errorMessage -ErrorAction Stop
            return
        }

        # Use provided ID or fall back to stored ID, then prompt
        if ([string]::IsNullOrEmpty($AgentBlueprintId)) {
            if ((Test-Path variable:script:CurrentAgentBlueprintId) -and $script:CurrentAgentBlueprintId) {
                $AgentBlueprintId = $script:CurrentAgentBlueprintId
                Write-Verbose "Using stored Agent Identity Blueprint ID: $AgentBlueprintId"
            }
            else {
                $AgentBlueprintId = Read-Host "Enter the Agent Identity Blueprint ID"
                if ([string]::IsNullOrEmpty($AgentBlueprintId)) {
                    throw "No Agent Identity Blueprint ID provided. Please run New-EntraAgentIdentityBlueprint first or provide the AgentBlueprintId parameter."
                }
            }
        }
        else {
            Write-Verbose "Using provided Agent Identity Blueprint ID: $AgentBlueprintId"
        }

        # Prompt for scopes only if neither Scopes nor Roles were provided (fully interactive mode)
        if (-not $Scopes -and -not $Roles) {
            $suggestedScopes = @("user.read")  # Default fallback

            Write-Host "Enter permission scopes for admin consent." -ForegroundColor Cyan
            Write-Host "These scopes will be requested during the admin consent flow." -ForegroundColor Gray
            Write-Host "Suggested: $($suggestedScopes -join ', ')" -ForegroundColor Cyan
            Write-Host "You can edit these scopes before submitting." -ForegroundColor Gray

            # Pre-populate with suggested scopes and allow editing
            Write-Host "Current scopes: $($suggestedScopes -join ', ')" -ForegroundColor Cyan
            $userInput = Read-Host "Edit permission scopes (comma-separated, press Enter to use current)"
            if ($userInput -and $userInput.Trim() -ne "") {
                $Scopes = $userInput.Trim() -split ',\s*'
                Write-Host "Using edited scopes: $($Scopes -join ', ')" -ForegroundColor Cyan
            } else {
                $Scopes = $suggestedScopes
                Write-Host "Using suggested scopes: $($Scopes -join ', ')" -ForegroundColor Cyan
            }
        }
    }

    process {
        $tenantId = $context.TenantId

        # Generate a random state if not provided
        if (-not $State) {
            $State = "xyz$(Get-Random -Minimum 100 -Maximum 999999)"
        }

        try {
            Write-Host "Preparing admin consent page for Agent Identity Blueprint Principal..." -ForegroundColor Cyan
            # Build scope parameter from delegated scopes
            $encodedClientId = [System.Web.HttpUtility]::UrlEncode($AgentBlueprintId)
            $encodedRedirectUri = [System.Web.HttpUtility]::UrlEncode($RedirectUri)
            $encodedState = [System.Web.HttpUtility]::UrlEncode($State)

            # Build the admin consent URL
            $requestUri = "https://login.microsoftonline.com/$tenantId/v2.0/adminconsent" +
                "?client_id=$encodedClientId"

            if ($Scopes) {
                $stringifiedScopes = ($Scopes | ForEach-Object { $_.ToLower() }) -join " "
                $encodedScope = [System.Web.HttpUtility]::UrlEncode($stringifiedScopes)
                $requestUri += "&scope=$encodedScope"
            }

            if ($Roles) {
                $stringifiedRoles = ($Roles | ForEach-Object { $_.ToLower() }) -join " "
                $encodedRoles = [System.Web.HttpUtility]::UrlEncode($stringifiedRoles)
                $requestUri += "&role=$encodedRoles"
            }

            $requestUri += "&redirect_uri=$encodedRedirectUri" +
                "&state=$encodedState"

            Write-Verbose "Admin Consent Request Details:"
            Write-Verbose "  Client ID (Agent Blueprint): $AgentBlueprintId"
            Write-Verbose "  Tenant ID: $tenantId"
            Write-Verbose "  Requested Scopes: $($Scopes -join ', ')"
            Write-Verbose "  Requested Roles: $($Roles -join ', ')"
            Write-Verbose "  Redirect URI: $RedirectUri"
            Write-Verbose "  State: $State"
            Write-Verbose "  Consent URL: $requestUri"
            Write-Verbose ""

            # Launch the system browser with the consent URL
            try {
                Write-Host "Opening admin consent page in system browser..." -ForegroundColor Gray
                Start-Process $requestUri
                Write-Host "Admin consent page opened in browser successfully" -ForegroundColor Cyan
                Write-Host ""
                Write-Host "Please complete the admin consent process in the browser window." -ForegroundColor Yellow
                Write-Host "After consent is granted, the Agent Blueprint will be able to inherit the requested permissions." -ForegroundColor Yellow
            }
            catch {
                Write-Error "Error opening admin consent page in browser: $($_.Exception.Message)"
                Write-Host "You can manually copy and paste the above URL into your browser." -ForegroundColor Yellow
                throw
            }

            # Create a result object with consent information
            $consentResult = [PSCustomObject]@{
                AgentBlueprintId = $AgentBlueprintId
                TenantId = $tenantId
                RequestedScopes = $Scopes
                RequestedRoles = $Roles
                RedirectUri = $RedirectUri
                State = $State
                ConsentUrl = $requestUri
                Action = "Browser Launched"
                Timestamp = Get-Date
            }

            return $consentResult
        }
        catch {
            Write-Error "Failed to launch admin consent page for Agent Identity Blueprint Principal: $_"
            throw
        }
    }
}
