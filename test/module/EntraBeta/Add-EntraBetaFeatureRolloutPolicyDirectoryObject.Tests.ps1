# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta    
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName New-MgBetaDirectoryFeatureRolloutPolicyApplyToByRef -MockWith {} -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Add-EntraBetaFeatureRolloutPolicyDirectoryObject" {
    Context "Test for Add-EntraBetaFeatureRolloutPolicyDirectoryObject" {
        It "Should adds a group to the cloud authentication roll-out policy in Azure AD." {
            $result = Add-EntraBetaFeatureRolloutPolicyDirectoryObject -Id "a03b6d9e-6654-46e6-8d0a-8ed83c675ca9" -RefObjectId "0a1068c0-dbb6-4537-9db3-b48f3e31dd76"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName New-MgBetaDirectoryFeatureRolloutPolicyApplyToByRef -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when Id is empty" {
            { Add-EntraBetaFeatureRolloutPolicyDirectoryObject -Id  -RefObjectId "0a1068c0-dbb6-4537-9db3-b48f3e31dd76"  } | Should -Throw "Missing an argument for parameter 'Id'.*"
        }

        It "Should fail when Id is invalid" {
            { Add-EntraBetaFeatureRolloutPolicyDirectoryObject -Id "" -RefObjectId "0a1068c0-dbb6-4537-9db3-b48f3e31dd76"  } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string."
        }

        It "Should fail when RefObjectId is empty" {
            { Add-EntraBetaFeatureRolloutPolicyDirectoryObject -Id "a03b6d9e-6654-46e6-8d0a-8ed83c675ca9" -RefObjectId   } | Should -Throw "Missing an argument for parameter 'RefObjectId'.*"
        }

        It "Should fail when RefObjectId is invalid" {
            { Add-EntraBetaFeatureRolloutPolicyDirectoryObject -Id "a03b6d9e-6654-46e6-8d0a-8ed83c675ca9" -RefObjectId ""  } | Should -Throw "Cannot bind argument to parameter 'RefObjectId' because it is an empty string."
        }

        It "Should contain FeatureRolloutPolicyId in parameters when passed Id to it" {
            Mock -CommandName New-MgBetaDirectoryFeatureRolloutPolicyApplyToByRef -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta

            $result = Add-EntraBetaFeatureRolloutPolicyDirectoryObject -Id "a03b6d9e-6654-46e6-8d0a-8ed83c675ca9" -RefObjectId "0a1068c0-dbb6-4537-9db3-b48f3e31dd76"
            $params = Get-Parameters -data $result
            $params.FeatureRolloutPolicyId | Should -Be "a03b6d9e-6654-46e6-8d0a-8ed83c675ca9"
        }

        It "Should contain OdataId in parameters when passed RefObjectId to it" {
            Mock -CommandName New-MgBetaDirectoryFeatureRolloutPolicyApplyToByRef -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta

            $result = Add-EntraBetaFeatureRolloutPolicyDirectoryObject -Id "a03b6d9e-6654-46e6-8d0a-8ed83c675ca9" -RefObjectId "0a1068c0-dbb6-4537-9db3-b48f3e31dd76"
            $value = "https://graph.microsoft.com/v1.0/directoryObjects/0a1068c0-dbb6-4537-9db3-b48f3e31dd76" 
            $params= Get-Parameters -data $result
            $params.OdataId | Should -Be $value
        }

        It "Should contain 'User-Agent' header" {
            Mock -CommandName New-MgBetaDirectoryFeatureRolloutPolicyApplyToByRef -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Add-EntraBetaFeatureRolloutPolicyDirectoryObject"
            $result = Add-EntraBetaFeatureRolloutPolicyDirectoryObject -Id "a03b6d9e-6654-46e6-8d0a-8ed83c675ca9" -RefObjectId "0a1068c0-dbb6-4537-9db3-b48f3e31dd76"
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }

        It "Should execute successfully without throwing an error " {
            # Disable confirmation prompts       
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'
    
            try {
                # Act & Assert: Ensure the function doesn't throw an exception
                { Add-EntraBetaFeatureRolloutPolicyDirectoryObject -Id "a03b6d9e-6654-46e6-8d0a-8ed83c675ca9" -RefObjectId "0a1068c0-dbb6-4537-9db3-b48f3e31dd76" } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
}        
