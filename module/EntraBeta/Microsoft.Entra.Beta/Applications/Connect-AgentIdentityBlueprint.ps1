# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

<#
.SYNOPSIS
Connects to Microsoft Graph using stored Agent Identity Blueprint credentials

.DESCRIPTION
Internal function that connects to Microsoft Graph using the stored client secret from
Add-EntraBetaClientSecretToAgentIdentityBlueprint and the stored blueprint ID and tenant ID

.NOTES
This is an internal function that requires:
- $script:CurrentAgentBlueprintId to be set (from New-EntraBetaAgentIdentityBlueprint)
- $script:LastClientSecret to be set (from Add-EntraBetaClientSecretToAgentIdentityBlueprint)
- $script:CurrentTenantId to be set (from Connect-EntraBetaEntraAsUser)
#>
function Connect-AgentIdentityBlueprint {
    [CmdletBinding()]
    param()

    begin {
        $context = Get-EntraContext
        if (-not $context) {
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes AgentIdentityBlueprint.ReadWrite.All' to authenticate."
            Write-Error -Message $errorMessage
            return $false
        }

        # Validate that we have the required stored values
        if (-not $script:CurrentAgentBlueprintId) {
            Write-Error "No Agent Identity Blueprint ID found. Please run New-EntraBetaAgentIdentityBlueprint first."
            return $false
        }

        if (-not $script:LastClientSecret) {
            Write-Error "No client secret found. Please run Add-EntraBetaClientSecretToAgentIdentityBlueprint first."
            return $false
        }
    }

    process {
        try {
            # Check if we need to disconnect from a different connection type
            $lastConnection = Get-Variable -Name 'LastSuccessfulConnection' -Scope Script -ValueOnly -ErrorAction SilentlyContinue
            if ($lastConnection -and $lastConnection -ne "AgentIdentityBlueprint") {
                Write-Host "Disconnecting from previous connection type: $lastConnection" -ForegroundColor Yellow
                Disconnect-Entra -ErrorAction SilentlyContinue
            }

            Write-Host "Connecting to Microsoft Graph using Agent Identity Blueprint credentials..." -ForegroundColor Yellow

            # Convert the stored client secret to a secure credential
            $ClientSecretCredential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $script:CurrentAgentBlueprintId, $script:LastClientSecret

            # Connect to Microsoft Graph using the blueprint's credentials
            Connect-Entra -TenantId $context.TenantId -ClientSecretCredential $ClientSecretCredential -ContextScope Process -NoWelcome

            $script:LastSuccessfulConnection = "AgentIdentityBlueprint"
            Write-Host "Successfully connected as Agent Identity Blueprint: $script:CurrentAgentBlueprintId" -ForegroundColor Green
            return $true
        }
        catch {
            Write-Error "Failed to connect to Microsoft Graph using Agent Identity Blueprint credentials: $_"
            return $false
        }
    }
}
