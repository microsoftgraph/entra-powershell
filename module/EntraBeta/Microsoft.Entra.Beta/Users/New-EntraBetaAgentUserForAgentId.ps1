# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

function New-EntraBetaAgentUserForAgentId {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, HelpMessage = "The display name for the Agent User.")]
        [ValidateNotNullOrEmpty()]
        [string]$DisplayName,

        [Parameter(Mandatory = $false, HelpMessage = "The user principal name (email) for the Agent User e.g: username@domain.onmicrosoft.com.")]
        [ValidatePattern('^[#a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$', ErrorMessage = "UserPrincipalName must be a valid email address (e.g., user@domain.com)")]
        [string]$UserPrincipalName,

        [Parameter(Mandatory = $false, HelpMessage = "The mail nickname (alias) for the Agent User. Derived from UserPrincipalName prefix if not provided.")]
        [string]$MailNickname,

        [Parameter(Mandatory = $false, HelpMessage = "The Agent Identity ID to associate with this user. If not provided, uses the stored value from New-EntraBetaAgentIDForAgentIdentityBlueprint.")]
        [string]$AgentIdentityId
    )

    begin {
        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes 'AgentIdentityBlueprint.Create', 'AgentIdentityBlueprintPrincipal.Create', 'AgentIdentity.Create.All', 'AgentIdentityBlueprint.UpdateAuthProperties.All', 'AgentIdUser.ReadWrite.All' to authenticate."
            Write-Error -Message $errorMessage -ErrorAction Stop
            return
        }

        # Validate that we have a current Agent Identity ID (from parameter or stored value)
        if (-not $AgentIdentityId) {
            # Use global variable to cross module boundaries (set by New-EntraBetaAgentIDForAgentIdentityBlueprint)
            $storedAgentIdentityId = $global:EntraBetaCurrentAgentIdentityId
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

        # Prompt for UserPrincipalName if not provided
        if (-not $UserPrincipalName -or $UserPrincipalName.Trim() -eq "") {
            # Try to get the tenant's default domain for a helpful prompt
            $tenantDomain = $null
            try {
                $orgResponse = Invoke-MgGraphRequest -Method GET -Uri "v1.0/organization?`$select=verifiedDomains" -ErrorAction SilentlyContinue
                $tenantDomain = $orgResponse.value[0].verifiedDomains | Where-Object { $_.isDefault -eq $true } | Select-Object -First 1 -ExpandProperty name
            }
            catch {
                Write-Verbose "Could not retrieve tenant domain: $_"
            }

            # Derive a suggested UPN prefix from the DisplayName (concatenate words and numbers)
            $suggestedPrefix = (($DisplayName -split '\s+' | Where-Object { $_ -match '[a-zA-Z0-9]' } | ForEach-Object { $_ -replace '[^a-zA-Z0-9]', '' }) -join '').ToLower()

            $validUpn = $false
            while (-not $validUpn) {
                if ($tenantDomain) {
                    $suggestedUpn = if ($suggestedPrefix) { "$suggestedPrefix@$tenantDomain" } else { "" }
                    if ($suggestedUpn) {
                        $upnInput = Read-Host "Enter a username prefix or full UPN for the Agent User (press Enter to use '$suggestedUpn')"
                    } else {
                        $upnInput = Read-Host "Enter a username prefix or full UPN for the Agent User (prefix will use @$tenantDomain)"
                    }
                    if (-not $upnInput -or $upnInput.Trim() -eq "") {
                        $UserPrincipalName = $suggestedUpn
                    } elseif ($upnInput -match '@') {
                        $UserPrincipalName = $upnInput.Trim()
                    } else {
                        $UserPrincipalName = "$($upnInput.Trim())@$tenantDomain"
                    }
                } else {
                    $UserPrincipalName = (Read-Host "Enter the user principal name (UPN) for the Agent User (e.g. user@domain.com)").Trim()
                }

                if ($UserPrincipalName -match '^[#a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$') {
                    $validUpn = $true
                } else {
                    Write-Host "  '$UserPrincipalName' is not a valid UPN. Please try again." -ForegroundColor Yellow
                }
            }
        }

        # Derive mailNickname from UPN prefix, then prompt for override if not provided
        $derivedNickname = $UserPrincipalName.Split('@')[0]
        if (-not $MailNickname -or $MailNickname.Trim() -eq "") {
            $nicknameInput = Read-Host "Enter mail nickname for the Agent User (press Enter to use '$derivedNickname')"
            if ($nicknameInput -and $nicknameInput.Trim() -ne "") {
                $MailNickname = $nicknameInput.Trim()
            } else {
                $MailNickname = $derivedNickname
            }
        }

        # Build the request body
        $Body = [PSCustomObject]@{
            "@odata.type" = "microsoft.graph.agentUser"
            displayName = $DisplayName
            userPrincipalName = $UserPrincipalName
            identityParentId = $AgentIdentityId
            mailNickname = $MailNickname
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
