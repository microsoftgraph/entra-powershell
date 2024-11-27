# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta    
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName  Update-MgBetaPolicyFeatureRolloutPolicy -MockWith {} -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Set-EntraBetaFeatureRolloutPolicy" {
    Context "Test for Set-EntraBetaFeatureRolloutPolicy" {
        It "Should creates the policy for cloud authentication roll-out in Azure AD." {
            $result = Set-EntraBetaFeatureRolloutPolicy -Id "bbbbcccc-1111-dddd-2222-eeee3333ffff" -Feature "passwordHashSync" -DisplayName "Feature-Rollout-Policytest" -IsEnabled $true -IsAppliedToOrganization $false -Description "Feature-Rollout-test"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Update-MgBetaPolicyFeatureRolloutPolicy -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when Feature is empty" {
            { Set-EntraBetaFeatureRolloutPolicy -Id "bbbbcccc-1111-dddd-2222-eeee3333ffff" -Feature  -DisplayName "Feature-Rollout-Policytest" -IsEnabled $true -IsAppliedToOrganization $false -Description "Feature-Rollout-test" } | Should -Throw "Missing an argument for parameter 'Feature'*"
        }

        It "Should fail when Feature is invalid" {
            { Set-EntraBetaFeatureRolloutPolicy -Id "bbbbcccc-1111-dddd-2222-eeee3333ffff" -Feature "" -DisplayName "Feature-Rollout-Policytest" -IsEnabled $true -IsAppliedToOrganization $false -Description "Feature-Rollout-test" } | Should -Throw "Cannot process argument transformation on parameter 'Feature'*"
        }

        It "Should fail when DisplayName is empty" {
            { Set-EntraBetaFeatureRolloutPolicy -Id "bbbbcccc-1111-dddd-2222-eeee3333ffff" -Feature "passwordHashSync" -DisplayName -IsEnabled $true -IsAppliedToOrganization $false -Description "Feature-Rollout-test" } | Should -Throw "Missing an argument for parameter 'DisplayName'*"
        }

        It "Should fail when IsEnabled is empty" {
            { Set-EntraBetaFeatureRolloutPolicy -Id "bbbbcccc-1111-dddd-2222-eeee3333ffff" -Feature "passwordHashSync" -DisplayName "Feature-Rollout-Policytest" -IsEnabled -IsAppliedToOrganization $false -Description "Feature-Rollout-test" } | Should -Throw "Missing an argument for parameter 'IsEnabled'*"
        }

        It "Should fail when IsEnabled is invalid" {
            { Set-EntraBetaFeatureRolloutPolicy -Id "bbbbcccc-1111-dddd-2222-eeee3333ffff" -Feature "passwordHashSync" -DisplayName "Feature-Rollout-Policytest" -IsEnabled "" -IsAppliedToOrganization $false -Description "Feature-Rollout-test" } | Should -Throw "Cannot process argument transformation on parameter 'IsEnabled'*"
        }

        It "Should fail when IsAppliedToOrganization is empty" {
            { Set-EntraBetaFeatureRolloutPolicy -Id "bbbbcccc-1111-dddd-2222-eeee3333ffff" -Feature "passwordHashSync" -DisplayName "Feature-Rollout-Policytest" -IsEnabled $true -IsAppliedToOrganization -Description "Feature-Rollout-test" } | Should -Throw "Missing an argument for parameter 'IsAppliedToOrganization'*"
        }

        It "Should fail when IsAppliedToOrganization is invalid" {
            { Set-EntraBetaFeatureRolloutPolicy -Id "bbbbcccc-1111-dddd-2222-eeee3333ffff" -Feature "passwordHashSync" -DisplayName "Feature-Rollout-Policytest" -IsEnabled $true -IsAppliedToOrganization "" -Description "Feature-Rollout-test" } | Should -Throw "Cannot process argument transformation on parameter 'IsAppliedToOrganization'*"
        }

        It "Should fail when Description is empty" {
            { Set-EntraBetaFeatureRolloutPolicy -Id "bbbbcccc-1111-dddd-2222-eeee3333ffff" -Feature "passwordHashSync" -DisplayName "Feature-Rollout-Policytest" -IsEnabled $true -IsAppliedToOrganization $false -Description } | Should -Throw "Missing an argument for parameter 'Description'*"
        }

        It "Should fail when AppliesTo is empty" {
            { Set-EntraBetaFeatureRolloutPolicy -Id "bbbbcccc-1111-dddd-2222-eeee3333ffff" -Feature "passwordHashSync" -DisplayName "Feature-Rollout-Policytest" -IsEnabled $true -IsAppliedToOrganization $false -Description "Feature-Rollout-test" -AppliesTo  } | Should -Throw "Missing an argument for parameter 'AppliesTo'*"
        }

        It "Should fail when AppliesTo is invalid" {
            { Set-EntraBetaFeatureRolloutPolicy -Id "bbbbcccc-1111-dddd-2222-eeee3333ffff" -Feature "passwordHashSync" -DisplayName "Feature-Rollout-Policytest" -IsEnabled $true -IsAppliedToOrganization $false -Description "Feature-Rollout-test" -AppliesTo ""} | Should -Throw "Cannot process argument transformation on parameter 'AppliesTo'*"
        }

        It "Should contain FeatureRolloutPolicyId in parameters when passed Id to it" {
            Mock -CommandName  Update-MgBetaPolicyFeatureRolloutPolicy -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta

            $result = Set-EntraBetaFeatureRolloutPolicy -Id "bbbbcccc-1111-dddd-2222-eeee3333ffff" -Feature "passwordHashSync" -DisplayName "Feature-Rollout-Policytest" -IsEnabled $true -IsAppliedToOrganization $false -Description "Feature-Rollout-test"
            $params = Get-Parameters -data $result
            $params.FeatureRolloutPolicyId | Should -Be "bbbbcccc-1111-dddd-2222-eeee3333ffff"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraBetaFeatureRolloutPolicy"
            Set-EntraBetaFeatureRolloutPolicy -Id "bbbbcccc-1111-dddd-2222-eeee3333ffff" -Feature "passwordHashSync" -DisplayName "Feature-Rollout-Policytest" -IsEnabled $true -IsAppliedToOrganization $false -Description "Feature-Rollout-test"
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraBetaFeatureRolloutPolicy"
            Should -Invoke -CommandName Update-MgBetaPolicyFeatureRolloutPolicy -ModuleName Microsoft.Graph.Entra.Beta -Times 1 -ParameterFilter {
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
                { Set-EntraBetaFeatureRolloutPolicy -Id "bbbbcccc-1111-dddd-2222-eeee3333ffff" -Feature "passwordHashSync" -DisplayName "Feature-Rollout-Policytest" -IsEnabled $true -IsAppliedToOrganization $false -Description "Feature-Rollout-test" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }   
    }
}