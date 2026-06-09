# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

function Add-EntraBetaRequiredResourceAccessToAgentIdentityBlueprint {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false, HelpMessage = "The ID of the Agent Identity Blueprint to add required resource access to.")]
        [ValidateNotNullOrEmpty()]
        [string]$AgentBlueprintId,

        [Parameter(Mandatory = $false, HelpMessage = "The resource application ID (default: Microsoft Graph).")]
        [ValidateNotNullOrEmpty()]
        [guid]$ResourceAppId = "00000003-0000-0000-c000-000000000000",

        [Parameter(Mandatory = $false, HelpMessage = "Array of resource access entries. Each entry should have 'id' (GUID) and 'type' ('Scope' or 'Role').")]
        [hashtable[]]$ResourceAccess,

        [Parameter(Mandatory = $false, HelpMessage = "Run in silent mode with no interactive prompts. Requires ResourceAppId and ResourceAccess to be provided.")]
        [switch]$Silent
    )

    begin {
        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes AgentIdentityBlueprint.ReadWrite.All' to authenticate."
            Write-Error -Message $errorMessage -ErrorAction Stop
            return
        }

        # Use provided ID, fall back to stored ID, or prompt
        if ([string]::IsNullOrEmpty($AgentBlueprintId)) {
            if ((Test-Path variable:script:CurrentAgentBlueprintId) -and $script:CurrentAgentBlueprintId) {
                $AgentBlueprintId = $script:CurrentAgentBlueprintId
                Write-Verbose "Using stored Agent Identity Blueprint ID: $AgentBlueprintId"
            } else {
                $AgentBlueprintId = Read-Host "Enter the Agent Identity Blueprint ID (object ID of the blueprint application)"
                if (-not $AgentBlueprintId -or $AgentBlueprintId.Trim() -eq "") {
                    Write-Error "No Agent Identity Blueprint ID provided. Please provide a blueprint ID or create one first using New-EntraBetaAgentIdentityBlueprint." -ErrorAction Stop
                    return
                }
                $AgentBlueprintId = $AgentBlueprintId.Trim()
            }
        } else {
            Write-Verbose "Using provided Agent Identity Blueprint ID: $AgentBlueprintId"
        }

        # Validate silent mode requirements
        if ($Silent) {
            if (-not $PSBoundParameters.ContainsKey('ResourceAccess') -or -not $ResourceAccess -or $ResourceAccess.Count -eq 0) {
                Write-Error "Silent mode requires the ResourceAccess parameter to be provided with at least one entry." -ErrorAction Stop
                return
            }
        }
    }

    process {
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
        $baseUri = '/beta/applications'
        $blueprintUri = "$baseUri/microsoft.graph.agentIdentityBlueprint/$AgentBlueprintId"
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
                        Write-EntraInputValidationLog -CmdletName 'Add-EntraBetaRequiredResourceAccessToAgentIdentityBlueprint' -ParameterName 'ResourceAppId' -InvalidValue $resourceInput -ExpectedPattern 'GUID format (xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx)' -Message 'Invalid GUID format for Resource Application ID'
                        Write-Warning "Invalid GUID format. Skipping this entry."
                        $firstIteration = $false
                        continue
                    }
                } else {
                    $currentResourceAppId = [guid]"00000003-0000-0000-c000-000000000000"
                }
            }

            # Determine resource name for display
            $resourceName = switch ($currentResourceAppId.ToString()) {
                "00000003-0000-0000-c000-000000000000" { "Microsoft Graph" }
                "00000002-0000-0000-c000-000000000000" { "Azure Active Directory Graph" }
                default { "Custom Resource ($currentResourceAppId)" }
            }

            try {
                Write-Verbose "Adding required resource access to Agent Identity Blueprint..."
                Write-Verbose "Agent Identity Blueprint ID: $AgentBlueprintId"
                Write-Verbose "Resource App ID: $currentResourceAppId ($resourceName)"

                # Look up available permissions from the service principal for the resource
                $availableScopes = @()
                $availableRoles = @()
                try {
                    $spResponse = Invoke-MgGraphRequest -Method GET `
                        -Uri "v1.0/servicePrincipals?`$filter=appId eq '$($currentResourceAppId.ToString())'&`$select=appRoles,oauth2PermissionScopes" `
                        -ErrorAction Stop
                    if ($spResponse.value -and $spResponse.value.Count -gt 0) {
                        $sp = $spResponse.value[0]
                        if ($sp.oauth2PermissionScopes) {
                            $availableScopes = $sp.oauth2PermissionScopes
                        }
                        if ($sp.appRoles) {
                            $availableRoles = $sp.appRoles
                        }
                    }
                } catch {
                    Write-Verbose "Could not look up service principal permissions: $_"
                }

                # Retrieve existing requiredResourceAccess from the blueprint
                $existingAccess = @()
                try {
                    $appResponse = Invoke-MgGraphRequest -Headers $customHeaders -Method GET `
                        -Uri "$baseUri/$AgentBlueprintId?`$select=requiredResourceAccess" `
                        -ErrorAction Stop
                    $customHeaders = $null
                    if ($appResponse.requiredResourceAccess) {
                        $existingAccess = @($appResponse.requiredResourceAccess)
                    }
                } catch {
                    Write-Verbose "Could not retrieve existing requiredResourceAccess (may be empty): $_"
                    $customHeaders = $null
                }

                # Build the resource access entries for this resource
                $resourceAccessEntries = @()

                if ($firstIteration -and $PSBoundParameters.ContainsKey('ResourceAccess') -and $ResourceAccess) {
                    # Use parameter-provided entries
                    foreach ($entry in $ResourceAccess) {
                        $resourceAccessEntries += @{
                            id   = $entry.id
                            type = $entry.type
                        }
                    }
                } else {
                    # Interactive: prompt user to add permissions
                    $continuePermissions = $true
                    while ($continuePermissions) {
                        # Ask for permission type
                        do {
                            $permType = Read-Host "Permission type: (S)cope for delegated permissions or (R)ole for application permissions"
                            $permType = $permType.Trim().ToLower()
                        } while ($permType -ne "s" -and $permType -ne "r" -and $permType -ne "scope" -and $permType -ne "role")

                        $isScope = ($permType -eq "s" -or $permType -eq "scope")
                        $permTypeName = if ($isScope) { "Scope" } else { "Role" }
                        $availablePerms = if ($isScope) { $availableScopes } else { $availableRoles }

                        if ($availablePerms.Count -gt 0) {
                            # Show available permissions and let user search/pick
                            $permId = $null
                            $permSearchLoop = $true
                            while ($permSearchLoop) {
                                $searchTerm = Read-Host "Enter a search term to filter available permissions (or press Enter to enter a GUID directly)"
                                if ($searchTerm -and $searchTerm.Trim() -ne "") {
                                    $filtered = @($availablePerms | Where-Object { $_.value -like "*$($searchTerm.Trim())*" })
                                    if ($filtered.Count -gt 0) {
                                        Write-Host "Matching permissions:" -ForegroundColor Cyan
                                        $index = 1
                                        foreach ($p in $filtered) {
                                            Write-Host "  $index. $($p.value) ($($p.id))" -ForegroundColor White
                                            $index++
                                        }
                                        $selection = Read-Host "Enter a number to select, or enter a GUID directly"
                                        $selNum = 0
                                        if ([int]::TryParse($selection, [ref]$selNum) -and $selNum -ge 1 -and $selNum -le $filtered.Count) {
                                            $selectedPerm = @($filtered)[$selNum - 1]
                                            $permId = $selectedPerm.id
                                            Write-Host "Selected: $($selectedPerm.value)" -ForegroundColor Green
                                        } else {
                                            $permId = $selection.Trim()
                                        }
                                        $permSearchLoop = $false
                                    } else {
                                        Write-Host "No matching permissions found for '$($searchTerm.Trim())'. Please try again." -ForegroundColor Yellow
                                    }
                                } else {
                                    $permId = Read-Host "Enter the permission GUID"
                                    $permSearchLoop = $false
                                }
                            }
                        } else {
                            $permId = Read-Host "Enter the permission GUID"
                        }

                        if ($permId -and $permId.Trim() -ne "") {
                            try {
                                $validGuid = [guid]$permId.Trim()
                                $resourceAccessEntries += @{
                                    id   = $validGuid.ToString()
                                    type = $permTypeName
                                }

                                # Resolve display name
                                $displayName = $permId.Trim()
                                $matchedPerm = $availablePerms | Where-Object { $_.id -eq $validGuid.ToString() } | Select-Object -First 1
                                if ($matchedPerm) { $displayName = $matchedPerm.value }
                                Write-Host "Added $permTypeName permission: $displayName ($($validGuid.ToString()))" -ForegroundColor Green
                            } catch {
                                Write-EntraInputValidationLog -CmdletName 'Add-EntraBetaRequiredResourceAccessToAgentIdentityBlueprint' -ParameterName 'PermissionId' -InvalidValue $permId -ExpectedPattern 'GUID format (xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx)' -Message "Invalid GUID format: $permId"
                                Write-Warning "Invalid GUID format: $permId"
                            }
                        }

                        # Ask to add more permissions for this resource
                        do {
                            $morePerms = Read-Host "Add another permission for '$resourceName'? (y/n)"
                            $morePerms = $morePerms.Trim().ToLower()
                        } while ($morePerms -ne "y" -and $morePerms -ne "n" -and $morePerms -ne "yes" -and $morePerms -ne "no")
                        $continuePermissions = ($morePerms -eq "y" -or $morePerms -eq "yes")
                    }
                }
                $firstIteration = $false

                if ($resourceAccessEntries.Count -eq 0) {
                    Write-Warning "No permissions specified for '$resourceName'. Skipping."
                } else {
                    # Merge with existing requiredResourceAccess
                    $existingEntry = $existingAccess | Where-Object { $_.resourceAppId -eq $currentResourceAppId.ToString() } | Select-Object -First 1

                    if ($existingEntry) {
                        # Merge new permissions into existing entry
                        $existingPerms = @()
                        if ($existingEntry.resourceAccess) {
                            $existingPerms = @($existingEntry.resourceAccess)
                        }
                        foreach ($newPerm in $resourceAccessEntries) {
                            $alreadyPresent = $existingPerms | Where-Object { $_.id -eq $newPerm.id -and $_.type -eq $newPerm.type } | Select-Object -First 1
                            if (-not $alreadyPresent) {
                                $existingPerms += $newPerm
                            }
                        }
                        # Update the entry in-place
                        $updatedAccess = @()
                        foreach ($entry in $existingAccess) {
                            if ($entry.resourceAppId -eq $currentResourceAppId.ToString()) {
                                $updatedAccess += @{
                                    resourceAppId  = $entry.resourceAppId
                                    resourceAccess = $existingPerms
                                }
                            } else {
                                $updatedAccess += $entry
                            }
                        }
                        $existingAccess = $updatedAccess
                    } else {
                        # Add new resource entry
                        $existingAccess += @{
                            resourceAppId  = $currentResourceAppId.ToString()
                            resourceAccess = $resourceAccessEntries
                        }
                    }

                    # Build the PATCH body with the full merged requiredResourceAccess
                    $Body = @{
                        requiredResourceAccess = $existingAccess
                    }
                    $JsonBody = $Body | ConvertTo-Json -Depth 5
                    Write-Debug "Request Body: $JsonBody"

                    # PATCH the blueprint application
                    $result = $null
                    $success = $false
                    $retryCount = 0
                    $maxRetries = 10

                    while ($retryCount -lt $maxRetries -and -not $success) {
                        try {
                            $result = Invoke-MgGraphRequest -Method PATCH -Uri $blueprintUri -Body $JsonBody -ErrorAction Stop
                            $success = $true
                        } catch {
                            $retryCount++
                            if ($retryCount -lt $maxRetries) {
                                Write-Verbose "Attempt $retryCount failed. Waiting 10 seconds before retry..."
                                Start-Sleep -Seconds 10
                            } else {
                                Write-Error "Failed to update required resource access after $maxRetries attempts: $_"
                                throw
                            }
                        }
                    }

                    Write-Host "Successfully added required resource access for '$resourceName'." -ForegroundColor Green

                    # Resolve permission display names for the result
                    $permissionDetails = @()
                    foreach ($perm in $resourceAccessEntries) {
                        $allPerms = @($availableScopes) + @($availableRoles)
                        $matched = $allPerms | Where-Object { $_.id -eq $perm.id } | Select-Object -First 1
                        $permissionDetails += [PSCustomObject]@{
                            Id          = $perm.id
                            Type        = $perm.type
                            DisplayName = if ($matched) { $matched.value } else { "(unknown)" }
                        }
                    }

                    $permissionResult = [PSCustomObject]@{
                        AgentBlueprintId = $AgentBlueprintId
                        ResourceAppId    = $currentResourceAppId
                        ResourceAppName  = $resourceName
                        Permissions      = $permissionDetails
                        ConfiguredAt     = Get-Date
                        ApiResponse      = $result
                    }
                    $allResults += $permissionResult
                }
            } catch {
                Write-Error "Failed to add required resource access: $_"
                if ($_.Exception.PSObject.Properties.Match('Response').Count -gt 0 -and $_.Exception.Response) {
                    Write-Debug "Response Status: $($_.Exception.Response.StatusCode)"
                    if ($_.Exception.Response.Content) {
                        Write-Debug "Response Content: $($_.Exception.Response.Content)"
                    }
                }
            }

            # Ask to add another resource (skip in silent mode)
            if ($Silent) {
                $continueAdding = $false
            }
            else {
                do {
                    $moreResponse = Read-Host "Add required resource access for another resource app? (y/n)"
                    $moreResponse = $moreResponse.Trim().ToLower()
                } while ($moreResponse -ne "y" -and $moreResponse -ne "n" -and $moreResponse -ne "yes" -and $moreResponse -ne "no")
                $continueAdding = ($moreResponse -eq "y" -or $moreResponse -eq "yes")
            }
        }

        Write-Host "Required resource access configuration complete." -ForegroundColor Green
        return $allResults
    }
}
