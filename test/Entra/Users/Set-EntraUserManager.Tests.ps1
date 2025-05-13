# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {
    if ((Get-Module -Name Microsoft.Entra.Users) -eq $null) {
        Import-Module Microsoft.Entra.Users
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    Mock -CommandName Set-MgUserManagerByRef -MockWith {} -ModuleName Microsoft.Entra.Users
    Mock -CommandName Get-EntraContext -MockWith { @{
            Environment = "Global"
        } } -ModuleName Microsoft.Entra.Users
    Mock -CommandName Get-EntraEnvironment -MockWith { return @{
            GraphEndpoint = "https://graph.microsoft.com"
        } } -ModuleName Microsoft.Entra.Users
}

Describe "Set-EntraUserManager" {
    Context "Test for Set-EntraUserManager" {
        It "Should return specific User" {
            $result = Set-EntraUserManager -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -ManagerId "00001111-aaaa-2222-bbbb-3333cccc4444"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Set-MgUserManagerByRef -ModuleName Microsoft.Entra.Users -Times 1
        }

        It "Should return specific User with alias" {
            $result = Set-EntraUserManager -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -ManagerId "00001111-aaaa-2222-bbbb-3333cccc4444"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Set-MgUserManagerByRef -ModuleName Microsoft.Entra.Users -Times 1
        }

        It "Should fail when UserId is empty string value" {
            { Set-EntraUserManager -UserId "" } | Should -Throw "Cannot validate argument on parameter 'UserId'. UserId must be a valid email address or GUID."
        }

        It "Should fail when UserId is empty" {
            { Set-EntraUserManager -UserId } | Should -Throw "Missing an argument for parameter 'UserId'. Specify a parameter of type 'System.String' and try again."
        }

        It "Should fail when ManagerId is invalid" {
            { Set-EntraUserManager -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" ManagerId "" } | Should -Throw "Cannot process argument transformation on parameter 'ManagerId'. Cannot convert value *"
        }

        It "Should contain UserId in parameters when passed UserId to it" {
            Mock -CommandName Set-MgUserManagerByRef -MockWith { $args } -ModuleName Microsoft.Entra.Users

            $result = Set-EntraUserManager -UserId "00001111-aaaa-2222-bbbb-3333cccc4444" -ManagerId "00001111-aaaa-2222-bbbb-3333cccc4444"
            $params = Get-Parameters -data $result
            $params.UserId | Should -Match "00001111-aaaa-2222-bbbb-3333cccc4444"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraUserManager"
             
            Set-EntraUserManager -UserId "00001111-aaaa-2222-bbbb-3333cccc4444" -ManagerId "00001111-aaaa-2222-bbbb-3333cccc4444"
    
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraUserManager"
    
            Should -Invoke -CommandName Set-MgUserManagerByRef -ModuleName Microsoft.Entra.Users -Times 1 -ParameterFilter {
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
                { Set-EntraUserManager -UserId "00001111-aaaa-2222-bbbb-3333cccc4444" -ManagerId "00001111-aaaa-2222-bbbb-3333cccc4444" -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }

    }
}

