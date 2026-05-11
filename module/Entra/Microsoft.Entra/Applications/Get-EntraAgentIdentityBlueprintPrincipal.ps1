# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

function Get-EntraAgentIdentityBlueprintPrincipal {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false, HelpMessage = "The ID of the Agent Identity Blueprint Service Principal to retrieve. If not provided, uses the stored service principal ID or prompts for one.")]
        [ValidateNotNullOrEmpty()]
        [string]$ServicePrincipalId
    )

    begin {
        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes Application.Read.All' to authenticate."
            Write-Error -Message $errorMessage -ErrorAction Stop
            return
        }

        # Resolve ServicePrincipalId: explicit param → stored → prompt → error
        if (-not $ServicePrincipalId) {
            if ((Test-Path variable:script:CurrentAgentBlueprintServicePrincipalId) -and $script:CurrentAgentBlueprintServicePrincipalId) {
                $ServicePrincipalId = $script:CurrentAgentBlueprintServicePrincipalId
                Write-Verbose "Using stored Agent Blueprint Service Principal ID: $ServicePrincipalId"
            } else {
                $ServicePrincipalId = Read-Host "Enter the Agent Identity Blueprint Service Principal ID"
                if (-not $ServicePrincipalId -or $ServicePrincipalId.Trim() -eq "") {
                    Write-Error "No Service Principal ID provided. Please provide an ID or create one first using New-EntraAgentIdentityBlueprintPrincipal." -ErrorAction Stop
                    return
                }
                $ServicePrincipalId = $ServicePrincipalId.Trim()
            }
        } else {
            Write-Verbose "Using provided Service Principal ID: $ServicePrincipalId"
        }
    }

    process {
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
        $baseUri = '/v1.0/servicePrincipals'

        try {
            Write-Verbose "Retrieving Agent Identity Blueprint Service Principal: $ServicePrincipalId"

            $uri = "$baseUri/graph.agentIdentityBlueprintPrincipal/$ServicePrincipalId"
            $result = Invoke-MgGraphRequest -Headers $customHeaders -Method GET -Uri $uri -ErrorAction Stop

            Write-Verbose "Successfully retrieved Agent Identity Blueprint Service Principal"
            return $result
        }
        catch {
            if ($_.Exception.Message -like "*404*" -or $_.Exception.Message -like "*NotFound*") {
                Write-Error "Agent Identity Blueprint Service Principal with ID '$ServicePrincipalId' not found."
            }
            else {
                Write-Error "Failed to retrieve Agent Identity Blueprint Service Principal: $_"
            }
            throw
        }
    }
}
