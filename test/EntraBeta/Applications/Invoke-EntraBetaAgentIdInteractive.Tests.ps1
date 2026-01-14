# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

Describe "Tests for Invoke-EntraBetaAgentIdInteractive" {
    BeforeAll {
        if ((Get-Module -Name Microsoft.Entra.Beta.Applications) -eq $null) {
            Import-Module Microsoft.Entra.Beta.Applications      
        }
        Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force
    }

    Context "Prerequisites and connection" {
        It "Should fail when not connected to Microsoft Graph" {
            Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.Beta.Applications
            
            { Invoke-EntraBetaAgentIdInteractive -ErrorAction Stop } | Should -Throw "*Not connected to Microsoft Graph*"
        }

        It "Should check for Entra context on execution" {
            Mock -CommandName Get-EntraContext -MockWith { 
                @{ Account = "test@example.com"; Scopes = @("Application.ReadWrite.All") }
            } -ModuleName Microsoft.Entra.Beta.Applications
            
            # Mock everything else to prevent actual execution
            Mock -CommandName Read-Host -MockWith { throw "Test completed - stopping execution" } -ModuleName Microsoft.Entra.Beta.Applications
            
            try {
                Invoke-EntraBetaAgentIdInteractive
            }
            catch {
                # Expected to throw from Read-Host mock
            }
            
            Should -Invoke -CommandName Get-EntraContext -ModuleName Microsoft.Entra.Beta.Applications -Times 1
        }
    }

    Context "Interactive input automation" {
        It "Should accept automated Read-Host responses for blueprint name" {
            Mock -CommandName Get-EntraContext -MockWith { 
                @{ Account = "test@example.com"; Scopes = @("Application.ReadWrite.All") }
            } -ModuleName Microsoft.Entra.Beta.Applications
            
            Mock -CommandName Invoke-MgGraphRequest -MockWith { 
                return @{ value = @(@{ id = "user-id"; userPrincipalName = "test@example.com" }) }
            } -ModuleName Microsoft.Entra.Beta.Applications
            
            $script:readHostCallCount = 0
            Mock -CommandName Read-Host -MockWith {
                $script:readHostCallCount++
                if ($script:readHostCallCount -eq 1) {
                    return "Test Blueprint"  # First call: blueprint name
                }
                throw "Test completed - Read-Host was called successfully"
            } -ModuleName Microsoft.Entra.Beta.Applications
            
            try {
                Invoke-EntraBetaAgentIdInteractive
            }
            catch {
                $_.Exception.Message | Should -BeLike "*Test completed*"
            }
            
            $script:readHostCallCount | Should -BeGreaterThan 0
        }

        It "Should handle yes/no prompts for feature flags" {
            Mock -CommandName Get-EntraContext -MockWith { 
                @{ Account = "test@example.com"; Scopes = @("Application.ReadWrite.All") }
            } -ModuleName Microsoft.Entra.Beta.Applications
            
            # Track which prompts were asked
            $script:promptsReceived = @()
            
            Mock -CommandName Read-Host -MockWith {
                $script:promptsReceived += $args[0]
                return "n"  # Answer no to everything
            } -ModuleName Microsoft.Entra.Beta.Applications
            
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
            } -ModuleName Microsoft.Entra.Beta.Applications
            
            Mock -CommandName New-EntraBetaAgentIdentityBlueprint -MockWith { 
                InModuleScope Microsoft.Entra.Beta.Applications {
                    $script:CurrentAgentBlueprintId = "test-id"
                    $script:CurrentAgentBlueprintAppId = "test-app-id"
                }
                return "test-id"
            } -ModuleName Microsoft.Entra.Beta.Applications
            
            Mock -CommandName Add-EntraBetaClientSecretToAgentIdentityBlueprint -MockWith {
                InModuleScope Microsoft.Entra.Beta.Applications {
                    $script:LastClientSecret = ConvertTo-SecureString "test-secret-value" -AsPlainText -Force
                }
                return @{ KeyId = "secret-id"; EndDateTime = (Get-Date).AddYears(1) }
            } -ModuleName Microsoft.Entra.Beta.Applications
            
            Mock -CommandName New-EntraBetaAgentIdentityBlueprintPrincipal -MockWith {
                return @{ id = "sp-id"; appId = "app-id" }
            } -ModuleName Microsoft.Entra.Beta.Applications
            
            Mock -CommandName New-EntraBetaAgentIDForAgentIdentityBlueprint -MockWith {
                return @{ id = "agent-id"; displayName = "Test Agent" }
            } -ModuleName Microsoft.Entra.Beta.Applications
            
            Mock -CommandName Start-Sleep -MockWith { } -ModuleName Microsoft.Entra.Beta.Applications
            Mock -CommandName Write-Host -MockWith { } -ModuleName Microsoft.Entra.Beta.Applications
            
            # This should complete without hanging
            Invoke-EntraBetaAgentIdInteractive
            
            # Verify prompts were presented
            $script:promptsReceived.Count | Should -BeGreaterThan 3
        }
    }

    Context "Workflow decisions" {
        BeforeEach {
            # Common mocks for all workflow tests
            Mock -CommandName Get-EntraContext -MockWith { 
                @{ Account = "test@example.com"; Scopes = @("Application.ReadWrite.All") }
            } -ModuleName Microsoft.Entra.Beta.Applications
            
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
            } -ModuleName Microsoft.Entra.Beta.Applications
            
            Mock -CommandName New-EntraBetaAgentIdentityBlueprint -MockWith {
                InModuleScope Microsoft.Entra.Beta.Applications {
                    $script:CurrentAgentBlueprintId = "test-blueprint-id"
                    $script:CurrentAgentBlueprintAppId = "test-app-id"
                }
                return "test-blueprint-id"
            } -ModuleName Microsoft.Entra.Beta.Applications
            
            Mock -CommandName Add-EntraBetaClientSecretToAgentIdentityBlueprint -MockWith {
                InModuleScope Microsoft.Entra.Beta.Applications {
                    $script:LastClientSecret = New-Object System.Security.SecureString
                    "test-secret-value".ToCharArray() | ForEach-Object { $script:LastClientSecret.AppendChar($_) }
                }
                return @{ 
                    KeyId = "secret-id"
                    EndDateTime = (Get-Date).AddYears(1)
                }
            } -ModuleName Microsoft.Entra.Beta.Applications
            
            Mock -CommandName Add-EntraBetaScopeToAgentIdentityBlueprint -MockWith {
                return @{ ScopeId = "scope-id" }
            } -ModuleName Microsoft.Entra.Beta.Applications
            
            Mock -CommandName Add-EntraBetaInheritablePermissionsToAgentIdentityBlueprint -MockWith {
                return @{ InheritableScopes = @("User.Read") }
            } -ModuleName Microsoft.Entra.Beta.Applications
            
            Mock -CommandName New-EntraBetaAgentIdentityBlueprintPrincipal -MockWith {
                return @{ id = "sp-id"; appId = "sp-app-id" }
            } -ModuleName Microsoft.Entra.Beta.Applications
            
            Mock -CommandName Add-EntraBetaPermissionToCreateAgentUsersToAgentIdentityBlueprintPrincipal -MockWith {
                return @{ id = "permission-id" }
            } -ModuleName Microsoft.Entra.Beta.Applications
            
            Mock -CommandName Add-EntraBetaPermissionsToInheritToAgentIdentityBlueprintPrincipal -MockWith {
                return @{ GrantedScopes = @("User.Read") }
            } -ModuleName Microsoft.Entra.Beta.Applications
            
            Mock -CommandName New-EntraBetaAgentIDForAgentIdentityBlueprint -MockWith {
                return @{ id = "agent-id-$(Get-Random)"; displayName = $DisplayName }
            } -ModuleName Microsoft.Entra.Beta.Applications
            
            Mock -CommandName New-EntraBetaAgentIDUserForAgentId -MockWith {
                return @{ id = "agent-user-id"; userPrincipalName = $UserPrincipalName }
            } -ModuleName Microsoft.Entra.Beta.Applications
            
            Mock -CommandName Start-Sleep -MockWith { } -ModuleName Microsoft.Entra.Beta.Applications
            Mock -CommandName Write-Host -MockWith { } -ModuleName Microsoft.Entra.Beta.Applications
        }

        It "Should skip optional features when user answers 'no'" {
            $script:readHostCallCount = 0
            Mock -CommandName Read-Host -MockWith {
                $script:readHostCallCount++
                switch ($script:readHostCallCount) {
                    1 { return "Test Blueprint" }  # Blueprint name
                    2 { return "n" }                # Don't use current user as sponsor
                    3 { return "n" }                # No interactive agents
                    4 { return "n" }                # No inheritable permissions
                    5 { return "n" }                # No Agent ID users
                    6 { return "y" }                # Use example names
                    7 { return "n" }                # Don't create another
                    default { return "n" }
                }
            } -ModuleName Microsoft.Entra.Beta.Applications
            
            Invoke-EntraBetaAgentIdInteractive
            
            # Verify optional cmdlets were NOT called
            Should -Invoke -CommandName Add-EntraBetaScopeToAgentIdentityBlueprint -ModuleName Microsoft.Entra.Beta.Applications -Times 0
            Should -Invoke -CommandName Add-EntraBetaInheritablePermissionsToAgentIdentityBlueprint -ModuleName Microsoft.Entra.Beta.Applications -Times 0
            Should -Invoke -CommandName Add-EntraBetaPermissionToCreateAgentUsersToAgentIdentityBlueprintPrincipal -ModuleName Microsoft.Entra.Beta.Applications -Times 0
            Should -Invoke -CommandName New-EntraBetaAgentIDUserForAgentId -ModuleName Microsoft.Entra.Beta.Applications -Times 0
            
            # But essential cmdlets should be called
            Should -Invoke -CommandName New-EntraBetaAgentIdentityBlueprint -ModuleName Microsoft.Entra.Beta.Applications -Times 1
            Should -Invoke -CommandName New-EntraBetaAgentIDForAgentIdentityBlueprint -ModuleName Microsoft.Entra.Beta.Applications -Times 1
        }

        It "Should enable optional features when user answers 'yes'" {
            $script:readHostCallCount = 0
            Mock -CommandName Read-Host -MockWith {
                $script:readHostCallCount++
                switch ($script:readHostCallCount) {
                    1 { return "" }             # Blueprint name (default)
                    2 { return "y" }            # Use current user as sponsor
                    3 { return "y" }            # Yes to interactive agents
                    4 { return "y" }            # Yes to inheritable permissions
                    5 { return "y" }            # Yes to Agent ID users
                    6 { return "" }             # Admin consent pause
                    7 { return "y" }            # Use example names
                    8 { return "y" }            # Agent ID needs user
                    9 { return "n" }            # Don't create another
                    default { return "n" }
                }
            } -ModuleName Microsoft.Entra.Beta.Applications
            
            Invoke-EntraBetaAgentIdInteractive
            
            # Verify all optional cmdlets were called
            Should -Invoke -CommandName Add-EntraBetaScopeToAgentIdentityBlueprint -ModuleName Microsoft.Entra.Beta.Applications -Times 1
            Should -Invoke -CommandName Add-EntraBetaInheritablePermissionsToAgentIdentityBlueprint -ModuleName Microsoft.Entra.Beta.Applications -Times 1
            Should -Invoke -CommandName Add-EntraBetaPermissionToCreateAgentUsersToAgentIdentityBlueprintPrincipal -ModuleName Microsoft.Entra.Beta.Applications -Times 1
            Should -Invoke -CommandName New-EntraBetaAgentIDUserForAgentId -ModuleName Microsoft.Entra.Beta.Applications -Times 1
        }

        It "Should create multiple Agent Identities when user continues" {
            $script:readHostCallCount = 0
            Mock -CommandName Read-Host -MockWith {
                $script:readHostCallCount++
                switch ($script:readHostCallCount) {
                    1 { return "" }             # Blueprint name (default)
                    2 { return "n" }            # Don't use sponsor
                    3 { return "n" }            # No interactive agents
                    4 { return "n" }            # No inheritable permissions
                    5 { return "n" }            # No Agent ID users
                    6 { return "y" }            # Use example names
                    7 { return "y" }            # Create another (Agent #2)
                    8 { return "y" }            # Create another (Agent #3)
                    9 { return "n" }            # Don't create another
                    default { return "n" }
                }
            } -ModuleName Microsoft.Entra.Beta.Applications
            
            Invoke-EntraBetaAgentIdInteractive
            
            # Should create 3 Agent Identities
            Should -Invoke -CommandName New-EntraBetaAgentIDForAgentIdentityBlueprint -ModuleName Microsoft.Entra.Beta.Applications -Times 3
        }
    }
}
