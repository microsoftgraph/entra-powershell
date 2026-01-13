# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

Describe "Tests for Add-EntraBetaPermissionToCreateAgentUsersToAgentIdentityBlueprintPrincipal" {
    BeforeEach {
        # Reset cache before each test
        InModuleScope Microsoft.Entra.Beta.Applications {
            $script:MSGraphServicePrincipalId = $null
        }
    }

    BeforeAll {
        if ((Get-Module -Name Microsoft.Entra.Beta.Applications) -eq $null) {
            Import-Module Microsoft.Entra.Beta.Applications      
        }
        Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

        $getBlueprintSpScriptblock = {
            @{
                "value" = @(
                    @{
                        "id"              = "sp-aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb"
                        "appId"           = "bbbbbbbb-2222-3333-4444-cccccccccccc"
                        "displayName"     = "Test Agent Blueprint Principal"
                    }
                )
            }
        }
        
        $getMsGraphSpScriptblock = {
            @{
                "value" = @(
                    @{
                        "id"              = "graph-sp-id"
                        "appId"           = "00000003-0000-0000-c000-000000000000"
                        "displayName"     = "Microsoft Graph"
                    }
                )
            }
        }

        $assignRoleScriptblock = {
            @{
                "id"               = "assignment-guid"
                "principalId"      = "sp-aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb"
                "resourceId"       = "graph-sp-id"
                "appRoleId"        = "4aa6e624-eee0-40ab-bdd8-f9639038a614"
            }
        }

        Mock -CommandName Invoke-MgGraphRequest -MockWith { param($Method, $Uri) 
            if ($Uri -like "*00000003-0000-0000-c000-000000000000*") { return $getMsGraphSpScriptblock.Invoke() }
            elseif ($Uri -like "*`$filter=appId*") { return $getBlueprintSpScriptblock.Invoke() }
            else { return $assignRoleScriptblock.Invoke() }
        } -ModuleName Microsoft.Entra.Beta.Applications
        
        Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("AgentIdentityBlueprint.ReadWrite.All", "AgentIdUser.ReadWrite.IdentityParentedBy") } } -ModuleName Microsoft.Entra.Beta.Applications
        
        # Set up a stored blueprint ID for testing in the module scope
        InModuleScope Microsoft.Entra.Beta.Applications {
            $script:CurrentAgentBlueprintId = "bbbbbbbb-2222-3333-4444-cccccccccccc"
        }
        
        # Define variables for use across tests
        $script:userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Add-EntraBetaPermissionToCreateAgentUsersToAgentIdentityBlueprintPrincipal"
    }
    
    AfterEach {
        # Restore BeforeAll values after tests that might have cleared them
        InModuleScope Microsoft.Entra.Beta.Applications {
            if (-not $script:CurrentAgentBlueprintId) {
                $script:CurrentAgentBlueprintId = "bbbbbbbb-2222-3333-4444-cccccccccccc"
            }
        }
    }

    It "Result should not be empty" {
        $result = Add-EntraBetaPermissionToCreateAgentUsersToAgentIdentityBlueprintPrincipal
        $result | Should -Not -BeNullOrEmpty
        $result.id | Should -Be "assignment-guid"
        $result.principalId | Should -Be "sp-aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb"
        $result.resourceId | Should -Be "graph-sp-id"
        $result.appRoleId | Should -Be "4aa6e624-eee0-40ab-bdd8-f9639038a614"
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Applications -Times 3
    }

    It "Should use stored blueprint ID when not provided" {
        $result = Add-EntraBetaPermissionToCreateAgentUsersToAgentIdentityBlueprintPrincipal
        $result | Should -Not -BeNullOrEmpty
        $result.AgentBlueprintId | Should -Be "bbbbbbbb-2222-3333-4444-cccccccccccc"
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Applications -Times 3
    }

    It "Should accept explicit AgentBlueprintId parameter" {
        $explicitBlueprintId = "cccccccc-3333-4444-5555-dddddddddddd"
        $result = Add-EntraBetaPermissionToCreateAgentUsersToAgentIdentityBlueprintPrincipal -AgentBlueprintId $explicitBlueprintId
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Applications -Times 3
    }

    It "Should cache Microsoft Graph Service Principal ID" {
        # First call should retrieve and cache
        InModuleScope Microsoft.Entra.Beta.Applications {
            $script:MSGraphServicePrincipalId = $null
        }
        $result1 = Add-EntraBetaPermissionToCreateAgentUsersToAgentIdentityBlueprintPrincipal
        $result1 | Should -Not -BeNullOrEmpty
        
        # Verify cached value was set
        InModuleScope Microsoft.Entra.Beta.Applications {
            $script:MSGraphServicePrincipalId | Should -Be "graph-sp-id"
        }
        
        # Second call should use cached value (fewer Invoke-MgGraphRequest calls)
        $result2 = Add-EntraBetaPermissionToCreateAgentUsersToAgentIdentityBlueprintPrincipal
        $result2 | Should -Not -BeNullOrEmpty
    }

    It "Should contain correct permission details in response" {
        $result = Add-EntraBetaPermissionToCreateAgentUsersToAgentIdentityBlueprintPrincipal
        $result.PermissionName | Should -Be "AgentIdUser.ReadWrite.IdentityParentedBy"
        $result.PermissionDescription | Should -Be "Allows creation of agent users parented to agent identities"
        $result.AgentBlueprintServicePrincipalId | Should -Be "sp-aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb"
        $result.MSGraphServicePrincipalId | Should -Be "graph-sp-id"
    }

    It "Should execute successfully without throwing an error" {
        { Add-EntraBetaPermissionToCreateAgentUsersToAgentIdentityBlueprintPrincipal } | Should -Not -Throw
    }

    It "Should fail when not connected" {
        Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.Beta.Applications
        { Add-EntraBetaPermissionToCreateAgentUsersToAgentIdentityBlueprintPrincipal -ErrorAction Stop } | Should -Throw "Not connected to Microsoft Graph*"
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Applications -Times 0
    }

    It "Should fail when no blueprint ID is available" {
        InModuleScope Microsoft.Entra.Beta.Applications {
            $script:CurrentAgentBlueprintId = $null
        }
        { Add-EntraBetaPermissionToCreateAgentUsersToAgentIdentityBlueprintPrincipal -ErrorAction Stop } | Should -Throw "*No Agent Blueprint ID*"
    }

    It "Should contain 'User-Agent' header" {
        $result = Add-EntraBetaPermissionToCreateAgentUsersToAgentIdentityBlueprintPrincipal
        $result | Should -Not -BeNullOrEmpty
        # Verify that at least one call (the POST call) contains the custom User-Agent header
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter {
            $null -ne $Headers -and $Headers.ContainsKey('User-Agent') -and $Headers['User-Agent'] -like "*EntraPowershell*Add-EntraBetaPermissionToCreateAgentUsersToAgentIdentityBlueprintPrincipal*"
        }
    }
}
