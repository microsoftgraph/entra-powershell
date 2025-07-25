# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.Beta.Users) -eq $null) {
        Import-Module Microsoft.Entra.Beta.Users       
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force


    Mock -CommandName Invoke-GraphRequest -MockWith {} -ModuleName Microsoft.Entra.Beta.Users
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("User.ReadWrite.All") } } -ModuleName Microsoft.Entra.Beta.Users
}

Describe "Remove-EntraBetaUserExtension" {
    Context "Test for Remove-EntraBetaUserExtension" {
        It "Should return empty object for single extension" {
            $result = Remove-EntraBetaUserExtension -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -ExtensionName 'extension_bbbbbbbb111122223333cccccccccccc_TestExtension'
            $result | Should -BeNullOrEmpty
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.Users -Times 1
        }
        It "Should return empty object for multiple extension" {
            $result = Remove-EntraBetaUserExtension -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -ExtensionNames 'extension_bbbbbbbb111122223333cccccccccccc_TestExtension','extension_bbbbbbbb111122223333cccccccccccc_DummyExtension'
            $result | Should -BeNullOrEmpty
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.Users -Times 1
        }
        It "Should return empty object with alias" {
            $result = Remove-EntraBetaUserExtension -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -ExtensionName 'extension_bbbbbbbb111122223333cccccccccccc_TestExtension'
            $result | Should -BeNullOrEmpty
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.Users -Times 1
        }
        It "Should fail when UserId is empty string" {
            { Remove-EntraBetaUserExtension -UserId "" -ExtensionName 'extension_bbbbbbbb111122223333cccccccccccc_TestExtension'} | Should -Throw "Cannot validate argument on parameter 'UserId'. UserId must be a valid email address or GUID."
        }   
        It "Should fail when UserId is empty" {
            { Remove-EntraBetaUserExtension -UserId -ExtensionName 'extension_bbbbbbbb111122223333cccccccccccc_TestExtension'} | Should -Throw "Missing an argument for parameter*"
        }
        It "Should fail when ExtensionName is empty string" {
            { Remove-EntraBetaUserExtension -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -ExtensionName ''} | Should -Throw "Cannot bind argument to parameter 'ExtensionName' because it is an empty string."
        }   
        It "Should fail when ExtensionName is empty" {
            { Remove-EntraBetaUserExtension -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -ExtensionName } | Should -Throw "Missing an argument for parameter 'ExtensionName'. Specify a parameter of type 'System.String' and try again."
        }
        It "Should fail when ExtensionName is empty string" {
            { Remove-EntraBetaUserExtension -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -ExtensionNames ''} | Should -Throw "Cannot bind argument to parameter 'ExtensionNames' because it is an empty string."
        }
        
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraBetaUserExtension"
            
            
            Remove-EntraBetaUserExtension -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -ExtensionName 'extension_bbbbbbbb111122223333cccccccccccc_TestExtension'

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraBetaUserExtension"

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.Users -Times 1 -ParameterFilter {
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
                { Remove-EntraBetaUserExtension -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -ExtensionName 'extension_bbbbbbbb111122223333cccccccccccc_TestExtension' -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }   
    }
}

