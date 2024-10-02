# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta
    }
    Import-Module .\test\module\Common-Functions.ps1 -Force

    Mock -CommandName Remove-MgBetaGroupAppRoleAssignment -MockWith {} -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Remove-EntraBetaGroupAppRoleAssignment" {
    Context "Test for Remove-EntraBetaGroupAppRoleAssignment" {
        It "Should return empty object" {
            $result = Remove-EntraBetaGroupAppRoleAssignment -GroupId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -AppRoleAssignmentId "a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgBetaGroupAppRoleAssignment -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should return empty object with Alias" {
            $result = Remove-EntraBetaGroupAppRoleAssignment -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -AppRoleAssignmentId "a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgBetaGroupAppRoleAssignment -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should fail when GroupId is empty" {
            { Remove-EntraBetaGroupAppRoleAssignment -GroupId  -AppRoleAssignmentId "a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1" } | Should -Throw "Missing an argument for parameter 'GroupId'*"
        }  
        It "Should fail when GroupId is invalid" {
            { Remove-EntraBetaGroupAppRoleAssignment -GroupId "" -AppRoleAssignmentId "a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1" } | Should -Throw "Cannot bind argument to parameter 'GroupId' because it is an empty string."
        }
        It "Should fail when AppRoleAssignmentId is empty" {
            { Remove-EntraBetaGroupAppRoleAssignment -GroupId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"  -AppRoleAssignmentId  } | Should -Throw "Missing an argument for parameter 'AppRoleAssignmentId'*"
        }  
        It "Should fail when AppRoleAssignmentId is invalid" {
            { Remove-EntraBetaGroupAppRoleAssignment -GroupId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -AppRoleAssignmentId "" } | Should -Throw "Cannot bind argument to parameter 'AppRoleAssignmentId' because it is an empty string."
        }
        It "Should contain GroupId in parameters when passed GroupId to it" { 
            Mock -CommandName Remove-MgBetaGroupAppRoleAssignment -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta

            $result = Remove-EntraBetaGroupAppRoleAssignment -GroupId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -AppRoleAssignmentId "a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1"
            $params = Get-Parameters -data $result
            $params.GroupId | Should -Be "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraBetaGroupAppRoleAssignment"
            Remove-EntraBetaGroupAppRoleAssignment -GroupId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -AppRoleAssignmentId "a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1"

            Should -Invoke -CommandName Remove-MgBetaGroupAppRoleAssignment -ModuleName Microsoft.Graph.Entra.Beta -Times 1 -ParameterFilter {
                $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
                $true
            }
        } 
        It "Should execute successfully without throwing an error " {
            # Disable confirmation prompts       
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'

            try {
                # Act & Assert: Ensure the function doesn't throw an exception
                { Remove-EntraBetaGroupAppRoleAssignment -GroupId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -AppRoleAssignmentId "a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        } 
    }
}