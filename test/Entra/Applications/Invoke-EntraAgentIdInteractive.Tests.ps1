# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

Describe "Tests for Invoke-EntraAgentIdInteractive" {
    BeforeAll {
        if ((Get-Module -Name Microsoft.Entra.Applications) -eq $null) {
            Import-Module Microsoft.Entra.Applications      
        }
        Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force
    }

    Context "Prerequisites and connection" {
        It "Should fail when not connected to Microsoft Graph" {
            Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.Applications
            
            { Invoke-EntraAgentIdInteractive -ErrorAction Stop } | Should -Throw "*Not connected to Microsoft Graph*"
        }

        It "Should check for Entra context on execution" {
            Mock -CommandName Get-EntraContext -MockWith { 
                @{ Account = "test@example.com"; Scopes = @("Application.ReadWrite.All") }
            } -ModuleName Microsoft.Entra.Applications
            
            # Mock everything else to prevent actual execution
            Mock -CommandName Read-Host -MockWith { throw "Test completed - stopping execution" } -ModuleName Microsoft.Entra.Applications
            
            try {
                Invoke-EntraAgentIdInteractive
            }
            catch {
                # Expected to throw from Read-Host mock
            }
            
            Should -Invoke -CommandName Get-EntraContext -ModuleName Microsoft.Entra.Applications -Times 1
        }
    }

    Context "Interactive input automation" {
        It "Should accept automated Read-Host responses for blueprint name" {
            Mock -CommandName Get-EntraContext -MockWith { 
                @{ Account = "test@example.com"; Scopes = @("Application.ReadWrite.All") }
            } -ModuleName Microsoft.Entra.Applications
            
            Mock -CommandName Invoke-MgGraphRequest -MockWith { 
                return @{ value = @(@{ id = "user-id"; userPrincipalName = "test@example.com" }) }
            } -ModuleName Microsoft.Entra.Applications
            
            $script:readHostCallCount = 0
            Mock -CommandName Read-Host -MockWith {
                $script:readHostCallCount++
                if ($script:readHostCallCount -eq 1) {
                    return "Test Blueprint"  # First call: blueprint name
                }
                throw "Test completed - Read-Host was called successfully"
            } -ModuleName Microsoft.Entra.Applications
            
            try {
                Invoke-EntraAgentIdInteractive
            }
            catch {
                $_.Exception.Message | Should -BeLike "*Test completed*"
            }
            
            $script:readHostCallCount | Should -BeGreaterThan 0
        }

        It "Should handle yes/no prompts for feature flags" {
            Mock -CommandName Get-EntraContext -MockWith { 
                @{ Account = "test@example.com"; Scopes = @("Application.ReadWrite.All") }
            } -ModuleName Microsoft.Entra.Applications
            
            # Track which prompts were asked
            $script:promptsReceived = @()
            
            Mock -CommandName Read-Host -MockWith {
                $script:promptsReceived += $args[0]
                return "n"  # Answer no to everything
            } -ModuleName Microsoft.Entra.Applications
            
            # Mock all dependent cmdlets to prevent actual execution
            Mock -CommandName Invoke-MgGraphRequest -MockWith { 
                param($Uri)
                if ($Uri -like "*users*") {
                    return @{ value = @(@{ id = "user-id"; userPrincipalName = "test@example.com" }) }
                }
                elseif ($Uri -like "*servicePrincipals*") {
                    return @{ id = "sp-id"; appId = "sp-app-id" }
                }
                elseif ($Uri -like "*organization*") {
                    return @{ value = @(@{ verifiedDomains = @(@{ isDefault = $true; name = "example.com" }) }) }
                }
                return @{ value = @() }
            } -ModuleName Microsoft.Entra.Applications
            
            Mock -CommandName New-EntraAgentIdentityBlueprint -MockWith { 
                InModuleScope Microsoft.Entra.Applications {
                    $script:CurrentAgentBlueprintId = "test-id"
                    $script:CurrentAgentBlueprintAppId = "test-app-id"
                }
                return "test-id"
            } -ModuleName Microsoft.Entra.Applications
            
            Mock -CommandName Add-EntraClientSecretToAgentIdentityBlueprint -MockWith {
                InModuleScope Microsoft.Entra.Applications {
                    $script:LastClientSecret = New-Object System.Security.SecureString
                    "test-secret-value".ToCharArray() | ForEach-Object { $script:LastClientSecret.AppendChar($_) }
                }
                return @{ KeyId = "secret-id"; SecretText = "test-secret-value"; EndDateTime = (Get-Date).AddYears(1) }
            } -ModuleName Microsoft.Entra.Applications
            
            Mock -CommandName New-EntraAgentIdentityBlueprintPrincipal -MockWith {
                return @{ id = "sp-id"; appId = "app-id" }
            } -ModuleName Microsoft.Entra.Applications
            
            Mock -CommandName New-EntraAgentIDForAgentIdentityBlueprint -MockWith {
                return @{ id = "agent-id"; displayName = "Test Agent" }
            } -ModuleName Microsoft.Entra.Applications
            
            Mock -CommandName Start-Sleep -MockWith { } -ModuleName Microsoft.Entra.Applications
            Mock -CommandName Write-Host -MockWith { } -ModuleName Microsoft.Entra.Applications
            
            # This should complete without hanging
            Invoke-EntraAgentIdInteractive
            
            # Verify prompts were presented
            $script:promptsReceived.Count | Should -BeGreaterThan 3
        }
    }

    Context "Workflow decisions" {
        BeforeEach {
            # Common mocks for all workflow tests
            Mock -CommandName Get-EntraContext -MockWith { 
                @{ Account = "test@example.com"; Scopes = @("Application.ReadWrite.All") }
            } -ModuleName Microsoft.Entra.Applications
            
            Mock -CommandName Invoke-MgGraphRequest -MockWith {
                if ($Uri -like "*users?*filter=userPrincipalName*") {
                    return @{ value = @(@{ id = "user-id"; userPrincipalName = "test@example.com" }) }
                }
                if ($Uri -like "*organization*") {
                    return @{ value = @(@{ verifiedDomains = @(@{ name = "example.com"; isDefault = $true }) }) }
                }
                if ($Uri -like "*servicePrincipals/*") {
                    return @{ id = "sp-id"; appId = "app-id" }
                }
                return @{}
            } -ModuleName Microsoft.Entra.Applications
            
            Mock -CommandName New-EntraAgentIdentityBlueprint -MockWith {
                InModuleScope Microsoft.Entra.Applications {
                    $script:CurrentAgentBlueprintId = "test-blueprint-id"
                    $script:CurrentAgentBlueprintAppId = "test-app-id"
                }
                return "test-blueprint-id"
            } -ModuleName Microsoft.Entra.Applications
            
            Mock -CommandName Add-EntraClientSecretToAgentIdentityBlueprint -MockWith {
                InModuleScope Microsoft.Entra.Applications {
                    $script:LastClientSecret = New-Object System.Security.SecureString
                    "test-secret-value".ToCharArray() | ForEach-Object { $script:LastClientSecret.AppendChar($_) }
                }
                return @{ 
                    KeyId = "secret-id"
                    SecretText = "test-secret-value"
                    EndDateTime = (Get-Date).AddYears(1)
                }
            } -ModuleName Microsoft.Entra.Applications
            
            Mock -CommandName Add-EntraScopeToAgentIdentityBlueprint -MockWith {
                return @{ ScopeId = "scope-id" }
            } -ModuleName Microsoft.Entra.Applications
            
            Mock -CommandName Add-EntraInheritablePermissionsToAgentIdentityBlueprint -MockWith {
                return @{ InheritableScopes = @("User.Read") }
            } -ModuleName Microsoft.Entra.Applications
            
            Mock -CommandName New-EntraAgentIdentityBlueprintPrincipal -MockWith {
                return @{ id = "sp-id"; appId = "sp-app-id" }
            } -ModuleName Microsoft.Entra.Applications
            
            Mock -CommandName Add-EntraPermissionToCreateAgentUsersToAgentIdentityBlueprintPrincipal -MockWith {
                return @{ id = "permission-id" }
            } -ModuleName Microsoft.Entra.Applications
            
            Mock -CommandName Add-EntraPermissionsToInheritToAgentIdentityBlueprintPrincipal -MockWith {
                return @{ GrantedScopes = @("User.Read") }
            } -ModuleName Microsoft.Entra.Applications
            
            Mock -CommandName New-EntraAgentIDForAgentIdentityBlueprint -MockWith {
                return @{ id = "agent-id-$(Get-Random)"; displayName = $DisplayName }
            } -ModuleName Microsoft.Entra.Applications
            
            Mock -CommandName New-EntraAgentUserForAgentId -MockWith {
                return @{ id = "agent-user-id"; userPrincipalName = $UserPrincipalName }
            } -ModuleName Microsoft.Entra.Applications
            
            Mock -CommandName Start-Sleep -MockWith { } -ModuleName Microsoft.Entra.Applications
            Mock -CommandName Write-Host -MockWith { } -ModuleName Microsoft.Entra.Applications
        }

        It "Should skip optional features when user answers 'no'" {
            $script:readHostCallCount = 0
            Mock -CommandName Read-Host -MockWith {
                $script:readHostCallCount++
                switch ($script:readHostCallCount) {
                    1 { return "Test Blueprint" }  # Phase 1: Blueprint name
                    2 { return "n" }                # Phase 1: Don't use current user as sponsor
                    3 { return "n" }                # Phase 3: No interactive agents
                    4 { return "n" }                # Phase 4: No agent users
                    5 { return "n" }                # Phase 5: No inheritable permissions
                    # Phase 6: skipped (no inheritable permissions)
                    # Phase 7: no consent needed, creates SP directly
                    6 { return "y" }                # Phase 8: Yes, create agents
                    7 { return "y" }                # Phase 8: Use example names
                    8 { return "n" }                # Phase 8: Don't create another
                    default { return "n" }
                }
            } -ModuleName Microsoft.Entra.Applications
            
            Invoke-EntraAgentIdInteractive
            
            # Verify optional cmdlets were NOT called
            Should -Invoke -CommandName Add-EntraScopeToAgentIdentityBlueprint -ModuleName Microsoft.Entra.Applications -Times 0
            Should -Invoke -CommandName Add-EntraInheritablePermissionsToAgentIdentityBlueprint -ModuleName Microsoft.Entra.Applications -Times 0
            Should -Invoke -CommandName New-EntraAgentUserForAgentId -ModuleName Microsoft.Entra.Applications -Times 0
            
            # Service principal created directly (no consent needed)
            Should -Invoke -CommandName New-EntraAgentIdentityBlueprintPrincipal -ModuleName Microsoft.Entra.Applications -Times 1
            
            # Essential cmdlets should be called
            Should -Invoke -CommandName New-EntraAgentIdentityBlueprint -ModuleName Microsoft.Entra.Applications -Times 1
            Should -Invoke -CommandName New-EntraAgentIDForAgentIdentityBlueprint -ModuleName Microsoft.Entra.Applications -Times 1
        }

        It "Should enable optional features when user answers 'yes'" {
            # Add mock for Add-EntraRequiredResourceAccessToAgentIdentityBlueprint (Phase 6 static permissions)
            Mock -CommandName Add-EntraRequiredResourceAccessToAgentIdentityBlueprint -MockWith {
                return @{ id = "rra-id" }
            } -ModuleName Microsoft.Entra.Applications
            
            # Override Invoke-MgGraphRequest to return appRoles for servicePrincipals filter query
            Mock -CommandName Invoke-MgGraphRequest -MockWith {
                if ($Uri -like "*users?*filter=userPrincipalName*") {
                    return @{ value = @(@{ id = "user-id"; userPrincipalName = "test@example.com" }) }
                }
                if ($Uri -like "*organization*") {
                    return @{ value = @(@{ verifiedDomains = @(@{ name = "example.com"; isDefault = $true }) }) }
                }
                if ($Uri -like "*servicePrincipals?*filter*appId*") {
                    return @{ value = @(@{
                        appRoles = @(@{
                            id = "role-guid-123"
                            value = "AgentIdUser.ReadWrite.IdentityParentedBy"
                        })
                    }) }
                }
                if ($Uri -like "*servicePrincipals/*") {
                    return @{ id = "sp-id"; appId = "app-id" }
                }
                return @{}
            } -ModuleName Microsoft.Entra.Applications

            $script:readHostCallCount = 0
            Mock -CommandName Read-Host -MockWith {
                $script:readHostCallCount++
                switch ($script:readHostCallCount) {
                    1 { return "" }             # Phase 1: Blueprint name (default)
                    2 { return "y" }            # Phase 1: Use current user as sponsor
                    3 { return "y" }            # Phase 3: Yes to interactive agents
                    4 { return "y" }            # Phase 4: Yes to agent users
                    5 { return "y" }            # Phase 5: Yes to inheritable permissions
                    6 { return "y" }            # Phase 6: Yes to static permissions
                    # Phase 6: auto-adds AgentIdUser role via -Silent, then interactive call (mocked)
                    # Phase 7: static → .default consent via Add-EntraPermissionsToInheritToAgentIdentityBlueprintPrincipal
                    7 { return "" }             # Phase 7: Press Enter after admin consent
                    8 { return "y" }            # Phase 8: Yes, create agents
                    9 { return "y" }            # Phase 8: Use example names
                    10 { return "y" }           # Phase 8: Agent ID needs user
                    11 { return "n" }           # Phase 8: Don't create another
                    default { return "n" }
                }
            } -ModuleName Microsoft.Entra.Applications
            
            Invoke-EntraAgentIdInteractive
            
            # Verify optional cmdlets were called
            Should -Invoke -CommandName Add-EntraScopeToAgentIdentityBlueprint -ModuleName Microsoft.Entra.Applications -Times 1
            Should -Invoke -CommandName Add-EntraInheritablePermissionsToAgentIdentityBlueprint -ModuleName Microsoft.Entra.Applications -Times 1
            # Phase 6: static permissions adds required resource access (Silent for auto role + interactive)
            Should -Invoke -CommandName Add-EntraRequiredResourceAccessToAgentIdentityBlueprint -ModuleName Microsoft.Entra.Applications -Times 2
            # Phase 7: consent via .default scope
            Should -Invoke -CommandName Add-EntraPermissionsToInheritToAgentIdentityBlueprintPrincipal -ModuleName Microsoft.Entra.Applications -Times 1
            # Phase 8: agent and user creation
            Should -Invoke -CommandName New-EntraAgentIDForAgentIdentityBlueprint -ModuleName Microsoft.Entra.Applications -Times 1
            Should -Invoke -CommandName New-EntraAgentUserForAgentId -ModuleName Microsoft.Entra.Applications -Times 1
        }

        It "Should create multiple Agent Identities when user continues" {
            $script:readHostCallCount = 0
            Mock -CommandName Read-Host -MockWith {
                $script:readHostCallCount++
                switch ($script:readHostCallCount) {
                    1 { return "" }             # Phase 1: Blueprint name (default)
                    2 { return "n" }            # Phase 1: Don't use sponsor
                    3 { return "n" }            # Phase 3: No interactive agents
                    4 { return "n" }            # Phase 4: No agent users
                    5 { return "n" }            # Phase 5: No inheritable permissions
                    # Phase 6: skipped (no inheritable permissions)
                    # Phase 7: no consent needed, creates SP directly
                    6 { return "y" }            # Phase 8: Yes, create agents
                    7 { return "y" }            # Phase 8: Use example names
                    # Agent #1 created
                    8 { return "y" }            # Phase 8: Create another
                    # Agent #2 created
                    9 { return "y" }            # Phase 8: Create another
                    # Agent #3 created
                    10 { return "n" }           # Phase 8: Don't create another
                    default { return "n" }
                }
            } -ModuleName Microsoft.Entra.Applications
            
            Invoke-EntraAgentIdInteractive
            
            # Should create 3 Agent Identities
            Should -Invoke -CommandName New-EntraAgentIDForAgentIdentityBlueprint -ModuleName Microsoft.Entra.Applications -Times 3
        }

        It "Should skip agent creation when user declines in Phase 8" {
            $script:readHostCallCount = 0
            Mock -CommandName Read-Host -MockWith {
                $script:readHostCallCount++
                switch ($script:readHostCallCount) {
                    1 { return "Test Blueprint" }  # Phase 1: Blueprint name
                    2 { return "n" }                # Phase 1: Don't use sponsor
                    3 { return "n" }                # Phase 3: No interactive agents
                    4 { return "n" }                # Phase 4: No agent users
                    5 { return "n" }                # Phase 5: No inheritable permissions
                    6 { return "n" }                # Phase 8: No, don't create agents
                    default { return "n" }
                }
            } -ModuleName Microsoft.Entra.Applications
            
            Invoke-EntraAgentIdInteractive
            
            # Agent creation cmdlets should NOT be called
            Should -Invoke -CommandName New-EntraAgentIDForAgentIdentityBlueprint -ModuleName Microsoft.Entra.Applications -Times 0
            Should -Invoke -CommandName New-EntraAgentUserForAgentId -ModuleName Microsoft.Entra.Applications -Times 0
            
            # But blueprint should still be created
            Should -Invoke -CommandName New-EntraAgentIdentityBlueprint -ModuleName Microsoft.Entra.Applications -Times 1
        }

        It "Should contain 'User-Agent' header in custom headers" {
            $script:readHostCallCount = 0
            Mock -CommandName Read-Host -MockWith {
                $script:readHostCallCount++
                switch ($script:readHostCallCount) {
                    1 { return "Test Blueprint" }
                    2 { return "n" }
                    3 { return "n" }
                    4 { return "n" }
                    5 { return "n" }
                    6 { return "n" }
                    default { return "n" }
                }
            } -ModuleName Microsoft.Entra.Applications

            Mock -CommandName Invoke-MgGraphRequest -MockWith {
                $script:lastHeaders = $Headers
                if ($Uri -like "*users?*filter=userPrincipalName*") {
                    return @{ value = @(@{ id = "user-id"; userPrincipalName = "test@example.com" }) }
                }
                return @{}
            } -ModuleName Microsoft.Entra.Applications
            
            Invoke-EntraAgentIdInteractive

            $script:lastHeaders | Should -Not -BeNullOrEmpty
            $script:lastHeaders["User-Agent"] | Should -Match "Entra"
        }

        It "Should use v1.0 API endpoint for user lookup" {
            $script:capturedUris = @()
            $script:readHostCallCount = 0
            Mock -CommandName Read-Host -MockWith {
                $script:readHostCallCount++
                switch ($script:readHostCallCount) {
                    1 { return "Test Blueprint" }
                    2 { return "n" }
                    3 { return "n" }
                    4 { return "n" }
                    5 { return "n" }
                    6 { return "n" }
                    default { return "n" }
                }
            } -ModuleName Microsoft.Entra.Applications

            Mock -CommandName Invoke-MgGraphRequest -MockWith {
                $script:capturedUris += $Uri
                if ($Uri -like "*users*") {
                    return @{ value = @(@{ id = "user-id"; userPrincipalName = "test@example.com" }) }
                }
                return @{}
            } -ModuleName Microsoft.Entra.Applications

            Invoke-EntraAgentIdInteractive

            $userUri = $script:capturedUris | Where-Object { $_ -like "*users*" } | Select-Object -First 1
            $userUri | Should -BeLike "v1.0/*"
            $userUri | Should -Not -BeLike "*beta*"
        }
    }
}
