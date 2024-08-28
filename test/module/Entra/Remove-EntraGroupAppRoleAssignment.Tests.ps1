# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra
    }
    Import-Module .\test\module\Common-Functions.ps1 -Force

    Mock -CommandName Remove-MgGroupAppRoleAssignment -MockWith {} -ModuleName Microsoft.Graph.Entra
}

Describe "Remove-EntraGroupAppRoleAssignment" {
    Context "Test for Remove-EntraGroupAppRoleAssignment" {
        It "Should return empty object" {
            $result = Remove-EntraGroupAppRoleAssignment -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -AppRoleAssignmentId "a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgGroupAppRoleAssignment -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when ObjectId is empty" {
            { Remove-EntraGroupAppRoleAssignment -ObjectId  -AppRoleAssignmentId "a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1" } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
        }  
        It "Should fail when ObjectId is invalid" {
            { Remove-EntraGroupAppRoleAssignment -ObjectId "" -AppRoleAssignmentId "a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1" } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }
        It "Should fail when AppRoleAssignmentId is empty" {
            { Remove-EntraGroupAppRoleAssignment -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"  -AppRoleAssignmentId  } | Should -Throw "Missing an argument for parameter 'AppRoleAssignmentId'*"
        }  
        It "Should fail when AppRoleAssignmentId is invalid" {
            { Remove-EntraGroupAppRoleAssignment -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -AppRoleAssignmentId "" } | Should -Throw "Cannot bind argument to parameter 'AppRoleAssignmentId' because it is an empty string."
        }
        It "Should contain GroupId in parameters when passed ObjectId to it" { 
            Mock -CommandName Remove-MgGroupAppRoleAssignment -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $result = Remove-EntraGroupAppRoleAssignment -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -AppRoleAssignmentId "a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1"
            $params = Get-Parameters -data $result
            $params.GroupId | Should -Be "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
        }
        It "Should contain 'User-Agent' header" {
            Mock -CommandName Remove-MgGroupAppRoleAssignment -MockWith {$args} -ModuleName Microsoft.Graph.Entra
            
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraGroupAppRoleAssignment"

            $result = Remove-EntraGroupAppRoleAssignment -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -AppRoleAssignmentId "a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1"
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }
        It "Should execute successfully without throwing an error " {
            # Disable confirmation prompts       
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'

            try {
                # Act & Assert: Ensure the function doesn't throw an exception
                { Remove-EntraGroupAppRoleAssignment -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -AppRoleAssignmentId "a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        } 
    }
}