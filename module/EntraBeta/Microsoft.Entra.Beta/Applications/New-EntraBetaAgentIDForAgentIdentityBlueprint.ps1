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

        [Parameter(Mandatory = $false, HelpMessage = "Array of user IDs or UPNs to set as sponsors.")]
        [ValidateNotNullOrEmpty()]
        [string[]]$SponsorUserIds,

        [Parameter(Mandatory = $false, HelpMessage = "Array of group IDs to set as sponsors.")]
        [ValidateNotNullOrEmpty()]
        [string[]]$SponsorGroupIds,

        [Parameter(Mandatory = $false, HelpMessage = "Array of user IDs or UPNs to set as owners.")]
        [ValidateNotNullOrEmpty()]
        [string[]]$OwnerUserIds
    )

    begin {
        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes 'AgentIdentityBlueprint.Create', 'AgentIdentityBlueprintPrincipal.Create', 'AppRoleAssignment.ReadWrite.All', 'AgentIdentityBlueprint.UpdateAuthProperties.All', 'User.ReadWrite.All' to authenticate."
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
        $customHeaders = $null
        $baseUri = '/beta/servicePrincipals'

        # Look up the current user to suggest as default sponsor/owner
        $currentUserId = $null
        $currentUserDisplay = $null
        try {
            $context = Get-EntraContext
            if ($context -and $context.Account) {
                $meResponse = Invoke-MgGraphRequest -Method GET -Uri "v1.0/users?`$filter=userPrincipalName eq '$($context.Account)'&`$select=id,displayName,userPrincipalName" -ErrorAction Stop
                if ($meResponse.value -and $meResponse.value.Count -gt 0) {
                    $currentUserId = $meResponse.value[0].id
                    $currentUserDisplay = "$($meResponse.value[0].displayName) ($($meResponse.value[0].userPrincipalName))"
                }
            }
        }
        catch {
            Write-Verbose "Could not retrieve current user details: $_"
        }

        # Sponsors are always required — prompt until at least one is provided
        $hasSponsors = (($SponsorUserIds -and $SponsorUserIds.Count -gt 0) -or
            ($SponsorGroupIds -and $SponsorGroupIds.Count -gt 0))

        while (-not $hasSponsors) {
            # --- Sponsor users ---
            if ($currentUserId) {
                $sponsorUserInput = Read-Host "Enter sponsor user IDs or UPNs (comma-separated, or press Enter to use current user: $currentUserDisplay)"
                if (-not $sponsorUserInput -or $sponsorUserInput.Trim() -eq "") {
                    $SponsorUserIds = @($currentUserId)
                }
                else {
                    $SponsorUserIds = $sponsorUserInput.Split(',') | ForEach-Object { $_.Trim() } | Where-Object { $_ -ne "" }
                }
            }
            else {
                $sponsorUserInput = Read-Host "Enter sponsor user IDs or UPNs (comma-separated, or press Enter to skip)"
                if ($sponsorUserInput -and $sponsorUserInput.Trim() -ne "") {
                    $SponsorUserIds = $sponsorUserInput.Split(',') | ForEach-Object { $_.Trim() } | Where-Object { $_ -ne "" }
                }
            }
            # Allow adding more sponsor users
            while ($SponsorUserIds.Count -gt 0) {
                $more = Read-Host "Add more sponsor users? (comma-separated IDs or UPNs, or press Enter to continue)"
                if (-not $more -or $more.Trim() -eq "") { break }
                $SponsorUserIds += $more.Split(',') | ForEach-Object { $_.Trim() } | Where-Object { $_ -ne "" }
            }

            # --- Sponsor groups ---
            $sponsorGroupInput = Read-Host "Enter sponsor group IDs (comma-separated, or press Enter to skip)"
            if ($sponsorGroupInput -and $sponsorGroupInput.Trim() -ne "") {
                $SponsorGroupIds = $sponsorGroupInput.Split(',') | ForEach-Object { $_.Trim() } | Where-Object { $_ -ne "" }
                # Allow adding more sponsor groups
                while ($true) {
                    $more = Read-Host "Add more sponsor groups? (comma-separated IDs, or press Enter to continue)"
                    if (-not $more -or $more.Trim() -eq "") { break }
                    $SponsorGroupIds += $more.Split(',') | ForEach-Object { $_.Trim() } | Where-Object { $_ -ne "" }
                }
            }

            $hasSponsors = (($SponsorUserIds -and $SponsorUserIds.Count -gt 0) -or
                ($SponsorGroupIds -and $SponsorGroupIds.Count -gt 0))

            if (-not $hasSponsors) {
                Write-Warning "At least one sponsor (user or group) is required. Please provide a sponsor user ID or group ID."
            }
        }

        # Owners are always optional
        if (-not ($OwnerUserIds -and $OwnerUserIds.Count -gt 0)) {
            if ($currentUserId) {
                $ownerUserInput = Read-Host "Enter owner user IDs or UPNs (comma-separated, press Enter to use current user: $currentUserDisplay, or type 'skip' to skip)"
                if (-not $ownerUserInput -or $ownerUserInput.Trim() -eq "") {
                    $OwnerUserIds = @($currentUserId)
                }
                elseif ($ownerUserInput.Trim().ToLower() -ne "skip") {
                    $OwnerUserIds = $ownerUserInput.Split(',') | ForEach-Object { $_.Trim() } | Where-Object { $_ -ne "" }
                }
            }
            else {
                $ownerUserInput = Read-Host "Enter owner user IDs or UPNs (comma-separated, or press Enter to skip)"
                if ($ownerUserInput -and $ownerUserInput.Trim() -ne "") {
                    $OwnerUserIds = $ownerUserInput.Split(',') | ForEach-Object { $_.Trim() } | Where-Object { $_ -ne "" }
                }
            }
            # Allow adding more owner users
            while ($OwnerUserIds.Count -gt 0) {
                $more = Read-Host "Add more owner users? (comma-separated IDs or UPNs, or press Enter to continue)"
                if (-not $more -or $more.Trim() -eq "") { break }
                $OwnerUserIds += $more.Split(',') | ForEach-Object { $_.Trim() } | Where-Object { $_ -ne "" }
            }
        }

        # Deduplicate inputs (case-insensitive) before validation
        if ($SponsorUserIds) { $SponsorUserIds = @($SponsorUserIds | Select-Object -Unique) }
        if ($SponsorGroupIds) { $SponsorGroupIds = @($SponsorGroupIds | Select-Object -Unique) }
        if ($OwnerUserIds) { $OwnerUserIds = @($OwnerUserIds | Select-Object -Unique) }

        # Validate sponsor user IDs against the tenant
        $UpdatedSponsorUserIds = @()
        foreach ($id in $SponsorUserIds) {
            $currentId = $id
            $resolved = $false
            while (-not $resolved) {
                try {
                    $user = Invoke-MgGraphRequest -Method GET -Uri "v1.0/users/$currentId`?`$select=id,displayName,userPrincipalName" -ErrorAction Stop
                    if ($UpdatedSponsorUserIds -notcontains $user.id) {
                        Write-Host "  Validated sponsor user: $($user.displayName) ($($user.userPrincipalName))" -ForegroundColor Green
                        $UpdatedSponsorUserIds += $user.id
                    }
                    else {
                        Write-Verbose "  Skipping duplicate sponsor user: $($user.displayName) ($($user.userPrincipalName))"
                    }
                    $resolved = $true
                }
                catch {
                    Write-Host "  '$currentId' could not be found in the tenant." -ForegroundColor Yellow
                    $retry = Read-Host "  Enter a valid user ID or UPN, or press Enter to skip"
                    if ([string]::IsNullOrWhiteSpace($retry)) {
                        $resolved = $true
                    }
                    else {
                        $currentId = $retry.Trim()
                    }
                }
            }
        }

        # Validate sponsor group IDs against the tenant
        $UpdatedSponsorGroupIds = @()
        foreach ($id in $SponsorGroupIds) {
            try {
                $group = Invoke-MgGraphRequest -Method GET -Uri "v1.0/groups/$id`?`$select=id,displayName" -ErrorAction Stop
                if ($UpdatedSponsorGroupIds -notcontains $group.id) {
                    Write-Host "  Validated sponsor group: $($group.displayName)" -ForegroundColor Green
                    $UpdatedSponsorGroupIds += $group.id
                }
                else {
                    Write-Verbose "  Skipping duplicate sponsor group: $($group.displayName)"
                }
            }
            catch {
                Write-Warning "Sponsor group ID '$id' could not be found in the tenant and will be skipped."
            }
        }

        # Validate owner user IDs against the tenant
        $UpdatedOwnerUserIds = @()
        foreach ($id in $OwnerUserIds) {
            $currentId = $id
            $resolved = $false
            while (-not $resolved) {
                try {
                    $user = Invoke-MgGraphRequest -Method GET -Uri "v1.0/users/$currentId`?`$select=id,displayName,userPrincipalName" -ErrorAction Stop
                    if ($UpdatedOwnerUserIds -notcontains $user.id) {
                        Write-Host "  Validated owner user: $($user.displayName) ($($user.userPrincipalName))" -ForegroundColor Green
                        $UpdatedOwnerUserIds += $user.id
                    }
                    else {
                        Write-Verbose "  Skipping duplicate owner user: $($user.displayName) ($($user.userPrincipalName))"
                    }
                    $resolved = $true
                }
                catch {
                    Write-Host "  '$currentId' could not be found in the tenant." -ForegroundColor Yellow
                    $retry = Read-Host "  Enter a valid user ID or UPN, or press Enter to skip"
                    if ([string]::IsNullOrWhiteSpace($retry)) {
                        $resolved = $true
                    }
                    else {
                        $currentId = $retry.Trim()
                    }
                }
            }
        }

        Write-Debug "Sponsors and Owners: SponsorUsers=$($UpdatedSponsorUserIds -join ','), SponsorGroups=$($UpdatedSponsorGroupIds -join ','), OwnerUsers=$($UpdatedOwnerUserIds -join ',')"

        # Build the request body
        $Body = [PSCustomObject]@{
            displayName              = $DisplayName
            AgentIdentityBlueprintId = $script:CurrentAgentBlueprintId
        }

        # Add sponsors if provided
        if ($UpdatedSponsorUserIds.Count -gt 0 -or $UpdatedSponsorGroupIds.Count -gt 0) {
            $sponsorBindings = @()

            if ($UpdatedSponsorUserIds.Count -gt 0) {
                foreach ($userId in $UpdatedSponsorUserIds) {
                    $sponsorBindings += "https://graph.microsoft.com/v1.0/users/$userId"
                }
            }

            if ($UpdatedSponsorGroupIds.Count -gt 0) {
                foreach ($groupId in $UpdatedSponsorGroupIds) {
                    $sponsorBindings += "https://graph.microsoft.com/v1.0/groups/$groupId"
                }
            }

            $Body | Add-Member -MemberType NoteProperty -Name "sponsors@odata.bind" -Value $sponsorBindings
        }

        # Add owners if provided
        if ($UpdatedOwnerUserIds.Count -gt 0) {
            $ownerBindings = @()
            foreach ($userId in $UpdatedOwnerUserIds) {
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
                if ($retryCount -eq 0) {
                    $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
                } 
                else {
                    $customHeaders = $null
                }

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
