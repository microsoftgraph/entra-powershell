# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

function Invoke-EntraBetaAgentIdInteractive {
    [CmdletBinding()]
    param()

    begin {
        # Ensure connection to Microsoft Entra
        $context = Get-EntraContext
        if (-not $context) {
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes Organization.Read.All, AgentIdentityBlueprint.Create, AgentIdentityBlueprintPrincipal.Create, AgentIdentity.Create.All, AgentIdentityBlueprint.UpdateAuthProperties.All, AgentIdUser.ReadWrite.All' to authenticate."
            Write-Error -Message $errorMessage -ErrorAction Stop
            return
        }
    }

    process {
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand

        # Welcome banner
        Write-Host ""
        Write-Host "============================================================" -ForegroundColor Cyan
        Write-Host "  Microsoft Entra Agent ID - Interactive Setup" -ForegroundColor Cyan
        Write-Host "============================================================" -ForegroundColor Cyan
        Write-Host ""
        Write-Host "This wizard walks you through the full Agent Identity" -ForegroundColor White
        Write-Host "Blueprint workflow, step by step:" -ForegroundColor White
        Write-Host ""
        Write-Host "  1. Create an Agent Identity Blueprint" -ForegroundColor White
        Write-Host "  2. Configure security (client secret)" -ForegroundColor White
        Write-Host "  3. Configure interactive agent support" -ForegroundColor White
        Write-Host "  4. Configure agent user creation" -ForegroundColor White
        Write-Host "  5. Configure inheritable permissions" -ForegroundColor White
        Write-Host "  6. Choose static or dynamic permission model" -ForegroundColor White
        Write-Host "  7. Get admin consent for the blueprint" -ForegroundColor White
        Write-Host "  8. Create Agent Identities and Users" -ForegroundColor White
        Write-Host ""
        Write-Host "You will be prompted at each step. Press Ctrl+C to exit" -ForegroundColor Gray
        Write-Host "at any time." -ForegroundColor Gray
        Write-Host ""
        Write-Host "Learn more: https://learn.microsoft.com/entra/agent-id/" -ForegroundColor Gray
        Write-Host "============================================================" -ForegroundColor Cyan
        Write-Host ""

        # ===================================================================
        # PHASE 1: Create Agent Identity Blueprint
        # ===================================================================

        Write-Verbose "=== Phase 1: Blueprint Creation ==="
        Write-Host ""
        Write-Host "--- Phase 1: Create Agent Identity Blueprint ---" -ForegroundColor Yellow
        Write-Host ""
        # Calculate seconds after midnight October 1, 2025 for unique naming
        $october1_2025 = [DateTime]::new(2025, 10, 1, 0, 0, 0)
        $blueprintNumber = [int]((Get-Date) - $october1_2025).TotalSeconds

        $defaultBlueprintName = "Agent Identity Blueprint Example $blueprintNumber"
        $bluePrintDisplayName = Read-Host "Enter a display name for the Agent Identity Blueprint (press Enter to use '$defaultBlueprintName')"
        if (-not $bluePrintDisplayName -or $bluePrintDisplayName.Trim() -eq "") {
            $bluePrintDisplayName = $defaultBlueprintName
        }

        # Get current user to suggest as sponsor
        try {
            $currentUserUpn = $context.Account
            # Get user's OID directly using their UPN
            $currentUserResponse = Invoke-MgGraphRequest -Headers $customHeaders -Method GET -Uri "v1.0/users?`$filter=userPrincipalName eq '$currentUserUpn'&`$select=id"
            if ($currentUserResponse.value -and $currentUserResponse.value.Count -gt 0) {
                $currentUserId = $currentUserResponse.value[0].id
            } else {
                $currentUserId = $null
            }
        }
        catch {
            $currentUserUpn = $null
            $currentUserId = $null
        }

        if ($currentUserUpn) {
            Write-Host "Agent Identity Blueprints and Agent Identities require sponsors." -ForegroundColor Cyan
            Write-Host "Learn more: https://learn.microsoft.com/entra/agent-id/key-concepts#agent-owners-sponsors-and-managers" -ForegroundColor Gray
            $useCurrentUserId = Read-Host "Use current user ($currentUserUpn) as sponsor and owner? (y/n)"
            if ($null -eq $useCurrentUserId -or $useCurrentUserId -eq "y") {
                Write-Host "Using current user as default sponsor and owner: $currentUserUpn" -ForegroundColor Gray
                $SponsorUserIds = @($currentUserId)
                $useSponsor = $true
            } else {
                $useSponsor = $false
            }
        } else {
            $useSponsor = $false
        }
        Write-Host ""

        # Step 1: Create Agent Identity Blueprint with all parameters (no prompting)
        try {
            if ($useSponsor) {
                Write-Debug "Creating blueprint with sponsor user ID: $($SponsorUserIds -join ', ')"
                $blueprint1 = New-EntraBetaAgentIdentityBlueprint -DisplayName $bluePrintDisplayName -SponsorUserIds $SponsorUserIds -OwnerUserIds $SponsorUserIds
            } else {
                $blueprint1 = New-EntraBetaAgentIdentityBlueprint -DisplayName $bluePrintDisplayName
            }

            if ($null -ne $blueprint1) {
                Write-Host "Created Blueprint ID: $blueprint1" -ForegroundColor Green
            } else {
                Write-Error "Failed to create Agent Identity Blueprint - no ID returned"
                return
            }
        }
        catch {
            Write-Error "Failed to create Agent Identity Blueprint: $_"
            return
        }
        Write-Host ""

        # ===================================================================
        # PHASE 2: Configure Blueprint Security and Permissions
        # ===================================================================

        Write-Verbose "=== Phase 2: Blueprint Configuration ==="
        Write-Host ""
        Write-Host "--- Phase 2: Configure Blueprint Security ---" -ForegroundColor Yellow
        Write-Host ""

        # Step 2: Add a client secret to the blueprint (uses stored blueprint ID automatically)
        $secret1 = Add-EntraBetaClientSecretToAgentIdentityBlueprint
        Write-Host "Secret: $($secret1.SecretText)" -ForegroundColor Yellow
        Write-Host "Secret Key ID: $($secret1.KeyId)" -ForegroundColor Yellow
        Write-Host "Secret Expires: $($secret1.EndDateTime)" -ForegroundColor Yellow
        Write-Host ""

        # ===================================================================
        # PHASE 3: Configure Interactive Agents
        # ===================================================================

        Write-Verbose "=== Phase 3: Configure Interactive Agents ==="
        Write-Host ""
        Write-Host "--- Phase 3: Configure Interactive Agents ---" -ForegroundColor Yellow
        Write-Host ""

        # Prompt user if there will be interactive agents
        Write-Host "Agents often have to act on behalf of users. These are called Interactive Agents." -ForegroundColor Cyan
        Write-Host "Learn more: https://learn.microsoft.com/entra/agent-id/key-concepts#agent-operation-patterns" -ForegroundColor Gray
        do {
            $userResponse = Read-Host "Will this agent act on behalf of users? (y/n)"
            $userResponse = $userResponse.Trim().ToLower()
        } while ($userResponse -ne "y" -and $userResponse -ne "n" -and $userResponse -ne "yes" -and $userResponse -ne "no")

        # Store the result for later use
        $hasInteractiveAgents = ($userResponse -eq "y" -or $userResponse -eq "yes")
        Write-Host ""
        if ($hasInteractiveAgents) {
            Write-Host "Configuring scopes for interactive agents..." -ForegroundColor Cyan

            # Step 3: Configure scopes for interactive agent functionality (prompts user for all parameters)
            $interactiveScope = Add-EntraBetaScopeToAgentIdentityBlueprint
            if ($null -ne $interactiveScope) {
                Write-Debug "Interactive Scope: `n $($interactiveScope | ConvertTo-Json -Depth 5)"
                Write-Host "Configured interactive scope: $($interactiveScope.ScopeId)" -ForegroundColor Green
            } else {
                Write-Warning "Failed to configure interactive scope"
            }
        }
        else {
            Write-Host "Skipping interactive agent scope configuration." -ForegroundColor Gray
            $interactiveScope = $null
        }
        Write-Host ""

        # ===================================================================
        # PHASE 4: Configure blueprint to create Agent ID Users
        # ===================================================================

        Write-Verbose "=== Phase 4: Configure blueprint to create Agent ID Users ==="
        Write-Host ""
        Write-Host "--- Phase 4: Configure Blueprint to Create Agent ID Users ---" -ForegroundColor Yellow
        Write-Host ""

        # Prompt user if Agent Identity Blueprint will create Agent ID users
        Write-Host "Agent Identities can be created by users with Agent ID Developer," -ForegroundColor Cyan
        Write-Host "Agent ID Administrator, or AI Administrator roles, or by an agent" -ForegroundColor Cyan
        Write-Host "without a user using the Agent Identity Blueprint's credentials." -ForegroundColor Cyan
        do {
            $userResponse = Read-Host "Will this agent create Agent Users without a user? (y/n)"
            $userResponse = $userResponse.Trim().ToLower()
        } while ($userResponse -ne "y" -and $userResponse -ne "n" -and $userResponse -ne "yes" -and $userResponse -ne "no")

        # Store the result for later use
        $blueprintWillCreateAgentUsers = ($userResponse -eq "y" -or $userResponse -eq "yes")
        Write-Host ""

        # ===================================================================
        # PHASE 5: Configure Inheritable Permissions
        # ===================================================================

        Write-Verbose "=== Phase 5: Configure Inheritable Permissions ==="
        Write-Host ""
        Write-Host "--- Phase 5: Configure Inheritable Permissions ---" -ForegroundColor Yellow
        Write-Host ""

        # Prompt user if Agent Identity Blueprint will have inheritable permissions
        Write-Host "Agent Identities can optionally inherit both delegated and app-only" -ForegroundColor Cyan
        Write-Host "permissions to resources from their Agent Identity Blueprint parent." -ForegroundColor Cyan
        Write-Host "Learn more: https://learn.microsoft.com/entra/agent-id/configure-inheritable-permissions-blueprints" -ForegroundColor Gray
        do {
            $userResponse = Read-Host "Will this Agent Identity Blueprint have inheritable permissions? (y/n)"
            $userResponse = $userResponse.Trim().ToLower()
        } while ($userResponse -ne "y" -and $userResponse -ne "n" -and $userResponse -ne "yes" -and $userResponse -ne "no")

        # Store the result for later use
        $hasInheritablePermissions = ($userResponse -eq "y" -or $userResponse -eq "yes")
        Write-Host ""
        if ($hasInheritablePermissions) {
            Write-Host "Configuring inheritable permissions..." -ForegroundColor Cyan

            # Step 5: Configure inheritable permissions (what permissions agent users will get)
            $inheritablePerms = Add-EntraBetaInheritablePermissionsToAgentIdentityBlueprint
            Write-Host "Configured inheritable permissions: $($inheritablePerms.InheritableScopes -join ', ')" -ForegroundColor Green
        }
        else {
            Write-Host "Skipping inheritable permissions configuration." -ForegroundColor Gray
            $inheritablePerms = $null
        }
        Write-Host ""

        # ===================================================================
        # PHASE 6: Configure Static or Dynamic Permissions
        # ===================================================================

        Write-Verbose "=== Phase 6: Configure Static or Dynamic Permissions ==="
        Write-Host ""
        Write-Host "--- Phase 6: Configure Static or Dynamic Permissions ---" -ForegroundColor Yellow
        Write-Host ""

        $useStaticPermissions = $false
        if ($hasInheritablePermissions) {
            Write-Host "Inheritable permissions can be configured as Static or Dynamic." -ForegroundColor Cyan
            Write-Host "  Static permissions are declared in requiredResourceAccess on the blueprint." -ForegroundColor White
            Write-Host "  This is recommended if the agent will work in Agent 365." -ForegroundColor Yellow
            Write-Host "  Dynamic permissions are resolved at runtime via admin consent." -ForegroundColor White

            do {
                $permModelResponse = Read-Host "Use Static permissions (recommended for Agent 365)? (y=static, n=dynamic)"
                $permModelResponse = $permModelResponse.Trim().ToLower()
            } while ($permModelResponse -ne "y" -and $permModelResponse -ne "n" -and $permModelResponse -ne "yes" -and $permModelResponse -ne "no")

            $useStaticPermissions = ($permModelResponse -eq "y" -or $permModelResponse -eq "yes")
            Write-Host ""
            if ($useStaticPermissions) {
                Write-Host "Configuring static required resource access..." -ForegroundColor Cyan

                # If the blueprint will create agent users, automatically add the AgentIdUser.ReadWrite.IdentityParentedBy role
                if ($blueprintWillCreateAgentUsers) {
                    Write-Host "Blueprint is configured to create Agent ID users. Adding AgentIdUser.ReadWrite.IdentityParentedBy to required resource access..." -ForegroundColor Cyan

                    # Look up the role ID for AgentIdUser.ReadWrite.IdentityParentedBy from the Microsoft Graph service principal
                    $msGraphAppId = "00000003-0000-0000-c000-000000000000"
                    $agentUserRoleId = $null
                    try {
                        $spResponse = Invoke-MgGraphRequest -Method GET `
                            -Uri "v1.0/servicePrincipals?`$filter=appId eq '$msGraphAppId'&`$select=appRoles" `
                            -ErrorAction Stop
                        if ($spResponse.value -and $spResponse.value.Count -gt 0) {
                            $agentUserRole = $spResponse.value[0].appRoles | Where-Object { $_.value -eq "AgentIdUser.ReadWrite.IdentityParentedBy" } | Select-Object -First 1
                            if ($agentUserRole) {
                                $agentUserRoleId = $agentUserRole.id
                                Write-Verbose "Resolved AgentIdUser.ReadWrite.IdentityParentedBy role ID: $agentUserRoleId"
                            }
                        }
                    }
                    catch {
                        Write-Warning "Could not look up AgentIdUser.ReadWrite.IdentityParentedBy role ID: $_"
                    }

                    if ($agentUserRoleId) {
                        $agentUserResourceAccess = @(@{ id = $agentUserRoleId; type = "Role" })
                        $agentUserRra = Add-EntraBetaRequiredResourceAccessToAgentIdentityBlueprint `
                            -ResourceAppId $msGraphAppId `
                            -ResourceAccess $agentUserResourceAccess `
                            -Silent
                        Write-Host "Added AgentIdUser.ReadWrite.IdentityParentedBy to required resource access" -ForegroundColor Green
                    }
                    else {
                        Write-Warning "Could not resolve AgentIdUser.ReadWrite.IdentityParentedBy role ID. You may need to add it manually."
                    }
                }

                # Prompt user to add additional permissions interactively
                Write-Host "You can now add additional permissions to the required resource access." -ForegroundColor Cyan
                $additionalRra = Add-EntraBetaRequiredResourceAccessToAgentIdentityBlueprint
                if ($null -ne $additionalRra) {
                    Write-Host "Static required resource access configured." -ForegroundColor Green
                }
            }
            else {
                Write-Host "Using dynamic permissions. Permissions will be resolved at runtime via admin consent." -ForegroundColor Gray
            }
        }
        else {
            Write-Host "Skipping permission model selection (no inheritable permissions configured)." -ForegroundColor Gray
        }
        Write-Host ""

        # ===================================================================
        # PHASE 7: Get Consent for the Blueprint in this tenant
        # ===================================================================

        Write-Verbose "=== Phase 7: Get Consent for the Blueprint in this tenant ==="
        Write-Host ""
        Write-Host "--- Phase 7: Get Consent for the Blueprint in This Tenant ---" -ForegroundColor Yellow
        Write-Host ""

        if (-not $hasInheritablePermissions -and -not $blueprintWillCreateAgentUsers) {
            # No inheritable permissions and no agent users: just create the service principal
            Write-Host "No inheritable permissions or agent user creation configured." -ForegroundColor Cyan
            Write-Host "Admin consent is not required. Creating the service principal directly." -ForegroundColor Cyan
            $principal1 = New-EntraBetaAgentIdentityBlueprintPrincipal
            Write-Host "Created Service Principal ID: $($principal1.id)" -ForegroundColor Green
        }
        elseif (-not $hasInheritablePermissions -and $blueprintWillCreateAgentUsers) {
            # No inheritable permissions but agent users: consent with AgentIdUser role only
            Write-Host "The blueprint will create Agent Users without a user, so admin consent is required" -ForegroundColor Cyan
            Write-Host "to grant the AgentIdUser.ReadWrite.IdentityParentedBy app role." -ForegroundColor Cyan
            Write-Host "No delegated scopes are needed since there are no inheritable permissions." -ForegroundColor Cyan
            $consentRoles = @("https://graph.microsoft.com/AgentIdUser.ReadWrite.IdentityParentedBy")
            Add-EntraBetaPermissionsToInheritToAgentIdentityBlueprintPrincipal -Roles $consentRoles

            Write-Host ""
            Write-Host "IMPORTANT: Please complete the admin consent process in your browser before continuing." -ForegroundColor Red
            Write-Host "The script will wait for you to grant admin consent..." -ForegroundColor Yellow
            do {
                $consentResponse = Read-Host "Press Enter to continue after Admin Consent has been granted, or type 'retry' to relaunch the consent prompt"
                if ($consentResponse -and $consentResponse.Trim().ToLower() -eq 'retry') {
                    Write-Host "Relaunching admin consent prompt..." -ForegroundColor Yellow
                    Add-EntraBetaPermissionsToInheritToAgentIdentityBlueprintPrincipal -Roles $consentRoles
                    Write-Host ""
                    Write-Host "IMPORTANT: Please complete the admin consent process in your browser before continuing." -ForegroundColor Red
                }
            } while ($consentResponse -and $consentResponse.Trim().ToLower() -eq 'retry')
            Write-Host "Continuing with workflow..." -ForegroundColor Cyan
        }
        elseif ($hasInheritablePermissions -and $useStaticPermissions) {
            # Inheritable permissions with static: consent with .default scope
            Write-Host "Static permissions were selected, so admin consent uses the .default scope." -ForegroundColor Cyan
            Write-Host "This grants all permissions defined in the blueprint's requiredResourceAccess." -ForegroundColor Cyan
            $consentScopes = @("https://graph.microsoft.com/.default")
            Add-EntraBetaPermissionsToInheritToAgentIdentityBlueprintPrincipal -Scopes $consentScopes

            Write-Host ""
            Write-Host "IMPORTANT: Please complete the admin consent process in your browser before continuing." -ForegroundColor Red
            Write-Host "The script will wait for you to grant admin consent..." -ForegroundColor Yellow
            do {
                $consentResponse = Read-Host "Press Enter to continue after Admin Consent has been granted, or type 'retry' to relaunch the consent prompt"
                if ($consentResponse -and $consentResponse.Trim().ToLower() -eq 'retry') {
                    Write-Host "Relaunching admin consent prompt..." -ForegroundColor Yellow
                    Add-EntraBetaPermissionsToInheritToAgentIdentityBlueprintPrincipal -Scopes $consentScopes
                    Write-Host ""
                    Write-Host "IMPORTANT: Please complete the admin consent process in your browser before continuing." -ForegroundColor Red
                }
            } while ($consentResponse -and $consentResponse.Trim().ToLower() -eq 'retry')
            Write-Host "Continuing with workflow..." -ForegroundColor Cyan
        }
        elseif ($hasInheritablePermissions -and -not $useStaticPermissions -and $blueprintWillCreateAgentUsers) {
            # Inheritable permissions with dynamic + agent users: suggested scopes + AgentIdUser role
            Write-Host "Dynamic permissions were selected, so admin consent must specify each delegated scope individually." -ForegroundColor Cyan
            Write-Host "The AgentIdUser.ReadWrite.IdentityParentedBy app role is also required because the" -ForegroundColor Cyan
            Write-Host "blueprint will create Agent Users without a user." -ForegroundColor Cyan

            $suggestedScopes = "user.read, mail.read, mail.send"
            Write-Host "Suggested delegated scopes: $suggestedScopes" -ForegroundColor Cyan
            $scopeInput = Read-Host "Edit delegated scopes (comma-separated, press Enter to use suggested)"
            if ($scopeInput -and $scopeInput.Trim() -ne "") {
                $consentScopes = $scopeInput.Trim() -split ',\s*'
            } else {
                $consentScopes = $suggestedScopes -split ',\s*'
            }
            Write-Host "Using scopes: $($consentScopes -join ', ')" -ForegroundColor Green

            $suggestedRoles = "https://graph.microsoft.com/AgentIdUser.ReadWrite.IdentityParentedBy"
            Write-Host "Suggested app roles: $suggestedRoles" -ForegroundColor Cyan
            $roleInput = Read-Host "Edit app roles (comma-separated, press Enter to use suggested)"
            if ($roleInput -and $roleInput.Trim() -ne "") {
                $consentRoles = $roleInput.Trim() -split ',\s*'
            } else {
                $consentRoles = $suggestedRoles -split ',\s*'
            }
            Write-Host "Using roles: $($consentRoles -join ', ')" -ForegroundColor Green

            Add-EntraBetaPermissionsToInheritToAgentIdentityBlueprintPrincipal -Scopes $consentScopes -Roles $consentRoles

            Write-Host ""
            Write-Host "IMPORTANT: Please complete the admin consent process in your browser before continuing." -ForegroundColor Red
            Write-Host "The script will wait for you to grant admin consent..." -ForegroundColor Yellow
            do {
                $consentResponse = Read-Host "Press Enter to continue after Admin Consent has been granted, or type 'retry' to relaunch the consent prompt"
                if ($consentResponse -and $consentResponse.Trim().ToLower() -eq 'retry') {
                    Write-Host "Relaunching admin consent prompt..." -ForegroundColor Yellow
                    Add-EntraBetaPermissionsToInheritToAgentIdentityBlueprintPrincipal -Scopes $consentScopes -Roles $consentRoles
                    Write-Host ""
                    Write-Host "IMPORTANT: Please complete the admin consent process in your browser before continuing." -ForegroundColor Red
                }
            } while ($consentResponse -and $consentResponse.Trim().ToLower() -eq 'retry')
            Write-Host "Continuing with workflow..." -ForegroundColor Cyan
        }
        elseif ($hasInheritablePermissions -and -not $useStaticPermissions -and -not $blueprintWillCreateAgentUsers) {
            # Inheritable permissions with dynamic + no agent users: suggested scopes + User.Read.All role
            Write-Host "Dynamic permissions were selected, so admin consent must specify each delegated scope individually." -ForegroundColor Cyan
            Write-Host "Since the blueprint will not create Agent Users, the User.Read.All app role is suggested" -ForegroundColor Cyan
            Write-Host "to allow the agent to read user profiles on behalf of the organization." -ForegroundColor Cyan

            $suggestedScopes = "user.read, mail.read, mail.send"
            Write-Host "Suggested delegated scopes: $suggestedScopes" -ForegroundColor Cyan
            $scopeInput = Read-Host "Edit delegated scopes (comma-separated, press Enter to use suggested)"
            if ($scopeInput -and $scopeInput.Trim() -ne "") {
                $consentScopes = $scopeInput.Trim() -split ',\s*'
            } else {
                $consentScopes = $suggestedScopes -split ',\s*'
            }
            Write-Host "Using scopes: $($consentScopes -join ', ')" -ForegroundColor Green

            $suggestedRoles = "https://graph.microsoft.com/User.Read.All"
            Write-Host "Suggested app roles: $suggestedRoles" -ForegroundColor Cyan
            $roleInput = Read-Host "Edit app roles (comma-separated, press Enter to use suggested)"
            if ($roleInput -and $roleInput.Trim() -ne "") {
                $consentRoles = $roleInput.Trim() -split ',\s*'
            } else {
                $consentRoles = $suggestedRoles -split ',\s*'
            }
            Write-Host "Using roles: $($consentRoles -join ', ')" -ForegroundColor Green

            Add-EntraBetaPermissionsToInheritToAgentIdentityBlueprintPrincipal -Scopes $consentScopes -Roles $consentRoles

            Write-Host ""
            Write-Host "IMPORTANT: Please complete the admin consent process in your browser before continuing." -ForegroundColor Red
            Write-Host "The script will wait for you to grant admin consent..." -ForegroundColor Yellow
            do {
                $consentResponse = Read-Host "Press Enter to continue after Admin Consent has been granted, or type 'retry' to relaunch the consent prompt"
                if ($consentResponse -and $consentResponse.Trim().ToLower() -eq 'retry') {
                    Write-Host "Relaunching admin consent prompt..." -ForegroundColor Yellow
                    Add-EntraBetaPermissionsToInheritToAgentIdentityBlueprintPrincipal -Scopes $consentScopes -Roles $consentRoles
                    Write-Host ""
                    Write-Host "IMPORTANT: Please complete the admin consent process in your browser before continuing." -ForegroundColor Red
                }
            } while ($consentResponse -and $consentResponse.Trim().ToLower() -eq 'retry')
            Write-Host "Continuing with workflow..." -ForegroundColor Cyan
        }
        Write-Host ""

        # ===================================================================
        # PHASE 8: Create Agent Identity and Users
        # ===================================================================

        Write-Verbose "=== Phase 8: Agent Identity and User Creation ==="
        Write-Host ""
        Write-Host "--- Phase 8: Create Agent Identities and Users ---" -ForegroundColor Yellow
        Write-Host ""

        # Initialize tracking variables
        $allAgentIdentities = @()
        $allAgentUsers = @()
        $agentIdentity = $null
        $agentUser = $null

        # Ask user if they want to create Agent IDs and Agent Users
        do {
            $createAgentsResponse = Read-Host "Do you want to create Agent Identities and Agent Users for this Agent Identity Blueprint? (y/n)"
            $createAgentsResponse = $createAgentsResponse.Trim().ToLower()
        } while ($createAgentsResponse -ne "y" -and $createAgentsResponse -ne "n" -and $createAgentsResponse -ne "yes" -and $createAgentsResponse -ne "no")

        $willCreateAgents = ($createAgentsResponse -eq "y" -or $createAgentsResponse -eq "yes")
        Write-Host ""

        if (-not $willCreateAgents) {
            Write-Host "Skipping Agent Identity and User creation." -ForegroundColor Gray
        }
        else {

        # Ask user if they want to use example names or provide custom names
        do {
            $namingResponse = Read-Host "Use example names for Agent Identities and Users? (y=use examples like 'Agent Identity Example', n=provide custom names)"
            $namingResponse = $namingResponse.Trim().ToLower()
        } while ($namingResponse -ne "y" -and $namingResponse -ne "n" -and $namingResponse -ne "yes" -and $namingResponse -ne "no")

        $useExampleNames = ($namingResponse -eq "y" -or $namingResponse -eq "yes")

        if ($null -ne $useExampleNames) {
            Write-Host "Using example naming pattern for Agent Identities and Users" -ForegroundColor Cyan
        } else {
            Write-Host "You will be prompted for custom names for each Agent Identity and User" -ForegroundColor Cyan
        }
        Write-Host ""

        # Initialize arrays to store all created Agent Identities and Users
        $allAgentIdentities = @()
        $allAgentUsers = @()
        # Set agent counter to seconds after midnight October 1, 2025
        $agentCounter = [int]((Get-Date) - $october1_2025).TotalSeconds
        $continueCreating = $true

        # Loop to create multiple Agent Identities and Users
        while ($continueCreating) {
            Write-Host "Creating Agent Identity #$agentCounter" -ForegroundColor Cyan

            # Determine the display name for the Agent Identity
            if ($useExampleNames) {
                $agentIdentityDisplayName = "Agent Identity Example $agentCounter"
            } else {
                $agentIdentityDisplayName = Read-Host "Enter display name for this Agent Identity"
                if ([string]::IsNullOrWhiteSpace($agentIdentityDisplayName)) {
                    $agentIdentityDisplayName = "Agent Identity $agentCounter"
                    Write-Host "Using default: $agentIdentityDisplayName" -ForegroundColor Gray
                }
            }

            # Step 9: Create Agent Identity from the blueprint
            if ($useSponsor) {
                Write-Host "Using current user as sponsor for Agent Identity." -ForegroundColor Gray
                $agentIdentity = New-EntraBetaAgentIDForAgentIdentityBlueprint -DisplayName $agentIdentityDisplayName `
                    -SponsorUserIds $SponsorUserIds -OwnerUserIds $SponsorUserIds
            }
            else {
                Write-Host "No sponsor specified for Agent Identity." -ForegroundColor Gray
                $agentIdentity = New-EntraBetaAgentIDForAgentIdentityBlueprint -DisplayName $agentIdentityDisplayName
            }
            Write-Host "Created Agent Identity ID: $($agentIdentity.id)" -ForegroundColor Cyan
            $allAgentIdentities += $agentIdentity

            # Step 10: Create Agent Users for the Agent Identity (only if user chose to create Agent ID users)
            if ($blueprintWillCreateAgentUsers) {
                # Prompt user if this specific Agent ID requires an Agent ID user
                do {
                    $userResponse = Read-Host "Does this Agent ID (#$agentCounter) require an Agent ID user? (y/n)"
                    $userResponse = $userResponse.Trim().ToLower()
                } while ($userResponse -ne "y" -and $userResponse -ne "n" -and $userResponse -ne "yes" -and $userResponse -ne "no")

                # Store the result for this specific Agent ID
                $agentIDNeedsUser = ($userResponse -eq "y" -or $userResponse -eq "yes")

                if ($agentIDNeedsUser) {
                    Write-Host "Creating Agent Users as requested..." -ForegroundColor Cyan
                    # Get current tenant's domain for UPN
                    $orgResponse = Invoke-MgGraphRequest -Method GET -Uri "v1.0/organization?`$select=verifiedDomains"
                    $tenantDomain = $orgResponse.value[0].verifiedDomains | Where-Object { $_.isDefault -eq $true } | Select-Object -First 1 -ExpandProperty name

                    # Determine names for the Agent User
                    if ($useExampleNames) {
                        $agentUserDisplayName = "Agent User Example $agentCounter"
                        $agentUserUpn = "AgentUser$agentCounter@$tenantDomain"
                    } else {
                        $agentUserDisplayName = Read-Host "Enter display name for this Agent User"
                        if ([string]::IsNullOrWhiteSpace($agentUserDisplayName)) {
                            $agentUserDisplayName = "Agent User $agentCounter"
                            Write-Host "Using default: $agentUserDisplayName" -ForegroundColor Gray
                        }

                        $agentUserUpnPrefix = Read-Host "Enter UPN prefix for this Agent User (will be @$tenantDomain)"
                        if ([string]::IsNullOrWhiteSpace($agentUserUpnPrefix)) {
                            $agentUserUpnPrefix = "AgentUser$agentCounter"
                            Write-Host "Using default prefix: $agentUserUpnPrefix" -ForegroundColor Gray
                        }
                        $agentUserUpn = "$agentUserUpnPrefix@$tenantDomain"
                    }

                    $agentUser = New-EntraBetaAgentUserForAgentId -DisplayName $agentUserDisplayName `
                        -UserPrincipalName $agentUserUpn -AgentIdentityId $agentIdentity.id
                    Write-Host "Created Agent User ID: $($agentUser.id)" -ForegroundColor Cyan
                    Write-Verbose "Agent User UPN: $($agentUser.userPrincipalName)"
                    $allAgentUsers += $agentUser
                }
                else {
                    Write-Host "Skipping Agent User creation for this Agent ID (not required)." -ForegroundColor Gray
                    $agentUser = $null
                }
            }
            else {
                Write-Host "Skipping Agent User creation (Agent ID users not configured in Phase 4)." -ForegroundColor Gray
                $agentUser = $null
                $agentIDNeedsUser = $false
            }

            # Ask user if they want to create another Agent Identity
            do {
                $continueResponse = Read-Host "Do you want to create another Agent Identity? (y/n)"
                $continueResponse = $continueResponse.Trim().ToLower()
            } while ($continueResponse -ne "y" -and $continueResponse -ne "n" -and $continueResponse -ne "yes" -and $continueResponse -ne "no")

            $continueCreating = ($continueResponse -eq "y" -or $continueResponse -eq "yes")
            $agentCounter++
            Write-Host ""
        }

        Write-Host "=== Agent Identity and User Creation Summary ===" -ForegroundColor Cyan
        Write-Host "Total Agent Identities created: $($allAgentIdentities.Count)" -ForegroundColor White
        Write-Host "Total Agent Users created: $($allAgentUsers.Count)" -ForegroundColor White

        # Store the last created items for compatibility with existing summary code
        $agentIdentity = if ($allAgentIdentities.Count -gt 0) { $allAgentIdentities[-1] } else { $null }
        $agentUser = if ($allAgentUsers.Count -gt 0) { $allAgentUsers[-1] } else { $null }
        Write-Host ""

        } # end of willCreateAgents else block

        # ===================================================================
        # SUMMARY AND MODULE STATUS
        # ===================================================================

        Write-Host "=== Complete Workflow Summary ===" -ForegroundColor Green
        Write-Host "✓ 1. Agent Identity Blueprint created and configured" -ForegroundColor Green
        Write-Host "✓ 2. Client secret added for API authentication" -ForegroundColor Green

        if ($hasInteractiveAgents) {
            Write-Host "✓ 3. Interactive agent scopes configured with user prompts" -ForegroundColor Green
        }
        else {
            Write-Host "- 3. Interactive agent scopes (skipped by user choice)" -ForegroundColor Gray
        }

        if ($blueprintWillCreateAgentUsers) {
            Write-Host "✓ 4. Blueprint configured to create Agent ID users" -ForegroundColor Green
        }
        else {
            Write-Host "- 4. Blueprint configured to create Agent ID users (skipped by user choice)" -ForegroundColor Gray
        }

        if ($hasInheritablePermissions) {
            Write-Host "✓ 5. Inheritable permissions configured for agent users" -ForegroundColor Green
        }
        else {
            Write-Host "- 5. Inheritable permissions (skipped by user choice)" -ForegroundColor Gray
        }

        if ($hasInheritablePermissions -and $useStaticPermissions) {
            Write-Host "✓ 6. Static permissions configured via required resource access" -ForegroundColor Green
        }
        elseif ($hasInheritablePermissions -and -not $useStaticPermissions) {
            Write-Host "✓ 6. Dynamic permissions selected (resolved at runtime)" -ForegroundColor Green
        }
        else {
            Write-Host "- 6. Permission model selection (skipped - no inheritable permissions)" -ForegroundColor Gray
        }

        Write-Host "✓ 7. Consent obtained for the blueprint in this tenant" -ForegroundColor Green

        if ($allAgentIdentities.Count -gt 0) {
            Write-Host "✓ 8. Agent Identity and User Creation completed" -ForegroundColor Green
            Write-Host "    - Created $($allAgentIdentities.Count) Agent $(if ($allAgentIdentities.Count -eq 1) { 'Identity' } else { 'Identities' })" -ForegroundColor Green
            if ($blueprintWillCreateAgentUsers) {
                Write-Host "    - Created $($allAgentUsers.Count) Agent $(if ($allAgentUsers.Count -eq 1) { 'User' } else { 'Users' })" -ForegroundColor Green
            }
            else {
                Write-Host "    - No Agent Users created (not configured in Phase 4)" -ForegroundColor Gray
            }
        }
        else {
            Write-Host "- 8. Agent Identity and User creation (not completed)" -ForegroundColor Gray
        }

        Write-Host ""
        Write-Host "Module state:" -ForegroundColor Cyan
        Write-Host "Current Blueprint ID: $blueprint1" -ForegroundColor White
        Write-Host "Total Agent Identities created: $($allAgentIdentities.Count)" -ForegroundColor White
        Write-Host "Total Agent Users created: $($allAgentUsers.Count)" -ForegroundColor White
        Write-Host "Last Agent Identity ID: $(if ($agentIdentity) { $agentIdentity.id } else { 'None created' })" -ForegroundColor White
        Write-Host "Last Agent User ID: $(if ($agentUser) { $agentUser.id } else { 'None created' })" -ForegroundColor White
        Write-Host "Secret stored: $(if ($secret1) { 'Yes' } else { 'No' })" -ForegroundColor White
        Write-Host "Has inheritable permissions: $(if ($hasInheritablePermissions) { 'Yes' } else { 'No' })" -ForegroundColor White
        Write-Host "Has Agent ID users: $(if ($blueprintWillCreateAgentUsers) { 'Yes' } else { 'No' })" -ForegroundColor White
        Write-Host "Permission model: $(if (-not $hasInheritablePermissions) { 'N/A' } elseif ($useStaticPermissions) { 'Static' } else { 'Dynamic' })" -ForegroundColor White

        # Show all created Agent Identity IDs if any exist
        if ($allAgentIdentities.Count -gt 0) {
            Write-Verbose ""
            Write-Verbose "All created Agent Identity IDs:"
            for ($i = 0; $i -lt $allAgentIdentities.Count; $i++) {
                Write-Verbose "  $($i + 1). $($allAgentIdentities[$i].id)"
            }
        }

        # Show all created Agent User IDs if any exist
        if ($allAgentUsers.Count -gt 0) {
            Write-Verbose ""
            Write-Verbose "All created Agent User IDs:"
            for ($i = 0; $i -lt $allAgentUsers.Count; $i++) {
                Write-Verbose "  $($i + 1). $($allAgentUsers[$i].id) ($($allAgentUsers[$i].userPrincipalName))"
            }
        }
    }
}
