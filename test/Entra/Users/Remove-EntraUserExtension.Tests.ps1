# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.Users) -eq $null) {
        Import-Module Microsoft.Entra.Users       
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force


    Mock -CommandName Invoke-GraphRequest -MockWith {} -ModuleName Microsoft.Entra.Users
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("User.ReadWrite.All") } } -ModuleName Microsoft.Entra.Users
}

Describe "Remove-EntraUserExtension" {
    Context "Test for Remove-EntraUserExtension" {
        It "should throw when not connected and not invoke graph call" {
            Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.Users
            { Remove-EntraUserExtension -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -ExtensionName 'extension_bbbbbbbb111122223333cccccccccccc_TestExtension' } | Should -Throw "Not connected to Microsoft Graph*"
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Users -Times 0
        }

        It "Should return empty object for single extension" {
            $result = Remove-EntraUserExtension -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -ExtensionName 'extension_bbbbbbbb111122223333cccccccccccc_TestExtension'
            $result | Should -BeNullOrEmpty
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Users -Times 1
        }
        It "Should return empty object for multiple extension" {
            $result = Remove-EntraUserExtension -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -ExtensionNames 'extension_bbbbbbbb111122223333cccccccccccc_TestExtension','extension_bbbbbbbb111122223333cccccccccccc_DummyExtension'
            $result | Should -BeNullOrEmpty
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Users -Times 1
        }
        It "Should return empty object with alias" {
            $result = Remove-EntraUserExtension -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -ExtensionName 'extension_bbbbbbbb111122223333cccccccccccc_TestExtension'
            $result | Should -BeNullOrEmpty
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Users -Times 1
        }
        It "Should fail when UserId is empty string" {
            { Remove-EntraUserExtension -UserId "" -ExtensionName 'extension_bbbbbbbb111122223333cccccccccccc_TestExtension'} | Should -Throw "Cannot validate argument on parameter 'UserId'. UserId must be a valid email address or GUID."
        }   
        It "Should fail when UserId is empty" {
            { Remove-EntraUserExtension -UserId -ExtensionName 'extension_bbbbbbbb111122223333cccccccccccc_TestExtension'} | Should -Throw "Missing an argument for parameter*"
        }
        It "Should fail when ExtensionName is empty string" {
            { Remove-EntraUserExtension -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -ExtensionName ''} | Should -Throw "Cannot bind argument to parameter 'ExtensionName' because it is an empty string."
        }   
        It "Should fail when ExtensionName is empty" {
            { Remove-EntraUserExtension -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -ExtensionName } | Should -Throw "Missing an argument for parameter 'ExtensionName'. Specify a parameter of type 'System.String' and try again."
        }
        It "Should fail when ExtensionName is empty string" {
            { Remove-EntraUserExtension -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -ExtensionNames ''} | Should -Throw "Cannot bind argument to parameter 'ExtensionNames' because it is an empty string."
        }
        
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraUserExtension"
            
            
            Remove-EntraUserExtension -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -ExtensionName 'extension_bbbbbbbb111122223333cccccccccccc_TestExtension'

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraUserExtension"

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Users -Times 1 -ParameterFilter {
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
                { Remove-EntraUserExtension -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -ExtensionName 'extension_bbbbbbbb111122223333cccccccccccc_TestExtension' -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }   
    }
}

