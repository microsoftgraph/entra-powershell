# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if ((Get-Module -Name Microsoft.Graph.Entra) -eq $null) {
        Import-Module Microsoft.Graph.Entra       
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force


    Mock -CommandName Remove-MgUserManagerByRef -MockWith {} -ModuleName Microsoft.Graph.Entra
}

Describe "Remove-EntraUserManager" {
    Context "Test for Remove-EntraUserManager" {
        It "Should return empty object" {
            $result = Remove-EntraUserManager -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result | Should -BeNullOrEmpty
            Should -Invoke -CommandName Remove-MgUserManagerByRef -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when ObjectId is empty string" {
            { Remove-EntraUserManager -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }   
        It "Should fail when ObjectId is empty" {
            { Remove-EntraUserManager -ObjectId } | Should -Throw "Missing an argument for parameter*"
        }  
        It "Should contain Id in parameters when passed ObjectId to it" {
            Mock -CommandName Remove-MgUserManagerByRef -MockWith { $args } -ModuleName Microsoft.Graph.Entra

            $result = Remove-EntraUserManager -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $params = Get-Parameters -data $result
            $params.userId | Should -Be "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
        }
        
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraUserManager"
            
            
            Remove-EntraUserManager -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraUserManager"

            Should -Invoke -CommandName  Remove-MgUserManagerByRef -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
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
                { Remove-EntraUserManager -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }   
    }
}