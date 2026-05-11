# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

function Add-EntraScopeToAgentIdentityBlueprint {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false, HelpMessage = "The ID of the Agent Identity Blueprint to add the scope to.")]
        [ValidateNotNullOrEmpty()]
        [string]$AgentBlueprintId,

        [Parameter(Mandatory = $false, HelpMessage = "The admin consent description for the scope.")]
        [ValidateNotNullOrEmpty()]
        [string]$AdminConsentDescription,

        [Parameter(Mandatory = $false, HelpMessage = "The admin consent display name for the scope.")]
        [ValidateNotNullOrEmpty()]
        [string]$AdminConsentDisplayName,

        [Parameter(Mandatory = $false, HelpMessage = "The value of the permission scope (used in token claims).")]
        [ValidateNotNullOrEmpty()]
        [string]$Value
    )

    begin {
        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes AgentIdentityBlueprint.UpdateAuthProperties.All' to authenticate."
            Write-Error -Message $errorMessage -ErrorAction Stop
            return
        }

        # Use stored blueprint ID if not provided
        if ([string]::IsNullOrEmpty($AgentBlueprintId)) {
            if ((Test-Path variable:script:CurrentAgentBlueprintId) -and -not [string]::IsNullOrEmpty($script:CurrentAgentBlueprintId)) {
                $AgentBlueprintId = $script:CurrentAgentBlueprintId
                Write-Verbose "Using stored Agent Identity Blueprint ID: $AgentBlueprintId"
            }
            else {
                $AgentBlueprintId = Read-Host "Enter the Agent Identity Blueprint ID"
                if ([string]::IsNullOrEmpty($AgentBlueprintId) -or $AgentBlueprintId.Trim() -eq "") {
                    Write-Error "No Agent Identity Blueprint ID available. Please create a blueprint first using New-EntraAgentIdentityBlueprint or provide an explicit AgentBlueprintId parameter." -ErrorAction Stop
                    return
                }
                $AgentBlueprintId = $AgentBlueprintId.Trim()
            }
        }
        else {
            Write-Verbose "Using provided Agent Identity Blueprint ID: $AgentBlueprintId"
        }

        # Prompt for missing parameters
        if (-not $AdminConsentDescription -or $AdminConsentDescription.Trim() -eq "") {
            $defaultDescription = "Allow the agent to act on behalf of the signed-in user"
            $userInput = Read-Host "Enter the admin consent description for the scope (press Enter to use '$defaultDescription')"
            if ($userInput -and $userInput.Trim() -ne "") {
                $AdminConsentDescription = $userInput.Trim()
            } else {
                $AdminConsentDescription = $defaultDescription
            }
        }

        if (-not $AdminConsentDisplayName -or $AdminConsentDisplayName.Trim() -eq "") {
            $defaultDisplayName = "Access agent on behalf of user"
            $userInput = Read-Host "Enter the admin consent display name for the scope (press Enter to use '$defaultDisplayName')"
            if ($userInput -and $userInput.Trim() -ne "") {
                $AdminConsentDisplayName = $userInput.Trim()
            } else {
                $AdminConsentDisplayName = $defaultDisplayName
            }
        }

        if (-not $Value -or $Value.Trim() -eq "") {
            $defaultValue = "access_agent_as_user"
            $userInput = Read-Host "Enter the scope value (used in token claims, press Enter to use '$defaultValue')"
            if ($userInput -and $userInput.Trim() -ne "") {
                $Value = $userInput.Trim()
            } else {
                $Value = $defaultValue
            }
        }
    }

    process {
        $customHeaders = $null
        $baseUri = '/v1.0/applications'

        try {
            Write-Verbose "Adding OAuth2 permission scope to Agent Blueprint: $AgentBlueprintId"
            Write-Verbose "Scope Details:"
            Write-Verbose "  Description: $AdminConsentDescription"
            Write-Verbose "  Display Name: $AdminConsentDisplayName"
            Write-Verbose "  Value: $Value"

            # Fetch existing application to preserve current scopes
            $existingApp = Invoke-MgGraphRequest -Method GET -Uri "$baseUri/$AgentBlueprintId" -ErrorAction Stop
            $existingScopes = @()
            if ($existingApp.api -and $existingApp.api.oauth2PermissionScopes) {
                $existingScopes = @($existingApp.api.oauth2PermissionScopes)
                Write-Verbose "Found $($existingScopes.Count) existing OAuth2 permission scope(s)"
            }

            # Check if a scope with the same value already exists
            $duplicateScope = $existingScopes | Where-Object { $_.value -eq $Value }
            if ($duplicateScope) {
                Write-Warning "A scope with value '$Value' already exists (ID: $($duplicateScope.id)). Skipping."
                $result = [PSCustomObject]@{
                    ScopeId = $duplicateScope.id
                    AdminConsentDescription = $duplicateScope.adminConsentDescription
                    AdminConsentDisplayName = $duplicateScope.adminConsentDisplayName
                    Value = $duplicateScope.value
                    IdentifierUri = "api://$AgentBlueprintId"
                    AgentBlueprintId = $AgentBlueprintId
                    FullScopeReference = "api://$AgentBlueprintId/$($duplicateScope.value)"
                }
                return $result
            }

            # Generate a new GUID for the scope ID
            $generatedScopeId = [System.Guid]::NewGuid().ToString()

            # Build the new scope and merge with existing scopes
            $newScope = [PSCustomObject]@{
                adminConsentDescription = $AdminConsentDescription
                adminConsentDisplayName = $AdminConsentDisplayName
                id = $generatedScopeId
                isEnabled = $true
                type = "User"
                value = $Value
            }
            $mergedScopes = @($existingScopes) + @($newScope)

            # Build the request body with merged scopes
            $Body = [PSCustomObject]@{
                identifierUris = @("api://$AgentBlueprintId")
                api = [PSCustomObject]@{
                    oauth2PermissionScopes = $mergedScopes
                }
            }

            $JsonBody = $Body | ConvertTo-Json -Depth 5
            Write-Debug "Request Body: $JsonBody"

            # Use Invoke-MgGraphRequest to update the application with retry logic
            $retryCount = 0
            $maxRetries = 10
            $success = $false

            while ($retryCount -lt $maxRetries -and -not $success) {
                if ($retryCount -eq 0) {
                    $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
                }
                else {
                    $customHeaders = $null
                }

                try {
                    Invoke-MgGraphRequest -Headers $customHeaders -Method PATCH -Uri "$baseUri/$AgentBlueprintId" -Body $JsonBody -ErrorAction Stop | Out-Null
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
                        Write-Error "Failed to add OAuth2 permission scope after $maxRetries attempts: $_"
                        throw
                    }
                }
            }

            Write-Host "Successfully added OAuth2 permission scope to Agent Blueprint" -ForegroundColor Green
            Write-Verbose "Generated Scope ID: $generatedScopeId"
            Write-Verbose "Identifier URI: api://$AgentBlueprintId"

            # Create a result object with scope information
            $result = [PSCustomObject]@{
                ScopeId = $generatedScopeId
                AdminConsentDescription = $AdminConsentDescription
                AdminConsentDisplayName = $AdminConsentDisplayName
                Value = $Value
                IdentifierUri = "api://$AgentBlueprintId"
                AgentBlueprintId = $AgentBlueprintId
                FullScopeReference = "api://$AgentBlueprintId/$Value"
            }

            return $result
        }
        catch {
            Write-Error "Failed to add OAuth2 permission scope to Agent Blueprint: $_"
            throw
        }
    }
}
