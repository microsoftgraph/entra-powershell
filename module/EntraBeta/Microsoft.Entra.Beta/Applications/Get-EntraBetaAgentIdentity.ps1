# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

function Get-EntraBetaAgentIdentity {
    [CmdletBinding(DefaultParameterSetName = 'GetById')]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = "GetById", HelpMessage = "The ID of the Agent Identity to retrieve.")]
        [ValidateNotNullOrEmpty()]
        [string]$AgentId,

        [Parameter(Mandatory = $false, ParameterSetName = "GetByBlueprint", HelpMessage = "The ID of the Agent Identity Blueprint to list child agent identities for.")]
        [ValidateNotNullOrEmpty()]
        [string]$AgentIdentityBlueprintId
    )

    begin {
        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes Application.Read.All' to authenticate."
            Write-Error -Message $errorMessage -ErrorAction Stop
            return
        }

        # Resolve BlueprintId when using GetByBlueprint parameter set
        if ($PSCmdlet.ParameterSetName -eq 'GetByBlueprint' -and -not $AgentIdentityBlueprintId) {
            if ((Test-Path variable:script:CurrentAgentBlueprintId) -and $script:CurrentAgentBlueprintId) {
                $AgentIdentityBlueprintId = $script:CurrentAgentBlueprintId
                Write-Verbose "Using stored Agent Identity Blueprint ID: $AgentIdentityBlueprintId"
            } else {
                $AgentIdentityBlueprintId = Read-Host "Enter the Agent Identity Blueprint ID"
                if (-not $AgentIdentityBlueprintId -or $AgentIdentityBlueprintId.Trim() -eq "") {
                    Write-Error "No Agent Identity Blueprint ID provided. Please provide a blueprint ID or create one first using New-EntraBetaAgentIdentityBlueprint." -ErrorAction Stop
                    return
                }
                $AgentIdentityBlueprintId = $AgentIdentityBlueprintId.Trim()
            }
        }
    }

    process {
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand

        try {
            if ($PSCmdlet.ParameterSetName -eq 'GetByBlueprint') {
                Write-Verbose "Retrieving Agent Identities for Blueprint: $AgentIdentityBlueprintId"

                $uri = "/beta/servicePrincipals/microsoft.graph.agentIdentity?`$filter=agentIdentityBlueprintId eq '$AgentIdentityBlueprintId'"
                $allResults = @()

                do {
                    $response = Invoke-MgGraphRequest -Headers $customHeaders -Method GET -Uri $uri -ErrorAction Stop
                    $customHeaders = $null

                    if ($response.value) {
                        $allResults += $response.value
                    }

                    $uri = if ($response.ContainsKey('@odata.nextLink')) { $response.'@odata.nextLink' } else { $null }
                } while ($uri)

                Write-Verbose "Retrieved $($allResults.Count) Agent Identities for Blueprint"
                return $allResults
            }
            else {
                Write-Verbose "Retrieving Agent Identity: $AgentId"

                $uri = "/beta/servicePrincipals/microsoft.graph.agentIdentity/$AgentId"
                $result = Invoke-MgGraphRequest -Headers $customHeaders -Method GET -Uri $uri -ErrorAction Stop

                Write-Verbose "Successfully retrieved Agent Identity"
                return $result
            }
        }
        catch {
            if ($_.Exception.Message -like "*404*" -or $_.Exception.Message -like "*NotFound*") {
                if ($PSCmdlet.ParameterSetName -eq 'GetByBlueprint') {
                    Write-Error "Agent Identity Blueprint with ID '$AgentIdentityBlueprintId' not found, or it has no agent identities."
                } else {
                    Write-Error "Agent Identity with ID '$AgentId' not found."
                }
            }
            else {
                Write-Error "Failed to retrieve Agent Identity: $_"
            }
            throw
        }
    }
}
