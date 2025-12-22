# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

function Add-EntraBetaScopeToAgentIdentityBlueprint {
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
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes Application.ReadWrite.All' to authenticate."
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

        # Prompt for missing parameters
        if (-not $AdminConsentDescription -or $AdminConsentDescription.Trim() -eq "") {
            $defaultDescription = "Allow the agent to act on behalf of the signed-in user"
            Write-Host "Default: $defaultDescription" -ForegroundColor Gray
            $userInput = Read-Host "Enter the admin consent description for the scope (press Enter for default)"
            if ($userInput -and $userInput.Trim() -ne "") {
                $AdminConsentDescription = $userInput.Trim()
            } else {
                $AdminConsentDescription = $defaultDescription
                Write-Host "Using default: $AdminConsentDescription" -ForegroundColor Cyan
            }
        }

        if (-not $AdminConsentDisplayName -or $AdminConsentDisplayName.Trim() -eq "") {
            $defaultDisplayName = "Access agent on behalf of user"
            Write-Host "Default: $defaultDisplayName" -ForegroundColor Gray
            $userInput = Read-Host "Enter the admin consent display name for the scope (press Enter for default)"
            if ($userInput -and $userInput.Trim() -ne "") {
                $AdminConsentDisplayName = $userInput.Trim()
            } else {
                $AdminConsentDisplayName = $defaultDisplayName
                Write-Host "Using default: $AdminConsentDisplayName" -ForegroundColor Cyan
            }
        }

        if (-not $Value -or $Value.Trim() -eq "") {
            $defaultValue = "access_agent_as_user"
            Write-Host "Default: $defaultValue" -ForegroundColor Gray
            $userInput = Read-Host "Enter the scope value (used in token claims, press Enter for default)"
            if ($userInput -and $userInput.Trim() -ne "") {
                $Value = $userInput.Trim()
            } else {
                $Value = $defaultValue
                Write-Host "Using default: $Value" -ForegroundColor Cyan
            }
        }
    }

    process {
        $customHeaders = $null
        $baseUri = '/beta/applications'

        try {
            Write-Verbose "Adding OAuth2 permission scope to Agent Blueprint: $AgentBlueprintId"
            Write-Verbose "Scope Details:"
            Write-Verbose "  Description: $AdminConsentDescription"
            Write-Verbose "  Display Name: $AdminConsentDisplayName"
            Write-Verbose "  Value: $Value"

            # Generate a new GUID for the scope ID
            $scopeId = [System.Guid]::NewGuid().ToString()

            # Build the request body
            $Body = [PSCustomObject]@{
                identifierUris = @("api://$AgentBlueprintId")
                api = [PSCustomObject]@{
                    oauth2PermissionScopes = @(
                        [PSCustomObject]@{
                            adminConsentDescription = $AdminConsentDescription
                            adminConsentDisplayName = $AdminConsentDisplayName
                            id = $scopeId
                            isEnabled = $true
                            type = "User"
                            value = $Value
                        }
                    )
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
                    $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
                }
                else {
                    $customHeaders = $null
                }

                try {
                    Invoke-MgGraphRequest -Headers $customHeaders -Method PATCH -Uri "$baseUri/$AgentBlueprintId" -Body $JsonBody -ErrorAction Stop
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
            Write-Verbose "Scope ID: $scopeId"
            Write-Verbose "Identifier URI: api://$AgentBlueprintId"

            # Create a result object with scope information
            $result = [PSCustomObject]@{
                ScopeId = $scopeId
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
