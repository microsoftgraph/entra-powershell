# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

function Add-EntraBetaRedirectURIToAgentIdentityBlueprint {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false, HelpMessage = "The redirect URI to add to the Agent Identity Blueprint.")]
        [ValidateNotNullOrEmpty()]
        [string]$RedirectUri = "http://localhost",

        [Parameter(Mandatory = $false, HelpMessage = "The ID of the Agent Identity Blueprint to configure.")]
        [ValidateNotNullOrEmpty()]
        [string]$AgentBlueprintId
    )

    begin {
        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes Application.Read.All' to authenticate."
            Write-Error -Message $errorMessage -ErrorAction Stop
            return
        }

        # Use stored blueprint ID if not provided
        if (-not $AgentBlueprintId) {
            if (-not $script:CurrentAgentBlueprintId) {
                Write-Error "No Agent Blueprint ID available. Please create a blueprint first using New-MsIdAgentIdentityBlueprint or provide an explicit AgentBlueprintId parameter."
                return
            }
            $AgentBlueprintId = $script:CurrentAgentBlueprintId
            Write-Verbose "Using stored Agent Blueprint ID: $AgentBlueprintId"
        }
        else {
            Write-Verbose "Using provided Agent Blueprint ID: $AgentBlueprintId"
        }
    }

    process {
        $customHeaders = $null
        $baseUri = '/beta/applications'

        try {
            $ApiUrl = "$baseUri/$AgentBlueprintId"
            Write-Verbose "Adding web redirect URI to Agent Identity Blueprint..."
            Write-Verbose "Agent Blueprint ID: $AgentBlueprintId"
            Write-Verbose "Redirect URI: $RedirectUri"

            # First, get the current application configuration to preserve existing redirect URIs
            Write-Verbose "Retrieving current application configuration..."

            $retryCount = 0
            $maxRetries = 10
            $currentApp = $null
            $success = $false

            while ($retryCount -lt $maxRetries -and -not $success) {
                if ($retryCount -eq 0) {
                    $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
                }
                else {
                    $customHeaders = $null
                }

                try {
                    $currentApp = Invoke-MgGraphRequest -Headers $customHeaders -Method GET -Uri $ApiUrl -ErrorAction Stop
                    $success = $true
                }
                catch {
                    $retryCount++
                    if ($retryCount -lt $maxRetries) {
                        Write-Verbose "Waiting for propagation..."
                        Write-Verbose "Attempt $retryCount failed. Waiting 10 seconds before retry..."
                        Start-Sleep -Seconds 10
                    }
                    else {
                        Write-Error "Failed to retrieve application configuration after $maxRetries attempts: $_"
                        throw
                    }
                }
            }

            # Get existing redirect URIs or initialize empty array
            $existingRedirectUris = @()
            if ($currentApp.web -and $currentApp.web.redirectUris) {
                $existingRedirectUris = $currentApp.web.redirectUris
            }

            # Check if the redirect URI already exists
            if ($existingRedirectUris -contains $RedirectUri) {
                Write-Host "Redirect URI '$RedirectUri' already exists in the application" -ForegroundColor Yellow

                $result = [PSCustomObject]@{
                    AgentBlueprintId = $AgentBlueprintId
                    RedirectUri      = $RedirectUri
                    Action           = "Already Exists"
                    AllRedirectUris  = $existingRedirectUris
                    ConfiguredAt     = Get-Date
                }

                return $result
            }

            # Add the new redirect URI to the existing ones
            $updatedRedirectUris = $existingRedirectUris + $RedirectUri

            # Build the request body to update the web redirect URIs
            $Body = [PSCustomObject]@{
                web = [PSCustomObject]@{
                    redirectUris = $updatedRedirectUris
                }
            }
            $JsonBody = $Body | ConvertTo-Json -Depth 5
            Write-Debug "Request Body: $JsonBody"

            # Use Invoke-MgGraphRequest to update the application with retry logic
            $retryCount = 0
            $maxRetries = 10
            $updateResult = $null
            $success = $false

            while ($retryCount -lt $maxRetries -and -not $success) {
                try {
                    $updateResult = Invoke-MgGraphRequest -Method PATCH -Uri $ApiUrl -Body $JsonBody -ErrorAction Stop
                    $success = $true
                }
                catch {
                    $retryCount++
                    if ($retryCount -lt $maxRetries) {
                        Write-Verbose "Waiting for propagation..."
                        Write-Verbose "Attempt $retryCount failed. Waiting 10 seconds before retry..."
                        Start-Sleep -Seconds 10
                    }
                    else {
                        Write-Error "Failed to update redirect URI after $maxRetries attempts: $_"
                        throw
                    }
                }
            }

            Write-Host "Successfully added web redirect URI to Agent Identity Blueprint" -ForegroundColor Green
            Write-Verbose "Total redirect URIs: $($updatedRedirectUris.Count)"

            # Create a result object with redirect URI information
            $result = [PSCustomObject]@{
                AgentBlueprintId = $AgentBlueprintId
                RedirectUri      = $RedirectUri
                Action           = "Added"
                AllRedirectUris  = $updatedRedirectUris
                ConfiguredAt     = Get-Date
                ApiResponse      = $updateResult
            }

            return $result
        }
        catch {
            Write-Error "Failed to add redirect URI to Agent Identity Blueprint: $_"
            if ($_.Exception.Response) {
                Write-Debug "Response Status: $($_.Exception.Response.StatusCode)"
                if ($_.Exception.Response.Content) {
                    Write-Debug "Response Content: $($_.Exception.Response.Content)"
                }
            }
            throw
        }
    }
}
