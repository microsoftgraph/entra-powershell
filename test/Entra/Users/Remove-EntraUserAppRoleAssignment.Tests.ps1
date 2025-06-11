# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.Users) -eq $null) {
        Import-Module Microsoft.Entra.Users       
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    Mock -CommandName Remove-MgUserAppRoleAssignment -MockWith {} -ModuleName Microsoft.Entra.Users
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("AppRoleAssignment.ReadWrite.All") } } -ModuleName Microsoft.Entra.Users
}
  
Describe "Remove-EntraUserAppRoleAssignment" {
    Context "Test for Remove-EntraUserAppRoleAssignment" {
        It "Should return empty object" {
            $result = Remove-EntraUserAppRoleAssignment -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -AppRoleAssignmentId "33dd33dd-ee44-ff55-aa66-77bb77bb77bb"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgUserAppRoleAssignment -ModuleName Microsoft.Entra.Users -Times 1
        }

        It "Should fail when UserId is invalid" {
            { Remove-EntraUserAppRoleAssignment -UserId "" AppRoleAssignmentId "33dd33dd-ee44-ff55-aa66-77bb77bb77bb" } | Should -Throw "Cannot validate argument on parameter 'UserId'. UserId must be a valid email address or GUID."
        }   

        It "Should fail when UserId is empty" {
            { Remove-EntraUserAppRoleAssignment -UserId -AppRoleAssignmentId "33dd33dd-ee44-ff55-aa66-77bb77bb77bb" } | Should -Throw "Missing an argument for parameter*"
        } 

        It "Should fail when AppRoleAssignmentId is invalid" {
            { Remove-EntraUserAppRoleAssignment -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" AppRoleAssignmentId "" } | Should -Throw "Cannot process argument transformation on parameter 'AppRoleAssignmentId'. Cannot convert value *"
        }   

        It "Should fail when AppRoleAssignmentId is empty" {
            { Remove-EntraUserAppRoleAssignment -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -AppRoleAssignmentId } | Should -Throw "Missing an argument for parameter*"
        } 

        It "Should contain UserId in parameters" {
            Mock -CommandName Remove-MgUserAppRoleAssignment -MockWith { $args } -ModuleName Microsoft.Entra.Users

            $result = Remove-EntraUserAppRoleAssignment -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -AppRoleAssignmentId "33dd33dd-ee44-ff55-aa66-77bb77bb77bb"
            $params = Get-Parameters -data $result
            $params.UserId | Should -Be "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraUserAppRoleAssignment"
            
            
            Remove-EntraUserAppRoleAssignment -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -AppRoleAssignmentId "33dd33dd-ee44-ff55-aa66-77bb77bb77bb"

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraUserAppRoleAssignment"

            Should -Invoke -CommandName Remove-MgUserAppRoleAssignment -ModuleName Microsoft.Entra.Users -Times 1 -ParameterFilter {
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
                { Remove-EntraUserAppRoleAssignment -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -AppRoleAssignmentId "33dd33dd-ee44-ff55-aa66-77bb77bb77bb" -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }   

    }
}

