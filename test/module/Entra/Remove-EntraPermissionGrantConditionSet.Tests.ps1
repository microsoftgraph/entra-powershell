# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra        
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Remove-MgPolicyPermissionGrantPolicyInclude -MockWith {} -ModuleName Microsoft.Graph.Entra

    Mock -CommandName Remove-MgPolicyPermissionGrantPolicyExclude -MockWith {} -ModuleName Microsoft.Graph.Entra
}

Describe "Remove-EntraPermissionGrantConditionSet"{
    Context "Test for Remove-EntraPermissionGrantConditionSet" {
        It "Should delete a permission grant condition set 'includes' from a policy"{
            $result = Remove-EntraPermissionGrantConditionSet -PolicyId "test1" -ConditionSetType "includes" -Id "ccccdddd-2222-eeee-3333-ffff4444aaaa"
            $result | Should -BeNullOrEmpty
            
            Should -Invoke -CommandName Remove-MgPolicyPermissionGrantPolicyInclude -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should delete a permission grant condition set 'excludes' from a policy"{
            $result = Remove-EntraPermissionGrantConditionSet -PolicyId "test1" -ConditionSetType "excludes" -Id "ccccdddd-2222-eeee-3333-ffff4444aaaa"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgPolicyPermissionGrantPolicyExclude -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should fail when PolicyId parameter are invalid when ConditionSetType is includes" {
            { Remove-EntraPermissionGrantConditionSet -PolicyId "" -ConditionSetType "includes" -Id "ccccdddd-2222-eeee-3333-ffff4444aaaa"} | Should -Throw "Cannot bind argument to parameter 'PolicyId' because it is an empty string.*"
        }

        It "Should fail when PolicyId parameter are empty when ConditionSetType is includes" {
            { Remove-EntraPermissionGrantConditionSet -PolicyId  -ConditionSetType "includes" -Id "ccccdddd-2222-eeee-3333-ffff4444aaaa" } | Should -Throw "Missing an argument for parameter*"
        }

        It "Should fail when PolicyId parameter are invalid when ConditionSetType is excludes" {
            { Remove-EntraPermissionGrantConditionSet -PolicyId "" -ConditionSetType "excludes" -Id "ccccdddd-2222-eeee-3333-ffff4444aaaa"} | Should -Throw "Cannot bind argument to parameter*"
        }

        It "Should fail when PolicyId parameter are empty when ConditionSetType is excludes" {
            { Remove-EntraPermissionGrantConditionSet -PolicyId  -ConditionSetType "excludes" -Id "ccccdddd-2222-eeee-3333-ffff4444aaaa" } | Should -Throw "Missing an argument for parameter*"
        }

        It "Should fail when Id parameter are empty when ConditionSetType is includes" {
            { Remove-EntraPermissionGrantConditionSet -PolicyId "test1" -ConditionSetType "includes" -Id } | Should -Throw "Missing an argument for parameter*"
        }

        It "Should fail when Id parameter are invalid when ConditionSetType is includes" {
            { Remove-EntraPermissionGrantConditionSet -PolicyId "test1" -ConditionSetType "includes" -Id "" } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string."
        }

        It "Should fail when Id parameter are invalid when ConditionSetType is excludes" {
            { Remove-EntraPermissionGrantConditionSet -PolicyId "test1" -ConditionSetType "excludes" -Id ""} | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string.*"
        }

        It "Should fail when Id parameter are empty when ConditionSetType is excludes" {
            { Remove-EntraPermissionGrantConditionSet -PolicyId "test1" -ConditionSetType "excludes" -Id  } | Should -Throw "Missing an argument for parameter*"
        }

        It "Should fail when ConditionSetType parameter are empty" {
            { Remove-EntraPermissionGrantConditionSet -PolicyId "test1" -Id "ccccdddd-2222-eeee-3333-ffff4444aaaa" -ConditionSetType } | Should -Throw "Missing an argument for parameter*"
        }

        It "Should fail when ConditionSetType parameter are invalid" {
            { Remove-EntraPermissionGrantConditionSet -PolicyId "test1" -Id "ccccdddd-2222-eeee-3333-ffff4444aaaa" -ConditionSetType "" } | Should -Throw "Cannot bind argument to parameter 'ConditionSetType' because it is an empty string."
        }

        It "Should contain PermissionGrantPolicyId in parameters when passed PolicyId to it" {   
            Mock -CommandName Remove-MgPolicyPermissionGrantPolicyInclude -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $result = Remove-EntraPermissionGrantConditionSet -PolicyId "test1" -ConditionSetType "includes" -Id "ccccdddd-2222-eeee-3333-ffff4444aaaa"
            $params = Get-Parameters -data $result
            $params.PermissionGrantPolicyId | Should -Be "test1"
        }

        It "Should contain PermissionGrantConditionSetId in parameters when passed Id to it" {   
            Mock -CommandName Remove-MgPolicyPermissionGrantPolicyInclude -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $result = Remove-EntraPermissionGrantConditionSet -PolicyId "test1" -ConditionSetType "includes" -Id "ccccdddd-2222-eeee-3333-ffff4444aaaa"
            $params = Get-Parameters -data $result
            $params.PermissionGrantConditionSetId | Should -Be "ccccdddd-2222-eeee-3333-ffff4444aaaa"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraPermissionGrantConditionSet"

            Remove-EntraPermissionGrantConditionSet -PolicyId "test1" -ConditionSetType "includes" -Id "ccccdddd-2222-eeee-3333-ffff4444aaaa"

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraPermissionGrantConditionSet"

            Should -Invoke -CommandName Remove-MgPolicyPermissionGrantPolicyInclude -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
                $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
                $true
            }
        } 
        It "Should execute successfully without throwing an error" {
            # Disable confirmation prompts       
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'

            try {
                # Act & Assert: Ensure the function doesn't throw an exception
                { Remove-EntraPermissionGrantConditionSet -PolicyId "test1" -ConditionSetType "includes" -Id "ccccdddd-2222-eeee-3333-ffff4444aaaa"-Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        } 
    }
}