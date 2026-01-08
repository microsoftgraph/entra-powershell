# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

function New-EntraBetaAgentIDUserForAgentId {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, HelpMessage = "The display name for the Agent User.")]
        [ValidateNotNullOrEmpty()]
        [string]$DisplayName,

        [Parameter(Mandatory = $false, HelpMessage = "The user principal name (email) for the Agent User e.g: username@domain.onmicrosoft.com.")]
        [ValidatePattern('^[#a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$', ErrorMessage = "UserPrincipalName must be a valid email address (e.g., user@domain.com)")]
        [string]$UserPrincipalName,

        [Parameter(Mandatory = $false, HelpMessage = "The Agent Identity ID to associate with this user. If not provided, uses the stored value from New-EntraBetaAgentIDForAgentIdentityBlueprint.")]
        [string]$AgentIdentityId
    )

    begin {
        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes 'AgentIdentityBlueprint.Create', 'AgentIdentityBlueprintPrincipal.Create', 'AppRoleAssignment.ReadWrite.All', 'AgentIdentityBlueprint.ReadWrite.All', 'User.ReadWrite.All' to authenticate."
            Write-Error -Message $errorMessage -ErrorAction Stop
            return
        }

        # Connect using Agent Identity Blueprint credentials
        if (!(Connect-AgentIdentityBlueprint)) {
            Write-Error "Failed to connect using Agent Identity Blueprint credentials. Cannot create Agent User."
            return
        }

        # Validate that we have a current Agent Identity ID (from parameter or stored value)
        if (-not $AgentIdentityId) {
            $storedAgentIdentityId = Get-Variable -Name 'CurrentAgentIdentityId' -Scope Script -ValueOnly -ErrorAction SilentlyContinue
            if (-not $storedAgentIdentityId) {
                Write-Error "No Agent Identity ID found. Please provide -AgentIdentityId parameter or run New-EntraBetaAgentIDForAgentIdentityBlueprint first to create an Agent Identity." -ErrorAction Stop
                return
            }
            $AgentIdentityId = $storedAgentIdentityId
        }
    }

    process {
        $customHeaders = $null
        $baseUri = '/beta/users/'

        # Build mailNickname from userPrincipalName by removing the domain
        $mailNickname = $UserPrincipalName.Split('@')[0]

        # Build the request body
        $Body = [PSCustomObject]@{
            "@odata.type" = "microsoft.graph.agentUser"
            displayName = $DisplayName
            userPrincipalName = $UserPrincipalName
            identityParentId = $AgentIdentityId
            mailNickname = $mailNickname
            accountEnabled = $true
        }

        try {
            Write-Verbose "Creating Agent User '$DisplayName' with UPN '$UserPrincipalName'..."
            Write-Verbose "Using Agent Identity ID: $AgentIdentityId"

            # Convert the body to JSON
            $JsonBody = $Body | ConvertTo-Json -Depth 5
            Write-Debug "Request body: $JsonBody"

            # Make the REST API call with retry logic
            $retryCount = 0
            $maxRetries = 10
            $agentUser = $null
            $success = $false

            while ($retryCount -lt $maxRetries -and -not $success) {
                if ($retryCount -eq 0) {
                    $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
                }
                else {
                    $customHeaders = $null
                }

                try {
                    $agentUser = Invoke-MgGraphRequest -Headers $customHeaders -Method POST -Uri $baseUri -Body $JsonBody -ErrorAction Stop
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
                        Write-Error "Failed to create Agent User after $maxRetries attempts: $_"
                        throw
                    }
                }
            }

            Write-Host "Agent User created successfully!" -ForegroundColor Green
            Write-Verbose "Agent User ID: $($agentUser.id)"
            Write-Verbose "Display Name: $($agentUser.displayName)"
            Write-Verbose "User Principal Name: $($agentUser.userPrincipalName)"
            Write-Verbose "Mail Nickname: $($agentUser.mailNickname)"

            # Store the Agent User ID in module state (could be useful for future operations)
            $script:CurrentAgentUserId = $agentUser.id

            return $agentUser
        }
        catch {
            Write-Error "Failed to create Agent User: $_"
            throw
        }
    }
}
