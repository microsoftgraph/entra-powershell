# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

function New-EntraBetaAgentIdentityBlueprintPrincipal {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$false, HelpMessage = "The Application ID of the Agent Identity Blueprint.")]
        [ValidateNotNullOrEmpty()]
        [string]$AgentBlueprintId
    )

    begin {
        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes 'AgentIdentityBlueprint.Create', 'AgentIdentityBlueprintPrincipal.Create', 'AgentIdentity.Create.All', 'AgentIdentityBlueprint.UpdateAuthProperties.All', 'AgentIdUser.ReadWrite.All' to authenticate."
            Write-Error -Message $errorMessage -ErrorAction Stop
            return
        }

        # Use provided ID or fall back to stored ID, then prompt if still missing
        if ([string]::IsNullOrEmpty($AgentBlueprintId)) {
            if ((Test-Path variable:script:CurrentAgentBlueprintId) -and $script:CurrentAgentBlueprintId) {
                $AgentBlueprintId = $script:CurrentAgentBlueprintId
                Write-Verbose "Using stored Agent Identity Blueprint ID: $AgentBlueprintId"
            }
            else {
                $AgentBlueprintId = Read-Host "Enter the Agent Identity Blueprint Application ID (AppId)"
                if ([string]::IsNullOrEmpty($AgentBlueprintId)) {
                    throw "No Agent Identity Blueprint ID provided. Please run New-EntraBetaAgentIdentityBlueprint first or provide the AgentBlueprintId parameter."
                }
            }
        }
        else {
            Write-Verbose "Using provided Agent Identity Blueprint ID: $AgentBlueprintId"
        }
    }

    process {
        $customHeaders = $null
        $baseUri = '/beta/servicePrincipals'
        
        try {
            Write-Verbose "Creating Agent Identity Blueprint Service Principal..."
            # Prepare the body for the service principal creation
            $body = @{
                appId = $AgentBlueprintId
            }
            $JsonBody = $body | ConvertTo-Json
            Write-Debug "Request Body: $JsonBody"

            # Create the service principal using the specialized endpoint with retry logic
            Write-Verbose "Making request to create service principal for Agent Blueprint: $AgentBlueprintId"

            $retryCount = 0
            $maxRetries = 10
            $servicePrincipalResponse = $null
            $success = $false

            while ($retryCount -lt $maxRetries -and -not $success) {
                if ($retryCount -eq 0) {
                    $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
                } 
                else {
                    $customHeaders = $null
                }

                try {
                    $servicePrincipalResponse = Invoke-MgGraphRequest -Headers $customHeaders -Uri "$baseUri/graph.agentIdentityBlueprintPrincipal" -Method POST -Body $JsonBody -ErrorAction Stop
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
                        Write-Error "Failed to create service principal after $maxRetries attempts: $_"
                        throw
                    }
                }
            }

            Write-Host "Successfully created Agent Identity Blueprint Service Principal" -ForegroundColor Green
            Write-Verbose "Service Principal ID: $($servicePrincipalResponse.id)"
            Write-Verbose "Service Principal App ID: $($servicePrincipalResponse.appId)"

            # Store the service principal ID in module-level variable for use by other functions
            $script:CurrentAgentBlueprintServicePrincipalId = $servicePrincipalResponse.id

            return $servicePrincipalResponse
        }
        catch {
            Write-Error "Failed to create Agent Identity Blueprint Service Principal: $_"
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
