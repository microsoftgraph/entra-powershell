# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta    
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Invoke-GraphRequest -MockWith {} -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Remove-EntraBetaApplicationPolicy" {
    Context "Test for Remove-EntraBetaApplicationPolicy" {
        It "Should removes an application policy from Azure Active Directory (AD)" {
            $result = Remove-EntraBetaApplicationPolicy -Id "aaaabbbb-0000-cccc-1111-dddd2222eeee" -PolicyId "bbbbcccc-1111-dddd-2222-eeee3333ffff"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when Id is empty" {
            { Remove-EntraBetaApplicationPolicy -Id  -PolicyId "bbbbcccc-1111-dddd-2222-eeee3333ffff" } | Should -Throw "Missing an argument for parameter 'Id'*"
        }   

        It "Should fail when Id is invalid" {
            { Remove-EntraBetaApplicationPolicy -Id "" -PolicyId "bbbbcccc-1111-dddd-2222-eeee3333ffff" } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string."
        }   

        It "Should fail when PolicyId is empty" {
            { Remove-EntraBetaApplicationPolicy -Id "aaaabbbb-0000-cccc-1111-dddd2222eeee" -PolicyId  } | Should -Throw "Missing an argument for parameter 'PolicyId'*"
        }   

        It "Should fail when PolicyId is invalid" {
            { Remove-EntraBetaApplicationPolicy -Id "aaaabbbb-0000-cccc-1111-dddd2222eeee" -PolicyId "" } | Should -Throw "Cannot bind argument to parameter 'PolicyId' because it is an empty string."
        }   

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraBetaApplicationPolicy"

            $result = Remove-EntraBetaApplicationPolicy -Id "aaaabbbb-0000-cccc-1111-dddd2222eeee" -PolicyId "bbbbcccc-1111-dddd-2222-eeee3333ffff"
            $result | Should -BeNullOrEmpty

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraBetaApplicationPolicy"

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra.Beta -Times 1 -ParameterFilter {
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
                { Remove-EntraBetaApplicationPolicy -Id "aaaabbbb-0000-cccc-1111-dddd2222eeee" -PolicyId "bbbbcccc-1111-dddd-2222-eeee3333ffff" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        } 
    }
}