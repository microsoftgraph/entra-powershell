# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

Describe "Tests for Add-EntraPermissionToCreateAgentUsersToAgentIdentityBlueprintPrincipal" {
    BeforeEach {
        # Reset cache before each test
        InModuleScope Microsoft.Entra.Applications {
            $script:MSGraphServicePrincipalId = $null
        }
    }

    BeforeAll {
        if ((Get-Module -Name Microsoft.Entra.Applications) -eq $null) {
            Import-Module Microsoft.Entra.Applications      
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
        } -ModuleName Microsoft.Entra.Applications
        
        Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("AgentIdentityBlueprint.UpdateAuthProperties.All", "AgentIdUser.ReadWrite.IdentityParentedBy") } } -ModuleName Microsoft.Entra.Applications
        # Safety net: mock Read-Host to return empty string so tests never hang on interactive prompts
        Mock -CommandName Read-Host -ModuleName Microsoft.Entra.Applications -MockWith { "" }
        
        # Set up a stored blueprint ID for testing in the module scope
        InModuleScope Microsoft.Entra.Applications {
            $script:CurrentAgentBlueprintId = "bbbbbbbb-2222-3333-4444-cccccccccccc"
        }
        
        # Define variables for use across tests
        $script:userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Add-EntraPermissionToCreateAgentUsersToAgentIdentityBlueprintPrincipal"
    }
    
    AfterEach {
        # Restore BeforeAll values after tests that might have cleared them
        InModuleScope Microsoft.Entra.Applications {
            if (-not $script:CurrentAgentBlueprintId) {
                $script:CurrentAgentBlueprintId = "bbbbbbbb-2222-3333-4444-cccccccccccc"
            }
        }
    }

    It "Result should not be empty" {
        $result = Add-EntraPermissionToCreateAgentUsersToAgentIdentityBlueprintPrincipal
        $result | Should -Not -BeNullOrEmpty
        $result.id | Should -Be "assignment-guid"
        $result.principalId | Should -Be "sp-aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb"
        $result.resourceId | Should -Be "graph-sp-id"
        $result.appRoleId | Should -Be "4aa6e624-eee0-40ab-bdd8-f9639038a614"
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Applications -Times 3
    }

    It "Should use stored blueprint ID when not provided" {
        $result = Add-EntraPermissionToCreateAgentUsersToAgentIdentityBlueprintPrincipal
        $result | Should -Not -BeNullOrEmpty
        $result.AgentBlueprintId | Should -Be "bbbbbbbb-2222-3333-4444-cccccccccccc"
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Applications -Times 3
    }

    It "Should accept explicit AgentBlueprintId parameter" {
        $explicitBlueprintId = "cccccccc-3333-4444-5555-dddddddddddd"
        $result = Add-EntraPermissionToCreateAgentUsersToAgentIdentityBlueprintPrincipal -AgentBlueprintId $explicitBlueprintId
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Applications -Times 3
    }

    It "Should prompt when no stored ID and no parameter" {
        InModuleScope Microsoft.Entra.Applications {
            $script:CurrentAgentBlueprintId = $null
        }
        Mock -CommandName Read-Host -MockWith { "prompted-blueprint-id" } -ModuleName Microsoft.Entra.Applications
        $result = Add-EntraPermissionToCreateAgentUsersToAgentIdentityBlueprintPrincipal
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Read-Host -ModuleName Microsoft.Entra.Applications -Times 1
    }

    It "Should fail when prompt is dismissed with empty input" {
        InModuleScope Microsoft.Entra.Applications {
            $script:CurrentAgentBlueprintId = $null
        }
        Mock -CommandName Read-Host -ModuleName Microsoft.Entra.Applications -MockWith { "" }
        { Add-EntraPermissionToCreateAgentUsersToAgentIdentityBlueprintPrincipal } | Should -Throw
    }

    It "Should cache Microsoft Graph Service Principal ID" {
        # First call should retrieve and cache
        InModuleScope Microsoft.Entra.Applications {
            $script:MSGraphServicePrincipalId = $null
        }
        $result1 = Add-EntraPermissionToCreateAgentUsersToAgentIdentityBlueprintPrincipal
        $result1 | Should -Not -BeNullOrEmpty
        
        # Verify cached value was set
        InModuleScope Microsoft.Entra.Applications {
            $script:MSGraphServicePrincipalId | Should -Be "graph-sp-id"
        }
        
        # Second call should use cached value (fewer Invoke-MgGraphRequest calls)
        $result2 = Add-EntraPermissionToCreateAgentUsersToAgentIdentityBlueprintPrincipal
        $result2 | Should -Not -BeNullOrEmpty
    }

    It "Should contain correct permission details in response" {
        $result = Add-EntraPermissionToCreateAgentUsersToAgentIdentityBlueprintPrincipal
        $result.PermissionName | Should -Be "AgentIdUser.ReadWrite.IdentityParentedBy"
        $result.PermissionDescription | Should -Be "Allows creation of agent users parented to agent identities"
        $result.AgentBlueprintServicePrincipalId | Should -Be "sp-aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb"
        $result.MSGraphServicePrincipalId | Should -Be "graph-sp-id"
    }

    It "Should execute successfully without throwing an error" {
        { Add-EntraPermissionToCreateAgentUsersToAgentIdentityBlueprintPrincipal } | Should -Not -Throw
    }

    It "Should fail when not connected" {
        Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.Applications
        { Add-EntraPermissionToCreateAgentUsersToAgentIdentityBlueprintPrincipal -ErrorAction Stop } | Should -Throw "Not connected to Microsoft Graph*"
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Applications -Times 0
    }

    It "Should contain 'User-Agent' header" {
        $result = Add-EntraPermissionToCreateAgentUsersToAgentIdentityBlueprintPrincipal
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Applications -ParameterFilter {
            $null -ne $Headers -and $Headers.ContainsKey('User-Agent') -and $Headers['User-Agent'] -like "*EntraPowershell*Add-EntraPermissionToCreateAgentUsersToAgentIdentityBlueprintPrincipal*"
        }
    }

    It "Should POST to the correct appRoleAssignments endpoint" {
        $result = Add-EntraPermissionToCreateAgentUsersToAgentIdentityBlueprintPrincipal
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Applications -ParameterFilter {
            $Method -eq 'POST' -and $Uri -like "*/servicePrincipals/*/appRoleAssignments"
        }
    }

    It "Should use v1.0 API endpoint" {
        $result = Add-EntraPermissionToCreateAgentUsersToAgentIdentityBlueprintPrincipal
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Applications -ParameterFilter {
            $Uri -like "/v1.0/*"
        }
    }

    It "Should store blueprint service principal ID in module variable" {
        $result = Add-EntraPermissionToCreateAgentUsersToAgentIdentityBlueprintPrincipal
        InModuleScope Microsoft.Entra.Applications {
            $script:CurrentAgentBlueprintServicePrincipalId | Should -Be "sp-aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb"
        }
    }
}
