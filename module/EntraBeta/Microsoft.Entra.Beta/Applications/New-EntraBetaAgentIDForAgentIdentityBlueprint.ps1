# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

function New-EntraBetaAgentIDForAgentIdentityBlueprint {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, HelpMessage = "The display name for the Agent Identity.")]
        [ValidateNotNullOrEmpty()]
        [string]$DisplayName,

        [Parameter(Mandatory = $false, HelpMessage = "Array of user IDs to set as sponsors.")]
        [ValidateNotNullOrEmpty()]
        [string[]]$SponsorUserIds,

        [Parameter(Mandatory = $false, HelpMessage = "Array of group IDs to set as sponsors.")]
        [ValidateNotNullOrEmpty()]
        [string[]]$SponsorGroupIds,

        [Parameter(Mandatory = $false, HelpMessage = "Array of user IDs to set as owners.")]
        [ValidateNotNullOrEmpty()]
        [string[]]$OwnerUserIds
    )

    begin {
        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes 'AgentIdentityBlueprint.Create', 'AgentIdentityBlueprintPrincipal.Create', 'AppRoleAssignment.ReadWrite.All', 'Application.ReadWrite.All', 'User.ReadWrite.All' to authenticate."
            Write-Error -Message $errorMessage -ErrorAction Stop
            return
        }
        
        # Connect using Agent Identity Blueprint credentials
        if (!(Connect-AgentIdentityBlueprint)) {
            Write-Error "Failed to connect using Agent Identity Blueprint credentials. Cannot create Agent Identity."
            return
        }

        # Validate that we have a current Agent Identity Blueprint ID
        if (-not $script:CurrentAgentBlueprintId) {
            Write-Error "No Agent Identity Blueprint ID found. Please run New-EntraBetaAgentIdentityBlueprint first."
            return
        }
    }

    process {
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
        $baseUri = '/beta/servicePrincipals'

        # Get sponsors and owners (prompt if not provided)
        $sponsorsAndOwners = Get-SponsorsAndOwners -SponsorUserIds $SponsorUserIds -SponsorGroupIds $SponsorGroupIds -OwnerUserIds $OwnerUserIds
        $SponsorUserIds = $sponsorsAndOwners.SponsorUserIds
        $SponsorGroupIds = $sponsorsAndOwners.SponsorGroupIds
        $OwnerUserIds = $sponsorsAndOwners.OwnerUserIds

        # Build the request body
        $Body = [PSCustomObject]@{
            displayName              = $DisplayName
            AgentIdentityBlueprintId = $script:CurrentAgentBlueprintId
        }

        # Add sponsors if provided
        if ($SponsorUserIds -or $SponsorGroupIds) {
            $sponsorBindings = @()

            if ($SponsorUserIds) {
                foreach ($userId in $SponsorUserIds) {
                    $sponsorBindings += "https://graph.microsoft.com/v1.0/users/$userId"
                }
            }

            if ($SponsorGroupIds) {
                foreach ($groupId in $SponsorGroupIds) {
                    $sponsorBindings += "https://graph.microsoft.com/v1.0/groups/$groupId"
                }
            }

            $Body | Add-Member -MemberType NoteProperty -Name "sponsors@odata.bind" -Value $sponsorBindings
        }

        # Add owners if provided
        if ($OwnerUserIds) {
            $ownerBindings = @()
            foreach ($userId in $OwnerUserIds) {
                $ownerBindings += "https://graph.microsoft.com/v1.0/users/$userId"
            }
            $Body | Add-Member -MemberType NoteProperty -Name "owners@odata.bind" -Value $ownerBindings
        }

        # Convert the body to JSON
        $JsonBody = $Body | ConvertTo-Json -Depth 5
        Write-Debug "Request body: $JsonBody"

        try {
            Write-Verbose "Creating Agent Identity '$DisplayName' using blueprint '$script:CurrentAgentBlueprintId'..."
            # Make the REST API call with retry logic
            $retryCount = 0
            $maxRetries = 10
            $agentIdentity = $null
            $success = $false

            while ($retryCount -lt $maxRetries -and -not $success) {
                try {
                    $agentIdentity = Invoke-MgGraphRequest -Headers $customHeaders -Method POST -Uri "$baseUri/Microsoft.Graph.AgentIdentity" -Body $JsonBody -ErrorAction Stop
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
                        Write-Error "Failed to create Agent Identity after $maxRetries attempts: $_"
                        throw
                    }
                }
            }

            # Store the Agent Identity ID in module state
            $script:CurrentAgentIdentityId = $agentIdentity.id
            $script:CurrentAgentIdentityAppId = $agentIdentity.appId

            Write-Host "Agent Identity created successfully!" -ForegroundColor Green
            Write-Verbose "Agent Identity ID: $($agentIdentity.id)"
            Write-Verbose "Display Name: $($agentIdentity.displayName)"


            return $agentIdentity
        }
        catch {
            Write-Error "Failed to create Agent Identity: $_"
            throw
        }
    }
}
