# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

Describe "Tests for Add-EntraInheritablePermissionsToAgentIdentityBlueprint" {
    BeforeAll {
        if ((Get-Module -Name Microsoft.Entra.Applications) -eq $null) {
            Import-Module Microsoft.Entra.Applications      
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

        Mock -CommandName Invoke-MgGraphRequest -MockWith $scriptblock -ModuleName Microsoft.Entra.Applications
        Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("AgentIdentityBlueprint.UpdateAuthProperties.All") } } -ModuleName Microsoft.Entra.Applications
        # Catch-all Read-Host mock: returns empty string for any unmatched prompt (e.g., Resource Application ID)
        Mock -CommandName Read-Host -MockWith { "" } -ModuleName Microsoft.Entra.Applications
        # Mock Read-Host for "another resource?" prompt — always say no
        Mock -CommandName Read-Host -MockWith { "n" } -ModuleName Microsoft.Entra.Applications -ParameterFilter { $Prompt -like "*another resource*" }
        # NOTE: Permission type mock (s/r/b) is defined per-test so each test can choose its own response

        # Set up a stored blueprint ID for testing in the module scope
        InModuleScope Microsoft.Entra.Applications {
            $script:CurrentAgentBlueprintId = "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb"
        }

        # Define variables for use across tests
        $script:userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Add-EntraInheritablePermissionsToAgentIdentityBlueprint"
    }

    AfterEach {
        # Restore BeforeAll values after tests that might have cleared them
        InModuleScope Microsoft.Entra.Applications {
            if (-not $script:CurrentAgentBlueprintId) {
                $script:CurrentAgentBlueprintId = "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb"
            }
        }
    }

    It "Result should not be empty when choosing both scopes and roles" {
        Mock -CommandName Read-Host -MockWith { "b" } -ModuleName Microsoft.Entra.Applications -ParameterFilter { $Prompt -like "*copes*oles*oth*" }
        Mock -CommandName Read-Host -MockWith { "n" } -ModuleName Microsoft.Entra.Applications -ParameterFilter { $Prompt -like "*another resource*" }
        $result = Add-EntraInheritablePermissionsToAgentIdentityBlueprint
        $result | Should -Not -BeNullOrEmpty
        $result.InheritableScopes | Should -Be "allAllowed"
        $result.InheritableRoles | Should -Be "allAllowed"
    }

    It "Should set only scopes when user chooses scopes" {
        Mock -CommandName Read-Host -MockWith { "s" } -ModuleName Microsoft.Entra.Applications -ParameterFilter { $Prompt -like "*copes*oles*oth*" }
        Mock -CommandName Read-Host -MockWith { "n" } -ModuleName Microsoft.Entra.Applications -ParameterFilter { $Prompt -like "*another resource*" }
        $result = Add-EntraInheritablePermissionsToAgentIdentityBlueprint
        $result | Should -Not -BeNullOrEmpty
        $result.InheritableScopes | Should -Be "allAllowed"
        $result.InheritableRoles | Should -Be "none"
    }

    It "Should set only roles when user chooses roles" {
        Mock -CommandName Read-Host -MockWith { "r" } -ModuleName Microsoft.Entra.Applications -ParameterFilter { $Prompt -like "*copes*oles*oth*" }
        Mock -CommandName Read-Host -MockWith { "n" } -ModuleName Microsoft.Entra.Applications -ParameterFilter { $Prompt -like "*another resource*" }
        $result = Add-EntraInheritablePermissionsToAgentIdentityBlueprint
        $result | Should -Not -BeNullOrEmpty
        $result.InheritableScopes | Should -Be "none"
        $result.InheritableRoles | Should -Be "allAllowed"
    }

    It "Should use default Microsoft Graph resource when not provided" {
        Mock -CommandName Read-Host -MockWith { "b" } -ModuleName Microsoft.Entra.Applications -ParameterFilter { $Prompt -like "*copes*oles*oth*" }
        Mock -CommandName Read-Host -MockWith { "n" } -ModuleName Microsoft.Entra.Applications -ParameterFilter { $Prompt -like "*another resource*" }
        $result = Add-EntraInheritablePermissionsToAgentIdentityBlueprint
        $result | Should -Not -BeNullOrEmpty
        $result.ResourceAppId | Should -Be "00000003-0000-0000-c000-000000000000"
        $result.ResourceAppName | Should -Be "Microsoft Graph"
    }

    It "Should accept custom ResourceAppId as GUID" {
        Mock -CommandName Read-Host -MockWith { "b" } -ModuleName Microsoft.Entra.Applications -ParameterFilter { $Prompt -like "*copes*oles*oth*" }
        Mock -CommandName Read-Host -MockWith { "n" } -ModuleName Microsoft.Entra.Applications -ParameterFilter { $Prompt -like "*another resource*" }
        $customGuid = [guid]"aaaabbbb-cccc-dddd-eeee-ffffffffffff"
        $result = Add-EntraInheritablePermissionsToAgentIdentityBlueprint -ResourceAppId $customGuid
        $result | Should -Not -BeNullOrEmpty
    }

    It "Should correctly identify Azure AD Graph resource by GUID" {
        Mock -CommandName Read-Host -MockWith { "b" } -ModuleName Microsoft.Entra.Applications -ParameterFilter { $Prompt -like "*copes*oles*oth*" }
        Mock -CommandName Read-Host -MockWith { "n" } -ModuleName Microsoft.Entra.Applications -ParameterFilter { $Prompt -like "*another resource*" }
        $aadGraphGuid = [guid]"00000002-0000-0000-c000-000000000000"
        $result = Add-EntraInheritablePermissionsToAgentIdentityBlueprint -ResourceAppId $aadGraphGuid
        $result.ResourceAppName | Should -Be "Azure Active Directory Graph"
    }

    It "Should handle custom resource GUID with proper naming" {
        Mock -CommandName Read-Host -MockWith { "b" } -ModuleName Microsoft.Entra.Applications -ParameterFilter { $Prompt -like "*copes*oles*oth*" }
        Mock -CommandName Read-Host -MockWith { "n" } -ModuleName Microsoft.Entra.Applications -ParameterFilter { $Prompt -like "*another resource*" }
        $customGuid = [guid]"11111111-2222-3333-4444-555555555555"
        $result = Add-EntraInheritablePermissionsToAgentIdentityBlueprint -ResourceAppId $customGuid
        $result.ResourceAppName | Should -Match "Custom Resource \(11111111-2222-3333-4444-555555555555\)"
    }

    It "Should throw error for invalid GUID format" {
        { Add-EntraInheritablePermissionsToAgentIdentityBlueprint -ResourceAppId "not-a-valid-guid" } | Should -Throw
    }

    It "Should fail when not connected" {
        Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.Applications
        { Add-EntraInheritablePermissionsToAgentIdentityBlueprint -ErrorAction Stop } | Should -Throw "Not connected to Microsoft Graph*"
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Applications -Times 0
    }

    It "Should prompt for blueprint ID when none is stored" {
        InModuleScope Microsoft.Entra.Applications {
            $script:CurrentAgentBlueprintId = $null
        }
        Mock -CommandName Read-Host -MockWith { "prompted-blueprint-id-1234" } -ModuleName Microsoft.Entra.Applications -ParameterFilter { $Prompt -like "*Agent Identity Blueprint ID*" }
        Mock -CommandName Read-Host -MockWith { "b" } -ModuleName Microsoft.Entra.Applications -ParameterFilter { $Prompt -like "*copes*oles*oth*" }
        Mock -CommandName Read-Host -MockWith { "n" } -ModuleName Microsoft.Entra.Applications -ParameterFilter { $Prompt -like "*another resource*" }
        $result = Add-EntraInheritablePermissionsToAgentIdentityBlueprint
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Read-Host -ModuleName Microsoft.Entra.Applications -ParameterFilter { $Prompt -like "*Agent Identity Blueprint ID*" }
    }

    It "Should fail when no blueprint ID is available and prompt is empty" {
        InModuleScope Microsoft.Entra.Applications {
            $script:CurrentAgentBlueprintId = $null
        }
        Mock -CommandName Read-Host -MockWith { "" } -ModuleName Microsoft.Entra.Applications -ParameterFilter { $Prompt -like "*Agent Identity Blueprint ID*" }
        { Add-EntraInheritablePermissionsToAgentIdentityBlueprint -ErrorAction Stop } | Should -Throw
    }

    It "Should accept explicit AgentBlueprintId parameter" {
        Mock -CommandName Read-Host -MockWith { "b" } -ModuleName Microsoft.Entra.Applications -ParameterFilter { $Prompt -like "*copes*oles*oth*" }
        Mock -CommandName Read-Host -MockWith { "n" } -ModuleName Microsoft.Entra.Applications -ParameterFilter { $Prompt -like "*another resource*" }
        $result = Add-EntraInheritablePermissionsToAgentIdentityBlueprint -AgentBlueprintId "explicit-blueprint-id"
        $result | Should -Not -BeNullOrEmpty
    }

    It "Should use correct v1.0 API endpoint" {
        Mock -CommandName Read-Host -MockWith { "b" } -ModuleName Microsoft.Entra.Applications -ParameterFilter { $Prompt -like "*copes*oles*oth*" }
        Mock -CommandName Read-Host -MockWith { "n" } -ModuleName Microsoft.Entra.Applications -ParameterFilter { $Prompt -like "*another resource*" }
        $result = Add-EntraInheritablePermissionsToAgentIdentityBlueprint
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Applications -ParameterFilter {
            $Uri -like "*/v1.0/applications/microsoft.graph.agentIdentityBlueprint/aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb/inheritablePermissions*"
        }
    }

    It "Should return result with expected properties" {
        Mock -CommandName Read-Host -MockWith { "b" } -ModuleName Microsoft.Entra.Applications -ParameterFilter { $Prompt -like "*copes*oles*oth*" }
        Mock -CommandName Read-Host -MockWith { "n" } -ModuleName Microsoft.Entra.Applications -ParameterFilter { $Prompt -like "*another resource*" }
        $result = Add-EntraInheritablePermissionsToAgentIdentityBlueprint
        $result.AgentBlueprintId | Should -Be "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb"
        $result.ResourceAppId | Should -Not -BeNullOrEmpty
        $result.ConfiguredAt | Should -Not -BeNullOrEmpty
    }
}
