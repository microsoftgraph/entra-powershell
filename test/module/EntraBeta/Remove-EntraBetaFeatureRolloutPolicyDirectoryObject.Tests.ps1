# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta    
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Remove-MgBetaPolicyFeatureRolloutPolicyApplyToByRef -MockWith {} -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Remove-EntraBetaFeatureRolloutPolicyDirectoryObject" {
    Context "Test for Remove-EntraBetaFeatureRolloutPolicyDirectoryObject" {
        It "Should removes a group from the cloud authentication roll-out policy from Azure AD" {
            $result = Remove-EntraBetaFeatureRolloutPolicyDirectoryObject -Id "bbbbcccc-1111-dddd-2222-eeee3333ffff" -ObjectId "aaaabbbb-0000-cccc-1111-dddd2222eeee"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgBetaPolicyFeatureRolloutPolicyApplyToByRef -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when Id is empty" {
            { Remove-EntraBetaFeatureRolloutPolicyDirectoryObject -Id  -ObjectId "aaaabbbb-0000-cccc-1111-dddd2222eeee" } | Should -Throw "Missing an argument for parameter 'Id'*"
        }   

        It "Should fail when Id is invalid" {
            { Remove-EntraBetaFeatureRolloutPolicyDirectoryObject -Id "" -ObjectId "aaaabbbb-0000-cccc-1111-dddd2222eeee" } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string."
        }   

        It "Should fail when ObjectId is empty" {
            { Remove-EntraBetaFeatureRolloutPolicyDirectoryObject -Id "bbbbcccc-1111-dddd-2222-eeee3333ffff" -ObjectId  } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
        }   

        It "Should fail when ObjectId is invalid" {
            { Remove-EntraBetaFeatureRolloutPolicyDirectoryObject -Id "bbbbcccc-1111-dddd-2222-eeee3333ffff" -ObjectId ""} | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }   

        It "Should contain DirectoryObjectId in parameters when passed ObjectId to it" {
            Mock -CommandName Remove-MgBetaPolicyFeatureRolloutPolicyApplyToByRef -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta

            $result = Remove-EntraBetaFeatureRolloutPolicyDirectoryObject -Id "bbbbcccc-1111-dddd-2222-eeee3333ffff" -ObjectId "aaaabbbb-0000-cccc-1111-dddd2222eeee"
            $params = Get-Parameters -data $result
            $params.DirectoryObjectId | Should -Be "aaaabbbb-0000-cccc-1111-dddd2222eeee"
        }

        It "Should contain FeatureRolloutPolicyId in parameters when passed Id to it" {
            Mock -CommandName Remove-MgBetaPolicyFeatureRolloutPolicyApplyToByRef -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta

            $result = Remove-EntraBetaFeatureRolloutPolicyDirectoryObject -Id "bbbbcccc-1111-dddd-2222-eeee3333ffff" -ObjectId "aaaabbbb-0000-cccc-1111-dddd2222eeee"
            $params = Get-Parameters -data $result
            $params.FeatureRolloutPolicyId | Should -Be "bbbbcccc-1111-dddd-2222-eeee3333ffff"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraBetaFeatureRolloutPolicyDirectoryObject"
            $result = Remove-EntraBetaFeatureRolloutPolicyDirectoryObject -Id "bbbbcccc-1111-dddd-2222-eeee3333ffff" -ObjectId "aaaabbbb-0000-cccc-1111-dddd2222eeee"
            $result | Should -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraBetaFeatureRolloutPolicyDirectoryObject"
            Should -Invoke -CommandName Remove-MgBetaPolicyFeatureRolloutPolicyApplyToByRef -ModuleName Microsoft.Graph.Entra.Beta -Times 1 -ParameterFilter {
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
                { Remove-EntraBetaFeatureRolloutPolicyDirectoryObject -Id "bbbbcccc-1111-dddd-2222-eeee3333ffff" -ObjectId "aaaabbbb-0000-cccc-1111-dddd2222eeee" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        } 
    }
}