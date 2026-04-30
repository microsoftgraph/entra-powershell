# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

function Remove-EntraBetaAgentIdentityBlueprint {
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'High')]
    param (
        [Parameter(Mandatory = $true, HelpMessage = "The ID of the Agent Identity Blueprint to delete.")]
        [ValidateNotNullOrEmpty()]
        [string]$BlueprintId,

        [Parameter(Mandatory = $false, HelpMessage = "Suppress confirmation prompts.")]
        [switch]$Force
    )

    begin {
        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes AgentIdentityBlueprint.ReadWrite.All, AgentIdentity.DeleteRestore.All, AgentIdUser.ReadWrite.All' to authenticate."
            Write-Error -Message $errorMessage -ErrorAction Stop
            return
        }
    }

    process {
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand

        try {
            # First, retrieve the blueprint to confirm it exists and get its display name
            Write-Verbose "Retrieving Agent Identity Blueprint: $BlueprintId"
            $blueprintUri = "/beta/applications/microsoft.graph.agentIdentityBlueprint/$BlueprintId"
            $blueprint = Invoke-MgGraphRequest -Headers $customHeaders -Method GET -Uri $blueprintUri -ErrorAction Stop
            $blueprintDisplayName = $blueprint.displayName

            if (-not ($Force -or $PSCmdlet.ShouldProcess("Agent Identity Blueprint '$blueprintDisplayName' ($BlueprintId) and all its Agent Identities and Agent Users", "Delete"))) {
                return
            }

            $deletedIdentities = @()
            $deletedUsers = @()

            # Step 1: Find all Agent Identities for this blueprint
            Write-Host "Looking up Agent Identities for Blueprint '$blueprintDisplayName'..." -ForegroundColor Cyan
            $identityUri = "/beta/servicePrincipals/microsoft.graph.agentIdentity?`$filter=agentIdentityBlueprintId eq '$BlueprintId'"
            $allAgentIdentities = @()

            do {
                $response = Invoke-MgGraphRequest -Method GET -Uri $identityUri -ErrorAction Stop
                if ($response -and $response.value) {
                    $allAgentIdentities += @($response.value)
                }
                $identityUri = if ($response.ContainsKey('@odata.nextLink')) { $response.'@odata.nextLink' } else { $null }
            } while ($identityUri)

            if ($allAgentIdentities.Count -gt 0) {
                Write-Host "Found $($allAgentIdentities.Count) Agent Identity(ies)." -ForegroundColor Cyan

                # Step 2: For each Agent Identity, delete its Agent Users first
                foreach ($agentIdentity in $allAgentIdentities) {
                    $agentIdValue = $agentIdentity.id
                    $agentDisplayName = $agentIdentity.displayName

                    # Find and delete Agent Users for this identity
                    Write-Verbose "Looking up Agent Users for Agent Identity: $agentIdValue"
                    $userUri = "/beta/users/microsoft.graph.agentUser?`$filter=identityParentId eq '$agentIdValue'"
                    try {
                        $userResponse = Invoke-MgGraphRequest -Method GET -Uri $userUri -ErrorAction Stop
                        $agentUsers = @()
                        if ($userResponse -and $userResponse.value) {
                            $agentUsers = @($userResponse.value)
                        }

                        foreach ($user in $agentUsers) {
                            try {
                                Write-Verbose "Deleting Agent User '$($user.displayName)' ($($user.id))..."
                                $deleteUserUri = "/beta/users/$($user.id)"
                                Invoke-MgGraphRequest -Method DELETE -Uri $deleteUserUri -ErrorAction Stop
                                Write-Host "  Deleted Agent User '$($user.displayName)' ($($user.id))." -ForegroundColor Yellow
                                $deletedUsers += @{
                                    Id              = $user.id
                                    DisplayName     = $user.displayName
                                    AgentIdentityId = $agentIdValue
                                    Type            = "AgentUser"
                                }
                            }
                            catch {
                                Write-Warning "Failed to delete Agent User '$($user.displayName)' ($($user.id)): $_"
                            }
                        }
                    }
                    catch {
                        Write-Warning "Could not query Agent Users for Agent Identity '$agentIdValue': $_"
                    }

                    # Step 3: Delete the Agent Identity itself
                    try {
                        Write-Verbose "Deleting Agent Identity '$agentDisplayName' ($agentIdValue)..."
                        $deleteIdentityUri = "/beta/servicePrincipals/$agentIdValue"
                        Invoke-MgGraphRequest -Method DELETE -Uri $deleteIdentityUri -ErrorAction Stop
                        Write-Host "  Deleted Agent Identity '$agentDisplayName' ($agentIdValue)." -ForegroundColor Yellow
                        $deletedIdentities += @{
                            Id          = $agentIdValue
                            DisplayName = $agentDisplayName
                            Type        = "AgentIdentity"
                        }
                    }
                    catch {
                        Write-Warning "Failed to delete Agent Identity '$agentDisplayName' ($agentIdValue): $_"
                    }
                }
            }
            else {
                Write-Host "No Agent Identities found for this blueprint." -ForegroundColor Cyan
            }

            # Step 4: Delete the blueprint itself
            Write-Verbose "Deleting Agent Identity Blueprint '$blueprintDisplayName' ($BlueprintId)..."
            $deleteBlueprintUri = "/beta/applications/$BlueprintId"
            Invoke-MgGraphRequest -Method DELETE -Uri $deleteBlueprintUri -ErrorAction Stop
            Write-Host "Deleted Agent Identity Blueprint '$blueprintDisplayName' ($BlueprintId)." -ForegroundColor Green

            return @{
                BlueprintId         = $BlueprintId
                BlueprintName       = $blueprintDisplayName
                DeletedIdentities   = $deletedIdentities
                DeletedUsers        = $deletedUsers
                Status              = "Deleted"
            }
        }
        catch {
            if ($_.Exception.Message -like "*404*" -or $_.Exception.Message -like "*NotFound*") {
                Write-Error "Agent Identity Blueprint '$BlueprintId' not found."
            }
            else {
                Write-Error "Failed to delete Agent Identity Blueprint: $_"
            }
            throw
        }
    }
}
