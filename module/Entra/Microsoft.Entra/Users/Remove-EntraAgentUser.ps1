# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

function Remove-EntraAgentUser {
    [CmdletBinding(DefaultParameterSetName = 'ByUserId', SupportsShouldProcess = $true, ConfirmImpact = 'High')]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = "ByUserId", HelpMessage = "The ID of the Agent User to delete.")]
        [ValidateNotNullOrEmpty()]
        [string]$AgentUserId,

        [Parameter(Mandatory = $true, ParameterSetName = "ByAgentId", HelpMessage = "The ID of the Agent Identity whose associated Agent User should be deleted.")]
        [ValidateNotNullOrEmpty()]
        [string]$AgentId,

        [Parameter(Mandatory = $false, HelpMessage = "Suppress confirmation prompts.")]
        [switch]$Force
    )

    begin {
        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes AgentIdUser.ReadWrite.All' to authenticate."
            Write-Error -Message $errorMessage -ErrorAction Stop
            return
        }
    }

    process {
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand

        try {
            if ($PSCmdlet.ParameterSetName -eq 'ByAgentId') {
                # Look up Agent Users for the given Agent Identity
                Write-Verbose "Looking up Agent Users for Agent Identity: $AgentId"
                $uri = "/v1.0/users/microsoft.graph.agentUser?`$filter=identityParentId eq '$AgentId'"
                $response = Invoke-MgGraphRequest -Headers $customHeaders -Method GET -Uri $uri -ErrorAction Stop
                $customHeaders = $null

                if (-not $response.value -or $response.value.Count -eq 0) {
                    Write-Warning "No Agent Users found for Agent Identity '$AgentId'."
                    return
                }

                $agentUsers = @($response.value)
                Write-Verbose "Found $($agentUsers.Count) Agent User(s) for Agent Identity '$AgentId'"

                $deletedUsers = @()
                foreach ($user in $agentUsers) {
                    $userId = $user.id
                    $displayName = $user.displayName

                    if ($Force -or $PSCmdlet.ShouldProcess("Agent User '$displayName' ($userId)", "Delete")) {
                        Write-Verbose "Deleting Agent User '$displayName' ($userId)..."
                        $deleteUri = "/v1.0/users/$userId"
                        Invoke-MgGraphRequest -Method DELETE -Uri $deleteUri -ErrorAction Stop
                        Write-Host "Deleted Agent User '$displayName' ($userId)." -ForegroundColor Green
                        $deletedUsers += @{
                            Id          = $userId
                            DisplayName = $displayName
                            AgentId     = $AgentId
                            Status      = "Deleted"
                        }
                    }
                }

                return $deletedUsers
            }
            else {
                # Delete by Agent User ID directly
                Write-Verbose "Retrieving Agent User: $AgentUserId"
                $getUri = "/v1.0/users/microsoft.graph.agentUser/$AgentUserId"
                $agentUser = Invoke-MgGraphRequest -Headers $customHeaders -Method GET -Uri $getUri -ErrorAction Stop

                $displayName = $agentUser.displayName
                $agentId = $agentUser.identityParentId

                if ($Force -or $PSCmdlet.ShouldProcess("Agent User '$displayName' ($AgentUserId)", "Delete")) {
                    Write-Verbose "Deleting Agent User '$displayName' ($AgentUserId)..."
                    $deleteUri = "/v1.0/users/$AgentUserId"
                    Invoke-MgGraphRequest -Method DELETE -Uri $deleteUri -ErrorAction Stop
                    Write-Host "Deleted Agent User '$displayName' ($AgentUserId)." -ForegroundColor Green

                    return @{
                        Id          = $AgentUserId
                        DisplayName = $displayName
                        AgentId     = $agentId
                        Status      = "Deleted"
                    }
                }
            }
        }
        catch {
            if ($_.Exception.Message -like "*404*" -or $_.Exception.Message -like "*NotFound*") {
                if ($PSCmdlet.ParameterSetName -eq 'ByAgentId') {
                    Write-Error "Agent Identity '$AgentId' not found, or it has no agent users."
                } else {
                    Write-Error "Agent User '$AgentUserId' not found."
                }
            }
            else {
                Write-Error "Failed to delete Agent User: $_"
            }
            throw
        }
    }
}
