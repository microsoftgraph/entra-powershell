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

Describe "Add-EntraBetaApplicationPolicy" {
Context "Test for Add-EntraBetaApplicationPolicy" {
        It "Should return empty object" {
            $result = Add-EntraBetaApplicationPolicy -Id "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -RefObjectId "eeeeeeee-4444-5555-6666-ffffffffffff"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should fail when Id is empty" {
            { Add-EntraBetaApplicationPolicy -Id  -RefObjectId "eeeeeeee-4444-5555-6666-ffffffffffff"   } | Should -Throw "Missing an argument for parameter 'Id'*"
        }
        It "Should fail when Id is invalid" {
            { Add-EntraBetaApplicationPolicy -Id "" -RefObjectId "eeeeeeee-4444-5555-6666-ffffffffffff"} | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string."
        }
        It "Should fail when RefObjectId is empty" {
            { Add-EntraBetaApplicationPolicy -Id "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -RefObjectId  } | Should -Throw "Missing an argument for parameter 'RefObjectId'*"
        }
        It "Should fail when RefObjectId is invalid" {
            { Add-EntraBetaApplicationPolicy -Id "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -RefObjectId "" } | Should -Throw "Cannot bind argument to parameter 'RefObjectId' because it is an empty string."
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Add-EntraBetaApplicationPolicy"

            Add-EntraBetaApplicationPolicy -Id "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -RefObjectId "eeeeeeee-4444-5555-6666-ffffffffffff"

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Add-EntraBetaApplicationPolicy"

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
                { Add-EntraBetaApplicationPolicy -Id "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -RefObjectId "eeeeeeee-4444-5555-6666-ffffffffffff" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        } 
    }
}