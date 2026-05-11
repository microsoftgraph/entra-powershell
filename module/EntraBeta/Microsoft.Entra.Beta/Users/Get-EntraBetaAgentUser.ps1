# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

function Get-EntraBetaAgentUser {
    [CmdletBinding(DefaultParameterSetName = 'GetById')]
    param (
        [Parameter(Mandatory = $false, ParameterSetName = "GetById", HelpMessage = "The ID of the Agent User to retrieve. If not provided, uses the stored agent user ID or prompts for one.")]
        [ValidateNotNullOrEmpty()]
        [string]$AgentUserId,

        [Parameter(Mandatory = $true, ParameterSetName = "GetByAgentId", HelpMessage = "The ID of the Agent Identity to retrieve connected Agent Users for.")]
        [ValidateNotNullOrEmpty()]
        [string]$AgentId
    )

    begin {
        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes User.Read.All' to authenticate."
            Write-Error -Message $errorMessage -ErrorAction Stop
            return
        }

        # Resolve AgentUserId when using GetById parameter set
        if ($PSCmdlet.ParameterSetName -eq 'GetById' -and -not $AgentUserId) {
            if ((Test-Path variable:script:CurrentAgentUserId) -and $script:CurrentAgentUserId) {
                $AgentUserId = $script:CurrentAgentUserId
                Write-Verbose "Using stored Agent User ID: $AgentUserId"
            } else {
                $AgentUserId = Read-Host "Enter the Agent User ID"
                if (-not $AgentUserId -or $AgentUserId.Trim() -eq "") {
                    Write-Error "No Agent User ID provided. Please provide an ID or create one first using New-EntraBetaAgentUserForAgentId." -ErrorAction Stop
                    return
                }
                $AgentUserId = $AgentUserId.Trim()
            }
        } elseif ($PSCmdlet.ParameterSetName -eq 'GetById') {
            Write-Verbose "Using provided Agent User ID: $AgentUserId"
        }
    }

    process {
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand

        try {
            if ($PSCmdlet.ParameterSetName -eq 'GetByAgentId') {
                Write-Verbose "Retrieving Agent Users for Agent Identity: $AgentId"

                $uri = "/beta/users/microsoft.graph.agentUser?`$filter=identityParentId eq '$AgentId'"
                $allResults = @()

                do {
                    $response = Invoke-MgGraphRequest -Headers $customHeaders -Method GET -Uri $uri -ErrorAction Stop
                    $customHeaders = $null

                    if ($response.value) {
                        $allResults += $response.value
                    }

                    $uri = if ($response.ContainsKey('@odata.nextLink')) { $response.'@odata.nextLink' } else { $null }
                } while ($uri)

                Write-Verbose "Retrieved $($allResults.Count) Agent Users for Agent Identity"
                return $allResults
            }
            else {
                Write-Verbose "Retrieving Agent User: $AgentUserId"

                $uri = "/beta/users/microsoft.graph.agentUser/$AgentUserId"
                $result = Invoke-MgGraphRequest -Headers $customHeaders -Method GET -Uri $uri -ErrorAction Stop

                Write-Verbose "Successfully retrieved Agent User"
                return $result
            }
        }
        catch {
            if ($_.Exception.Message -like "*404*" -or $_.Exception.Message -like "*NotFound*") {
                if ($PSCmdlet.ParameterSetName -eq 'GetByAgentId') {
                    Write-Error "Agent Identity with ID '$AgentId' not found, or it has no agent users."
                } else {
                    Write-Error "Agent User with ID '$AgentUserId' not found."
                }
            }
            else {
                Write-Error "Failed to retrieve Agent User: $_"
            }
            throw
        }
    }
}
