# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

function Get-EntraBetaAgentIdentityBlueprint {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false, HelpMessage = "The ID of the Agent Identity Blueprint to retrieve. If not provided, uses the stored blueprint ID or prompts for one.")]
        [ValidateNotNullOrEmpty()]
        [string]$BlueprintId
    )

    begin {
        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes Application.Read.All' to authenticate."
            Write-Error -Message $errorMessage -ErrorAction Stop
            return
        }

        # Resolve BlueprintId: explicit param → stored → prompt → error
        if (-not $BlueprintId) {
            if ((Test-Path variable:script:CurrentAgentBlueprintId) -and $script:CurrentAgentBlueprintId) {
                $BlueprintId = $script:CurrentAgentBlueprintId
                Write-Verbose "Using stored Agent Identity Blueprint ID: $BlueprintId"
            } else {
                $BlueprintId = Read-Host "Enter the Agent Identity Blueprint ID"
                if (-not $BlueprintId -or $BlueprintId.Trim() -eq "") {
                    Write-Error "No Agent Identity Blueprint ID provided. Please provide a blueprint ID or create one first using New-EntraBetaAgentIdentityBlueprint." -ErrorAction Stop
                    return
                }
                $BlueprintId = $BlueprintId.Trim()
            }
        } else {
            Write-Verbose "Using provided Agent Identity Blueprint ID: $BlueprintId"
        }
    }

    process {
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
        $baseUri = '/beta/applications'

        try {
            Write-Verbose "Retrieving Agent Identity Blueprint: $BlueprintId"

            $uri = "$baseUri/microsoft.graph.agentIdentityBlueprint/$BlueprintId"
            $result = Invoke-MgGraphRequest -Headers $customHeaders -Method GET -Uri $uri -ErrorAction Stop

            Write-Verbose "Successfully retrieved Agent Identity Blueprint"
            return $result
        }
        catch {
            if ($_.Exception.Message -like "*404*" -or $_.Exception.Message -like "*NotFound*") {
                Write-Error "Agent Identity Blueprint with ID '$BlueprintId' not found."
            }
            else {
                Write-Error "Failed to retrieve Agent Identity Blueprint: $_"
            }
            throw
        }
    }
}
