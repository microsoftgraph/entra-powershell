# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.Users) -eq $null) {
        Import-Module Microsoft.Entra.Users       
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force


    Mock -CommandName Remove-MgUserManagerByRef -MockWith {} -ModuleName Microsoft.Entra.Users
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("User.ReadWrite.All") } } -ModuleName Microsoft.Entra.Users
}

Describe "Remove-EntraUserManager" {
    Context "Test for Remove-EntraUserManager" {
        It "should throw when not connected and not invoke SDK" {
            Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.Users
            { Remove-EntraUserManager -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" } | Should -Throw "Not connected to Microsoft Graph*"
            Should -Invoke -CommandName Remove-MgUserManagerByRef -ModuleName Microsoft.Entra.Users -Times 0
        }
        It "Should return empty object" {
            $result = Remove-EntraUserManager -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result | Should -BeNullOrEmpty
            Should -Invoke -CommandName Remove-MgUserManagerByRef -ModuleName Microsoft.Entra.Users -Times 1
        }
        It "Should return empty object with alias" {
            $result = Remove-EntraUserManager -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result | Should -BeNullOrEmpty
            Should -Invoke -CommandName Remove-MgUserManagerByRef -ModuleName Microsoft.Entra.Users -Times 1
        }
        It "Should fail when UserId is empty string" {
            { Remove-EntraUserManager -UserId "" } | Should -Throw "Cannot validate argument on parameter 'UserId'. UserId must be a valid email address or GUID."
        }   
        It "Should fail when UserId is empty" {
            { Remove-EntraUserManager -UserId } | Should -Throw "Missing an argument for parameter*"
        }  
        It "Should contain UserId in parameters when passed UserId to it" {
            Mock -CommandName Remove-MgUserManagerByRef -MockWith { $args } -ModuleName Microsoft.Entra.Users

            $result = Remove-EntraUserManager -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $params = Get-Parameters -data $result
            $params.userId | Should -Be "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
        }
        
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraUserManager"
            
            
            Remove-EntraUserManager -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraUserManager"

            Should -Invoke -CommandName Remove-MgUserManagerByRef -ModuleName Microsoft.Entra.Users -Times 1 -ParameterFilter {
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
                { Remove-EntraUserManager -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }   
    }
}

