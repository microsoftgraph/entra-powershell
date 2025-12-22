# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

function Add-EntraBetaInheritablePermissionsToAgentIdentityBlueprint {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false, HelpMessage = "Array of Microsoft Graph permission scopes to make inheritable.")]
        [ValidateNotNullOrEmpty()]
        [string[]]$Scopes,

        [Parameter(Mandatory = $false, HelpMessage = "The resource application ID.")]
        [ValidateNotNullOrEmpty()]
        [string]$ResourceAppId = "00000003-0000-0000-c000-000000000000"
    )

    begin {
        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes Application.Read.All' to authenticate."
            Write-Error -Message $errorMessage -ErrorAction Stop
            return
        }

        # Check if we have a stored Agent Blueprint ID
        if (-not $script:CurrentAgentBlueprintId) {
            Write-Error "No Agent Blueprint ID available. Please create a blueprint first using New-MsIdAgentIdentityBlueprint."
            return
        }

        # Prompt for ResourceAppId if not provided
        if (-not $ResourceAppId -or $ResourceAppId.Trim() -eq "") {
            Write-Host "Enter the Resource Application ID for the permissions." -ForegroundColor Cyan
            Write-Host "Default: 00000003-0000-0000-c000-000000000000 (Microsoft Graph)" -ForegroundColor Gray

            $resourceInput = Read-Host "Resource App ID (press Enter for Microsoft Graph default)"
            if ($resourceInput -and $resourceInput.Trim() -ne "") {
                $ResourceAppId = $resourceInput.Trim()
            }
            else {
                $ResourceAppId = "00000003-0000-0000-c000-000000000000"
                Write-Host "Using default: Microsoft Graph" -ForegroundColor Cyan
            }
        }

        # Prompt for scopes if not provided
        if (-not $Scopes) {
            Write-Host "Enter permission scopes to make inheritable for $resourceName." -ForegroundColor Cyan
            if ($ResourceAppId -eq "00000003-0000-0000-c000-000000000000") {
                Write-Host "Common Microsoft Graph scopes: User.Read, Mail.Read, Calendars.Read, Files.Read, etc." -ForegroundColor Gray
            }
            Write-Host "Enter multiple scopes separated by commas." -ForegroundColor Gray

            do {
                $scopeInput = Read-Host "Enter permission scopes (comma-separated)"
                if ($scopeInput -and $scopeInput.Trim() -ne "") {
                    $Scopes = $scopeInput.Split(',') | ForEach-Object { $_.Trim() } | Where-Object { $_ -ne "" }
                }
            } while (-not $Scopes -or $Scopes.Count -eq 0)
        }
    }

    process {
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
        $baseUri = '/beta/applications'
        $Method = "POST"

        # Determine resource name for display
        $resourceName = switch ($ResourceAppId) {
            "00000003-0000-0000-c000-000000000000" { "Microsoft Graph" }
            "00000002-0000-0000-c000-000000000000" { "Azure Active Directory Graph" }
            default { "Custom Resource ($ResourceAppId)" }
        }

        try {
            Write-Verbose "Adding inheritable permissions to Agent Identity Blueprint..."
            Write-Verbose "Agent Blueprint ID: $($script:CurrentAgentBlueprintId)"
            Write-Verbose "Resource App ID: $ResourceAppId ($resourceName)"
            Write-Verbose "Scopes to make inheritable:"
            foreach ($scope in $Scopes) {
                Write-Verbose "  - $scope"
            }

            # Build the request body
            $Body = [PSCustomObject]@{
                resourceAppId     = $ResourceAppId
                inheritableScopes = [PSCustomObject]@{
                    "@odata.type" = "microsoft.graph.enumeratedScopes"
                    scopes        = $Scopes
                }
            }

            $JsonBody = $Body | ConvertTo-Json -Depth 5
            Write-Debug "Request Body: $JsonBody"

            # Use Invoke-MgRestMethod to make the API call with the stored Agent Blueprint ID with retry logic
            $apiUrl = "$baseUri/microsoft.graph.agentIdentityBlueprint/$($script:CurrentAgentBlueprintId)/inheritablePermissions"
            Write-Debug "API URL: $apiUrl"

            $retryCount = 0
            $maxRetries = 10
            $result = $null
            $success = $false

            while ($retryCount -lt $maxRetries -and -not $success) {
                try {
                    $result = Invoke-MgGraphRequest -Headers $customHeaders -Method $Method -Uri $apiUrl -Body $JsonBody -ErrorAction Stop
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
                        Write-Error "Failed to add inheritable permissions after $maxRetries attempts: $_"
                        throw
                    }
                }
            }

            Write-Host "Successfully added inheritable permissions to Agent Identity Blueprints." -ForegroundColor Green
            Write-Host "Permissions are now available for inheritance by agent blueprints." -ForegroundColor Green

            # Store the scopes for use in other functions
            $script:LastConfiguredInheritableScopes = $Scopes

            # Create a result object with permission information
            $permissionResult = [PSCustomObject]@{
                AgentBlueprintId  = $script:CurrentAgentBlueprintId
                ResourceAppId     = $ResourceAppId
                ResourceAppName   = $resourceName
                InheritableScopes = $Scopes
                ScopeCount        = $Scopes.Count
                ConfiguredAt      = Get-Date
                ApiResponse       = $result
            }

            return $permissionResult
        }
        catch {
            Write-Error "Failed to add inheritable permissions: $_"
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
