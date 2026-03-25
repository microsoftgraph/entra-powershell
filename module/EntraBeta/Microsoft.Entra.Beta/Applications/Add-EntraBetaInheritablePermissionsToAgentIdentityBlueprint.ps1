# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

function Add-EntraBetaInheritablePermissionsToAgentIdentityBlueprint {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false, HelpMessage = "The resource application ID.")]
        [ValidateNotNullOrEmpty()]
        [guid]$ResourceAppId = "00000003-0000-0000-c000-000000000000"
    )

    begin {
        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes AgentIdentityBlueprint.UpdateAuthProperties.All' to authenticate."
            Write-Error -Message $errorMessage -ErrorAction Stop
            return
        }

        # Check if we have a stored Agent Blueprint ID
        if (-not $script:CurrentAgentBlueprintId) {
            Write-Error "No Agent Blueprint ID available. Please create a blueprint first using New-EntraBetaAgentIdentityBlueprint."
            return
        }
    }

    process {
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
        $baseUri = '/beta/applications'
        $apiUrl = "$baseUri/microsoft.graph.agentIdentityBlueprint/$($script:CurrentAgentBlueprintId)/inheritablePermissions"
        $allResults = @()
        $firstIteration = $true
        $continueAdding = $true

        while ($continueAdding) {
            # Determine ResourceAppId for this iteration
            if ($firstIteration -and $PSBoundParameters.ContainsKey('ResourceAppId')) {
                $currentResourceAppId = $ResourceAppId
            } else {
                $resourceInput = Read-Host "Enter the Resource Application ID (press Enter to use Microsoft Graph: 00000003-0000-0000-c000-000000000000)"
                if ($resourceInput -and $resourceInput.Trim() -ne "") {
                    try {
                        $currentResourceAppId = [guid]$resourceInput.Trim()
                    } catch {
                        Write-Warning "Invalid GUID format. Skipping this entry."
                        $firstIteration = $false
                        continue
                    }
                } else {
                    $currentResourceAppId = [guid]"00000003-0000-0000-c000-000000000000"
                }
            }
            $firstIteration = $false

            # Determine resource name for display
            $resourceName = switch ($currentResourceAppId.ToString()) {
                "00000003-0000-0000-c000-000000000000" { "Microsoft Graph" }
                "00000002-0000-0000-c000-000000000000" { "Azure Active Directory Graph" }
                default { "Custom Resource ($currentResourceAppId)" }
            }

            try {
                Write-Verbose "Adding inheritable permissions to Agent Identity Blueprint..."
                Write-Verbose "Agent Blueprint ID: $($script:CurrentAgentBlueprintId)"
                Write-Verbose "Resource App ID: $currentResourceAppId ($resourceName)"
                Write-Verbose "Inheritable scopes: All allowed"

                # Check for existing inheritable permissions on the blueprint
                Write-Verbose "Retrieving existing inheritable permissions..."
                $existingPermissions = $null
                try {
                    $existingPermissions = Invoke-MgGraphRequest -Headers $customHeaders -Method GET -Uri $apiUrl -ErrorAction Stop
                    $customHeaders = $null
                }
                catch {
                    Write-Verbose "Could not retrieve existing permissions (may be none yet): $_"
                    $existingPermissions = $null
                    $customHeaders = $null
                }

                # Build the inheritable scopes body
                $inheritableScopesBody = [PSCustomObject]@{
                    "@odata.type" = "#microsoft.graph.allAllowedScopes"
                    kind          = "allAllowed"
                }

                # Determine if an entry for this resourceAppId already exists
                $existingEntry = $null
                if ($existingPermissions -and $existingPermissions.value) {
                    $existingEntry = $existingPermissions.value | Where-Object { $_.resourceAppId -eq $currentResourceAppId.ToString() } | Select-Object -First 1
                }

                $Body = [PSCustomObject]@{
                    resourceAppId     = $currentResourceAppId.ToString()
                    inheritableScopes = $inheritableScopesBody
                }
                $JsonBody = $Body | ConvertTo-Json -Depth 5
                Write-Debug "Request Body: $JsonBody"

                $result = $null
                $success = $false
                $retryCount = 0
                $maxRetries = 10

                if ($existingEntry) {
                    # Overwrite the existing entry for this resourceAppId
                    Write-Verbose "Existing inheritable permissions found for resource '$resourceName' — overwriting..."
                    $patchUrl = "$apiUrl/$($currentResourceAppId.ToString())"
                    Write-Debug "PATCH URL: $patchUrl"

                    while ($retryCount -lt $maxRetries -and -not $success) {
                        try {
                            $result = Invoke-MgGraphRequest -Method PATCH -Uri $patchUrl -Body $JsonBody -ErrorAction Stop
                            $success = $true
                        }
                        catch {
                            $retryCount++
                            if ($retryCount -lt $maxRetries) {
                                Write-Verbose "Attempt $retryCount failed. Waiting 10 seconds before retry..."
                                Start-Sleep -Seconds 10
                            }
                            else {
                                Write-Error "Failed to update inheritable permissions after $maxRetries attempts: $_"
                                throw
                            }
                        }
                    }
                }
                else {
                    # No existing entry for this resourceAppId — add it (preserves other resources' permissions)
                    Write-Verbose "No existing inheritable permissions for resource '$resourceName' — adding..."
                    Write-Debug "POST URL: $apiUrl"

                    while ($retryCount -lt $maxRetries -and -not $success) {
                        try {
                            $result = Invoke-MgGraphRequest -Method POST -Uri $apiUrl -Body $JsonBody -ErrorAction Stop
                            $success = $true
                        }
                        catch {
                            $retryCount++
                            if ($retryCount -lt $maxRetries) {
                                Write-Verbose "Attempt $retryCount failed. Waiting 10 seconds before retry..."
                                Start-Sleep -Seconds 10
                            }
                            else {
                                Write-Error "Failed to add inheritable permissions after $maxRetries attempts: $_"
                                throw
                            }
                        }
                    }
                }

                Write-Host "Successfully added inheritable permissions for '$resourceName'." -ForegroundColor Green

                $permissionResult = [PSCustomObject]@{
                    AgentBlueprintId  = $script:CurrentAgentBlueprintId
                    ResourceAppId     = $currentResourceAppId
                    ResourceAppName   = $resourceName
                    InheritableScopes = "allAllowed"
                    ConfiguredAt      = Get-Date
                    ApiResponse       = $result
                }
                $allResults += $permissionResult
            }
            catch {
                Write-Error "Failed to add inheritable permissions: $_"
                if ($_.Exception.PSObject.Properties.Match('Response').Count -gt 0 -and $_.Exception.Response) {
                    Write-Debug "Response Status: $($_.Exception.Response.StatusCode)"
                    if ($_.Exception.Response.Content) {
                        Write-Debug "Response Content: $($_.Exception.Response.Content)"
                    }
                }
            }

            # Ask to add another resource app ID
            do {
                $moreResponse = Read-Host "Add inheritable permissions for another resource app? (y/n)"
                $moreResponse = $moreResponse.Trim().ToLower()
            } while ($moreResponse -ne "y" -and $moreResponse -ne "n" -and $moreResponse -ne "yes" -and $moreResponse -ne "no")
            $continueAdding = ($moreResponse -eq "y" -or $moreResponse -eq "yes")
        }

        Write-Host "Permissions are now available for inheritance by agent blueprints." -ForegroundColor Green
        return $allResults
    }
}
