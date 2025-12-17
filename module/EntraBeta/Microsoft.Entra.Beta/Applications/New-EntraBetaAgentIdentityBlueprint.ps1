function New-EntraBetaAgentIdentityBlueprint {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, HelpMessage = "The display name for the Agent Identity Blueprint.")]
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
    }

    process {
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
        $baseUri = '/beta/applications'

        # Get sponsors and owners (prompt if not provided)
        $sponsorsAndOwners = Get-SponsorsAndOwners -SponsorUserIds $SponsorUserIds -SponsorGroupIds $SponsorGroupIds -OwnerUserIds $OwnerUserIds
        $SponsorUserIds = $sponsorsAndOwners.SponsorUserIds
        $SponsorGroupIds = $sponsorsAndOwners.SponsorGroupIds
        $OwnerUserIds = $sponsorsAndOwners.OwnerUserIds

        # Build the request body
        $Body = [PSCustomObject]@{
            displayName = $DisplayName
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

        $JsonBody = $Body | ConvertTo-Json -Depth 5
        Write-Debug "Request Body: $JsonBody"

        try {
            Write-Verbose "Creating Agent Identity Blueprint: $DisplayName"
            $BlueprintRes = Invoke-MgGraphRequest -Headers $customHeaders -Method Post -Uri "$baseUri/graph.agentIdentityBlueprint" -Body $JsonBody

            # Display the full response from the Graph API call
            Write-Debug "Graph API Response:"
            $BlueprintRes | ConvertTo-Json -Depth 5 | Write-Debug

            # Extract and store the blueprint ID
            $AgentBlueprintId = $BlueprintRes.id
            Write-Host "Successfully created Agent Identity Blueprint" -ForegroundColor Green
            Write-Verbose "Agent Blueprint ID: $AgentBlueprintId"

            # Store the ID in module-level variable for use by other functions
            $script:CurrentAgentBlueprintId = $AgentBlueprintId
            $script:CurrentAgentBlueprintAppId = $BlueprintRes.appId

            # Return only the AgentBlueprintId instead of the full response
            return $AgentBlueprintId
        }
        catch {
            Write-Error "Failed to create Agent Identity Blueprint: $_"
            throw
        }
    }
}
