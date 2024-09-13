# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {
    if ((Get-Module -Name Microsoft.Graph.Entra) -eq $null) {
        Import-Module Microsoft.Graph.Entra
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Set-MgUserManagerByRef -MockWith {} -ModuleName Microsoft.Graph.Entra
}

Describe "Set-EntraUserManager" {
    Context "Test for Set-EntraUserManager" {
        It "Should return specific User" {
            $result = Set-EntraUserManager -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -RefObjectId "00001111-aaaa-2222-bbbb-3333cccc4444"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Set-MgUserManagerByRef -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should fail when ObjectId is empty string value" {
            { Set-EntraUserManager -ObjectId ""} | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }

        It "Should fail when ObjectId is empty" {
            { Set-EntraUserManager -ObjectId } | Should -Throw "Missing an argument for parameter 'ObjectId'. Specify a parameter of type 'System.String' and try again."
        }

        It "Should fail when RefObjectId is invalid" {
            { Set-EntraUserManager -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"  RefObjectId ""} | Should -Throw "A positional parameter cannot be found that accepts argument*"
        }

        It "Should contain UserId in parameters when passed ObjectId to it" {
            Mock -CommandName Set-MgUserManagerByRef -MockWith { $args } -ModuleName Microsoft.Graph.Entra

            $result = Set-EntraUserManager -ObjectId "00001111-aaaa-2222-bbbb-3333cccc4444" -RefObjectId "00001111-aaaa-2222-bbbb-3333cccc4444"
            $params = Get-Parameters -data $result
            $params.UserId | Should -Match "00001111-aaaa-2222-bbbb-3333cccc4444"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraUserManager"
             
            Set-EntraUserManager -ObjectId "00001111-aaaa-2222-bbbb-3333cccc4444" -RefObjectId "00001111-aaaa-2222-bbbb-3333cccc4444"
    
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraUserManager"
    
            Should -Invoke -CommandName Set-MgUserManagerByRef -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
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
                { Set-EntraUserManager -ObjectId "00001111-aaaa-2222-bbbb-3333cccc4444" -RefObjectId "00001111-aaaa-2222-bbbb-3333cccc4444" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }

    }
}