# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if ((Get-Module -Name Microsoft.Graph.Entra) -eq $null) {
        Import-Module Microsoft.Graph.Entra       
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force


    Mock -CommandName Revoke-MgUserSignInSession -MockWith {} -ModuleName Microsoft.Graph.Entra
}

Describe "Revoke-EntraUserAllRefreshToken" {
    Context "Test for Revoke-EntraUserAllRefreshToken" {
        It "Should return empty object" {
            $result = Revoke-EntraUserAllRefreshToken -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result | Should -BeNullOrEmpty
            Should -Invoke -CommandName Revoke-MgUserSignInSession -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should return empty object with alias" {
            $result = Revoke-EntraUserAllRefreshToken -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result | Should -BeNullOrEmpty
            Should -Invoke -CommandName Revoke-MgUserSignInSession -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when UserId is empty string" {
            { Revoke-EntraUserAllRefreshToken -UserId "" } | Should -Throw "Cannot bind argument to parameter 'UserId' because it is an empty string."
        }   
        It "Should fail when UserId is empty" {
            { Revoke-EntraUserAllRefreshToken -UserId } | Should -Throw "Missing an argument for parameter*"
        }  
        It "Should contain Id in parameters when passed UserId to it" {
            Mock -CommandName Revoke-MgUserSignInSession -MockWith { $args } -ModuleName Microsoft.Graph.Entra

            $result = Revoke-EntraUserAllRefreshToken -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $params = Get-Parameters -data $result
            $params.userId | Should -Be "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Revoke-EntraUserAllRefreshToken"
            
            
            Revoke-EntraUserAllRefreshToken -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Revoke-EntraUserAllRefreshToken"

            Should -Invoke -CommandName Revoke-MgUserSignInSession -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
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
                { Revoke-EntraUserAllRefreshToken -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }   
    }
}
