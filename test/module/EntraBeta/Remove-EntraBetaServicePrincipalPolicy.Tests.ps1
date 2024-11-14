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

Describe "Remove-EntraBetaServicePrincipalPolicy" {
    Context "Test for Remove-EntraBetaServicePrincipalPolicy" {
        It "Should return empty object" {
            $result = Remove-EntraBetaServicePrincipalPolicy -Id "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -PolicyId "1aaaaaa1-2bb2-3cc3-4dd4-5eeeeeeeeee5"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should fail when Id is empty" {
            { Remove-EntraBetaServicePrincipalPolicy -Id  -PolicyId "1aaaaaa1-2bb2-3cc3-4dd4-5eeeeeeeeee5"   } | Should -Throw "Missing an argument for parameter 'Id'*"
        }
        It "Should fail when Id is invalid" {
            { Remove-EntraBetaServicePrincipalPolicy -Id "" -PolicyId "1aaaaaa1-2bb2-3cc3-4dd4-5eeeeeeeeee5"} | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string."
        }
        It "Should fail when PolicyId is empty" {
            { Remove-EntraBetaServicePrincipalPolicy -Id "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -PolicyId  } | Should -Throw "Missing an argument for parameter 'PolicyId'*"
        }
        It "Should fail when PolicyId is invalid" {
            { Remove-EntraBetaServicePrincipalPolicy -Id "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -PolicyId ""} | Should -Throw "Cannot bind argument to parameter 'PolicyId' because it is an empty string."
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraBetaServicePrincipalPolicy"
            
            Remove-EntraBetaServicePrincipalPolicy -Id "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -PolicyId "1aaaaaa1-2bb2-3cc3-4dd4-5eeeeeeeeee5"
           

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraBetaServicePrincipalPolicy"
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra.Beta -Times 1 -ParameterFilter {
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
                {  Remove-EntraBetaServicePrincipalPolicy -Id "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -PolicyId "1aaaaaa1-2bb2-3cc3-4dd4-5eeeeeeeeee5" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
}