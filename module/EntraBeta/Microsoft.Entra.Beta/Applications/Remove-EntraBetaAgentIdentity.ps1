# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

function Remove-EntraBetaAgentIdentity {
    [CmdletBinding(DefaultParameterSetName = 'ByAgentId', SupportsShouldProcess = $true, ConfirmImpact = 'High')]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = "ByAgentId", HelpMessage = "The ID of the Agent Identity to delete.")]
        [ValidateNotNullOrEmpty()]
        [string]$AgentId,

        [Parameter(Mandatory = $true, ParameterSetName = "ByBlueprintId", HelpMessage = "The ID of the Agent Identity Blueprint. All Agent Identities (and their Agent Users) for this blueprint will be deleted.")]
        [ValidateNotNullOrEmpty()]
        [string]$AgentIdentityBlueprintId,

        [Parameter(Mandatory = $false, HelpMessage = "Suppress confirmation prompts.")]
        [switch]$Force
    )

    begin {
        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes AgentIdentity.DeleteRestore.All, AgentIdUser.ReadWrite.All' to authenticate."
            Write-Error -Message $errorMessage -ErrorAction Stop
            return
        }
    }

    process {
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand

        try {
            if ($PSCmdlet.ParameterSetName -eq 'ByBlueprintId') {
                # Look up all Agent Identities for the blueprint
                Write-Verbose "Looking up Agent Identities for Blueprint: $AgentIdentityBlueprintId"
                $uri = "/beta/servicePrincipals/microsoft.graph.agentIdentity?`$filter=agentIdentityBlueprintId eq '$AgentIdentityBlueprintId'"
                $allAgentIdentities = @()

                do {
                    $response = Invoke-MgGraphRequest -Headers $customHeaders -Method GET -Uri $uri -ErrorAction Stop
                    $customHeaders = $null

                    if ($response.value) {
                        $allAgentIdentities += $response.value
                    }

                    $uri = if ($response.ContainsKey('@odata.nextLink')) { $response.'@odata.nextLink' } else { $null }
                } while ($uri)

                if ($allAgentIdentities.Count -eq 0) {
                    Write-Warning "No Agent Identities found for Blueprint '$AgentIdentityBlueprintId'."
                    return
                }

                Write-Verbose "Found $($allAgentIdentities.Count) Agent Identity(ies) for Blueprint '$AgentIdentityBlueprintId'"

                $results = @()
                foreach ($agentIdentity in $allAgentIdentities) {
                    $agentIdValue = $agentIdentity.id
                    $displayName = $agentIdentity.displayName

                    if ($Force -or $PSCmdlet.ShouldProcess("Agent Identity '$displayName' ($agentIdValue) and its Agent Users", "Delete")) {
                        # First, delete any associated Agent Users
                        $deletedUsers = @()
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
                                        Id          = $user.id
                                        DisplayName = $user.displayName
                                        Type        = "AgentUser"
                                    }
                                }
                                catch {
                                    Write-Warning "Failed to delete Agent User '$($user.displayName)' ($($user.id)): $_"
                                }
                            }
                        }
                        catch {
                            Write-Warning "Could not query Agent Users for '$agentIdValue': $_"
                        }

                        # Now delete the Agent Identity (service principal)
                        Write-Verbose "Deleting Agent Identity '$displayName' ($agentIdValue)..."
                        $deleteUri = "/beta/servicePrincipals/$agentIdValue"
                        Invoke-MgGraphRequest -Method DELETE -Uri $deleteUri -ErrorAction Stop
                        Write-Host "Deleted Agent Identity '$displayName' ($agentIdValue)." -ForegroundColor Green

                        $results += @{
                            Id                    = $agentIdValue
                            DisplayName           = $displayName
                            AgentIdentityBlueprintId = $AgentIdentityBlueprintId
                            DeletedAgentUsers     = $deletedUsers
                            Status                = "Deleted"
                        }
                    }
                }

                return $results
            }
            else {
                # Delete a single Agent Identity by ID
                Write-Verbose "Retrieving Agent Identity: $AgentId"
                $getUri = "/beta/servicePrincipals/microsoft.graph.agentIdentity/$AgentId"
                $agentIdentity = Invoke-MgGraphRequest -Headers $customHeaders -Method GET -Uri $getUri -ErrorAction Stop

                $displayName = $agentIdentity.displayName
                $blueprintId = $agentIdentity.agentIdentityBlueprintId

                if ($Force -or $PSCmdlet.ShouldProcess("Agent Identity '$displayName' ($AgentId) and its Agent Users", "Delete")) {
                    # First, delete any associated Agent Users
                    $deletedUsers = @()
                    Write-Verbose "Looking up Agent Users for Agent Identity: $AgentId"
                    $userUri = "/beta/users/microsoft.graph.agentUser?`$filter=identityParentId eq '$AgentId'"
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
                                    Id          = $user.id
                                    DisplayName = $user.displayName
                                    Type        = "AgentUser"
                                }
                            }
                            catch {
                                Write-Warning "Failed to delete Agent User '$($user.displayName)' ($($user.id)): $_"
                            }
                        }
                    }
                    catch {
                        Write-Warning "Could not query Agent Users for '$AgentId': $_"
                    }

                    # Now delete the Agent Identity (service principal)
                    Write-Verbose "Deleting Agent Identity '$displayName' ($AgentId)..."
                    $deleteUri = "/beta/servicePrincipals/$AgentId"
                    Invoke-MgGraphRequest -Method DELETE -Uri $deleteUri -ErrorAction Stop
                    Write-Host "Deleted Agent Identity '$displayName' ($AgentId)." -ForegroundColor Green

                    return @{
                        Id                    = $AgentId
                        DisplayName           = $displayName
                        AgentIdentityBlueprintId = $blueprintId
                        DeletedAgentUsers     = $deletedUsers
                        Status                = "Deleted"
                    }
                }
            }
        }
        catch {
            if ($_.Exception.Message -like "*404*" -or $_.Exception.Message -like "*NotFound*") {
                if ($PSCmdlet.ParameterSetName -eq 'ByBlueprintId') {
                    Write-Error "Agent Identity Blueprint '$AgentIdentityBlueprintId' not found, or it has no agent identities."
                } else {
                    Write-Error "Agent Identity '$AgentId' not found."
                }
            }
            else {
                Write-Error "Failed to delete Agent Identity: $_"
            }
            throw
        }
    }
}
