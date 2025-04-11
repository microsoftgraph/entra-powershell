# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.Beta.Groups) -eq $null) {
        Import-Module Microsoft.Entra.Beta.Groups
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    Mock -CommandName Remove-MgBetaGroupAppRoleAssignment -MockWith {} -ModuleName Microsoft.Entra.Beta.Groups
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("Directory.ReadWrite.All") } } -ModuleName Microsoft.Entra.Beta.Groups
}

Describe "Remove-EntraBetaGroupAppRoleAssignment" {
    Context "Test for Remove-EntraBetaGroupAppRoleAssignment" {
        It "Should return empty object" {
            $result = Remove-EntraBetaGroupAppRoleAssignment -GroupId "aaaaaaaa-1111-2222-3333-cccccccccccc" -AppRoleAssignmentId "a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgBetaGroupAppRoleAssignment -ModuleName Microsoft.Entra.Beta.Groups -Times 1
        }
        It "Should return empty object with Alias" {
            $result = Remove-EntraBetaGroupAppRoleAssignment -ObjectId "aaaaaaaa-1111-2222-3333-cccccccccccc" -AppRoleAssignmentId "a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgBetaGroupAppRoleAssignment -ModuleName Microsoft.Entra.Beta.Groups -Times 1
        }
        It "Should fail when GroupId is empty" {
            { Remove-EntraBetaGroupAppRoleAssignment -GroupId -AppRoleAssignmentId "a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1" } | Should -Throw "Missing an argument for parameter 'GroupId'*"
        }  

        It "Should fail when AppRoleAssignmentId is empty" {
            { Remove-EntraBetaGroupAppRoleAssignment -GroupId "aaaaaaaa-1111-2222-3333-cccccccccccc" -AppRoleAssignmentId } | Should -Throw "Missing an argument for parameter 'AppRoleAssignmentId'*"
        }  

        It "Should contain GroupId in parameters when passed GroupId to it" { 
            Mock -CommandName Remove-MgBetaGroupAppRoleAssignment -MockWith { $args } -ModuleName Microsoft.Entra.Beta.Groups

            $result = Remove-EntraBetaGroupAppRoleAssignment -GroupId "aaaaaaaa-1111-2222-3333-cccccccccccc" -AppRoleAssignmentId "a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1"
            $params = Get-Parameters -data $result
            $params.GroupId | Should -Be "aaaaaaaa-1111-2222-3333-cccccccccccc"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraBetaGroupAppRoleAssignment"
            Remove-EntraBetaGroupAppRoleAssignment -GroupId "aaaaaaaa-1111-2222-3333-cccccccccccc" -AppRoleAssignmentId "a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1"

            Should -Invoke -CommandName Remove-MgBetaGroupAppRoleAssignment -ModuleName Microsoft.Entra.Beta.Groups -Times 1 -ParameterFilter {
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
                { Remove-EntraBetaGroupAppRoleAssignment -GroupId "aaaaaaaa-1111-2222-3333-cccccccccccc" -AppRoleAssignmentId "a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1" -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        } 
    }
}
