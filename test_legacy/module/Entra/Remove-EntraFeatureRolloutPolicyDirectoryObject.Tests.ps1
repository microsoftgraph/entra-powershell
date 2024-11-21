# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra       
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Invoke-GraphRequest -MockWith {} -ModuleName Microsoft.Graph.Entra
}

Describe "Remove-EntraFeatureRolloutPolicyDirectoryObject" {
    Context "Test for Remove-EntraFeatureRolloutPolicyDirectoryObject" {
        It "Should return empty object" {
            $result = Remove-EntraFeatureRolloutPolicyDirectoryObject -Id bbbbbbbb-1111-2222-3333-cccccccccccc -ObjectId bbbbbbbb-1111-2222-3333-aaaaaaaaaaaa
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when Id is invalid" {
            { Remove-EntraFeatureRolloutPolicyDirectoryObject -Id "" } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string."
        }
        It "Should fail when Id is empty" {
            { Remove-EntraFeatureRolloutPolicyDirectoryObject -Id } | Should -Throw "Missing an argument for parameter 'Id'*"
        }
        It "Should fail when ObjectId is invalid" {
            { Remove-EntraFeatureRolloutPolicyDirectoryObject -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }
        It "Should fail when ObjectId is empty" {
            { Remove-EntraFeatureRolloutPolicyDirectoryObject -ObjectId } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
        }    
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraFeatureRolloutPolicyDirectoryObject"
            $result = Remove-EntraFeatureRolloutPolicyDirectoryObject -Id bbbbbbbb-1111-2222-3333-cccccccccccc -ObjectId bbbbbbbb-1111-2222-3333-aaaaaaaaaaaa
            $result | Should -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraFeatureRolloutPolicyDirectoryObject"
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
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
                { Remove-EntraFeatureRolloutPolicyDirectoryObject -Id bbbbbbbb-1111-2222-3333-cccccccccccc -ObjectId bbbbbbbb-1111-2222-3333-aaaaaaaaaaaa -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }   
    }
}
