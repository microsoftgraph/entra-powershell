# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

Describe "Tests for Add-EntraBetaInheritablePermissionsToAgentIdentityBlueprint" {
    BeforeAll {
        if ((Get-Module -Name Microsoft.Entra.Beta.Applications) -eq $null) {
            Import-Module Microsoft.Entra.Beta.Applications      
        }
        Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

        $scriptblock = {
            @{
                "value" = @(
                    @{
                        "id"           = "permission-guid-1"
                        "resourceAppId" = "00000003-0000-0000-c000-000000000000"
                    }
                )
            }
        }

        Mock -CommandName Invoke-MgGraphRequest -MockWith $scriptblock -ModuleName Microsoft.Entra.Beta.Applications
        Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("AgentIdentityBlueprint.UpdateAuthProperties.All") } } -ModuleName Microsoft.Entra.Beta.Applications
        # Catch-all Read-Host mock: returns empty string for any unmatched prompt (e.g., Resource Application ID)
        Mock -CommandName Read-Host -MockWith { "" } -ModuleName Microsoft.Entra.Beta.Applications
        # Mock Read-Host for "another resource?" prompt — always say no
        Mock -CommandName Read-Host -MockWith { "n" } -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter { $Prompt -like "*another resource*" }
        # NOTE: Permission type mock (s/r/b) is defined per-test so each test can choose its own response

        # Set up a stored blueprint ID for testing in the module scope
        InModuleScope Microsoft.Entra.Beta.Applications {
            $script:CurrentAgentBlueprintId = "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb"
        }

        # Define variables for use across tests
        $script:userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Add-EntraBetaInheritablePermissionsToAgentIdentityBlueprint"
    }

    AfterEach {
        # Restore BeforeAll values after tests that might have cleared them
        InModuleScope Microsoft.Entra.Beta.Applications {
            if (-not $script:CurrentAgentBlueprintId) {
                $script:CurrentAgentBlueprintId = "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb"
            }
        }
    }

    It "Result should not be empty when choosing both scopes and roles" {
        Mock -CommandName Read-Host -MockWith { "b" } -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter { $Prompt -like "*copes*oles*oth*" }
        Mock -CommandName Read-Host -MockWith { "n" } -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter { $Prompt -like "*another resource*" }
        $result = Add-EntraBetaInheritablePermissionsToAgentIdentityBlueprint
        $result | Should -Not -BeNullOrEmpty
        $result.InheritableScopes | Should -Be "allAllowed"
        $result.InheritableRoles | Should -Be "allAllowed"
    }

    It "Should set only scopes when user chooses scopes" {
        Mock -CommandName Read-Host -MockWith { "s" } -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter { $Prompt -like "*copes*oles*oth*" }
        Mock -CommandName Read-Host -MockWith { "n" } -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter { $Prompt -like "*another resource*" }
        $result = Add-EntraBetaInheritablePermissionsToAgentIdentityBlueprint
        $result | Should -Not -BeNullOrEmpty
        $result.InheritableScopes | Should -Be "allAllowed"
        $result.InheritableRoles | Should -Be "none"
    }

    It "Should set only roles when user chooses roles" {
        Mock -CommandName Read-Host -MockWith { "r" } -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter { $Prompt -like "*copes*oles*oth*" }
        Mock -CommandName Read-Host -MockWith { "n" } -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter { $Prompt -like "*another resource*" }
        $result = Add-EntraBetaInheritablePermissionsToAgentIdentityBlueprint
        $result | Should -Not -BeNullOrEmpty
        $result.InheritableScopes | Should -Be "none"
        $result.InheritableRoles | Should -Be "allAllowed"
    }

    It "Should use default Microsoft Graph resource when not provided" {
        Mock -CommandName Read-Host -MockWith { "b" } -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter { $Prompt -like "*copes*oles*oth*" }
        Mock -CommandName Read-Host -MockWith { "n" } -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter { $Prompt -like "*another resource*" }
        $result = Add-EntraBetaInheritablePermissionsToAgentIdentityBlueprint
        $result | Should -Not -BeNullOrEmpty
        $result.ResourceAppId | Should -Be "00000003-0000-0000-c000-000000000000"
        $result.ResourceAppName | Should -Be "Microsoft Graph"
    }

    It "Should accept custom ResourceAppId as GUID" {
        Mock -CommandName Read-Host -MockWith { "b" } -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter { $Prompt -like "*copes*oles*oth*" }
        Mock -CommandName Read-Host -MockWith { "n" } -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter { $Prompt -like "*another resource*" }
        $customGuid = [guid]"aaaabbbb-cccc-dddd-eeee-ffffffffffff"
        $result = Add-EntraBetaInheritablePermissionsToAgentIdentityBlueprint -ResourceAppId $customGuid
        $result | Should -Not -BeNullOrEmpty
    }

    It "Should correctly identify Azure AD Graph resource by GUID" {
        Mock -CommandName Read-Host -MockWith { "b" } -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter { $Prompt -like "*copes*oles*oth*" }
        Mock -CommandName Read-Host -MockWith { "n" } -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter { $Prompt -like "*another resource*" }
        $aadGraphGuid = [guid]"00000002-0000-0000-c000-000000000000"
        $result = Add-EntraBetaInheritablePermissionsToAgentIdentityBlueprint -ResourceAppId $aadGraphGuid
        $result.ResourceAppName | Should -Be "Azure Active Directory Graph"
    }

    It "Should handle custom resource GUID with proper naming" {
        Mock -CommandName Read-Host -MockWith { "b" } -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter { $Prompt -like "*copes*oles*oth*" }
        Mock -CommandName Read-Host -MockWith { "n" } -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter { $Prompt -like "*another resource*" }
        $customGuid = [guid]"11111111-2222-3333-4444-555555555555"
        $result = Add-EntraBetaInheritablePermissionsToAgentIdentityBlueprint -ResourceAppId $customGuid
        $result.ResourceAppName | Should -Match "Custom Resource \(11111111-2222-3333-4444-555555555555\)"
    }

    It "Should throw error for invalid GUID format" {
        { Add-EntraBetaInheritablePermissionsToAgentIdentityBlueprint -ResourceAppId "not-a-valid-guid" } | Should -Throw
    }

    It "Should fail when not connected" {
        Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.Beta.Applications
        { Add-EntraBetaInheritablePermissionsToAgentIdentityBlueprint -ErrorAction Stop } | Should -Throw "Not connected to Microsoft Graph*"
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Applications -Times 0
    }

    It "Should fail when no blueprint ID is available" {
        InModuleScope Microsoft.Entra.Beta.Applications {
            $script:CurrentAgentBlueprintId = $null
        }
        { Add-EntraBetaInheritablePermissionsToAgentIdentityBlueprint -ErrorAction Stop } | Should -Throw "*No Agent Identity Blueprint ID*"
    }

    It "Should use correct API endpoint" {
        Mock -CommandName Read-Host -MockWith { "b" } -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter { $Prompt -like "*copes*oles*oth*" }
        Mock -CommandName Read-Host -MockWith { "n" } -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter { $Prompt -like "*another resource*" }
        $result = Add-EntraBetaInheritablePermissionsToAgentIdentityBlueprint
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter {
            $Uri -like "*/microsoft.graph.agentIdentityBlueprint/aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb/inheritablePermissions*"
        }
    }

    It "Should return result with expected properties" {
        Mock -CommandName Read-Host -MockWith { "b" } -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter { $Prompt -like "*copes*oles*oth*" }
        Mock -CommandName Read-Host -MockWith { "n" } -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter { $Prompt -like "*another resource*" }
        $result = Add-EntraBetaInheritablePermissionsToAgentIdentityBlueprint
        $result.AgentBlueprintId | Should -Be "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb"
        $result.ResourceAppId | Should -Not -BeNullOrEmpty
        $result.ConfiguredAt | Should -Not -BeNullOrEmpty
    }
}
