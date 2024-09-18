# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta    
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    $scriptblock = {
        return @(
            [PSCustomObject]@{
                "AppliesTo"                         = $null
                "Description"                       = "Feature-Rollout-test"
                "DisplayName"                       = "Feature-Rollout-Policytest"
                "Feature"                           = "passwordHashSync"
                "Id"                                = "bbbbbbbb-1111-2222-3333-cccccccccc55"
                "IsAppliedToOrganization"           = $false
                "IsEnabled"                         = $true
                "AdditionalProperties"              = @{
                    '@odata.context'                = 'https://graph.microsoft.com/beta/$metadata#policies/featureRolloutPolicies/$entity'
                }
                "Parameters"            = $args
                }
            )
        }
    Mock -CommandName  New-MgBetaPolicyFeatureRolloutPolicy -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "New-EntraBetaFeatureRolloutPolicy" {
    Context "Test for New-EntraBetaFeatureRolloutPolicy" {
        It "Should creates the policy for cloud authentication roll-out in Azure AD." {
            $result = New-EntraBetaFeatureRolloutPolicy -Feature "passwordHashSync" -DisplayName "Feature-Rollout-Policytest" -IsEnabled $true -IsAppliedToOrganization $false -Description "Feature-Rollout-test"
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | should -Be "Feature-Rollout-Policytest"
            $result.Description | should -Be "Feature-Rollout-test"
            $result.IsEnabled | should -Be $true
            $result.Feature | should -Be "passwordHashSync"
            $result.IsAppliedToOrganization | should -Be $false
            $result.AppliesTo | should -BeNullOrEmpty
            $result.ObjectId | should -Be "bbbbbbbb-1111-2222-3333-cccccccccc55"

            Should -Invoke -CommandName New-MgBetaPolicyFeatureRolloutPolicy -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when Feature is empty" {
            { New-EntraBetaFeatureRolloutPolicy -Feature  -DisplayName "Feature-Rollout-Policytest" -IsEnabled $true -IsAppliedToOrganization $false -Description "Feature-Rollout-test" } | Should -Throw "Missing an argument for parameter 'Feature'*"
        }

        It "Should fail when Feature is invalid" {
            { New-EntraBetaFeatureRolloutPolicy -Feature "" -DisplayName "Feature-Rollout-Policytest" -IsEnabled $true -IsAppliedToOrganization $false -Description "Feature-Rollout-test" } | Should -Throw "Cannot process argument transformation on parameter 'Feature'*"
        }

        It "Should fail when DisplayName is empty" {
            { New-EntraBetaFeatureRolloutPolicy -Feature "passwordHashSync" -DisplayName -IsEnabled $true -IsAppliedToOrganization $false -Description "Feature-Rollout-test" } | Should -Throw "Missing an argument for parameter 'DisplayName'*"
        }

        It "Should fail when DisplayName is invalid" {
            { New-EntraBetaFeatureRolloutPolicy -Feature "passwordHashSync" -DisplayName "" -IsEnabled $true -IsAppliedToOrganization $false -Description "Feature-Rollout-test" } | Should -Throw "Cannot bind argument to parameter 'DisplayName' because it is an empty string."
        }

        It "Should fail when IsEnabled is empty" {
            { New-EntraBetaFeatureRolloutPolicy -Feature "passwordHashSync" -DisplayName "Feature-Rollout-Policytest" -IsEnabled -IsAppliedToOrganization $false -Description "Feature-Rollout-test" } | Should -Throw "Missing an argument for parameter 'IsEnabled'*"
        }

        It "Should fail when IsEnabled is invalid" {
            { New-EntraBetaFeatureRolloutPolicy -Feature "passwordHashSync" -DisplayName "Feature-Rollout-Policytest" -IsEnabled "" -IsAppliedToOrganization $false -Description "Feature-Rollout-test" } | Should -Throw "Cannot process argument transformation on parameter 'IsEnabled'*"
        }

        It "Should fail when IsAppliedToOrganization is empty" {
            { New-EntraBetaFeatureRolloutPolicy -Feature "passwordHashSync" -DisplayName "Feature-Rollout-Policytest" -IsEnabled $true -IsAppliedToOrganization -Description "Feature-Rollout-test" } | Should -Throw "Missing an argument for parameter 'IsAppliedToOrganization'*"
        }

        It "Should fail when IsAppliedToOrganization is invalid" {
            { New-EntraBetaFeatureRolloutPolicy -Feature "passwordHashSync" -DisplayName "Feature-Rollout-Policytest" -IsEnabled $true -IsAppliedToOrganization "" -Description "Feature-Rollout-test" } | Should -Throw "Cannot process argument transformation on parameter 'IsAppliedToOrganization'*"
        }

        It "Should fail when Description is empty" {
            { New-EntraBetaFeatureRolloutPolicy -Feature "passwordHashSync" -DisplayName "Feature-Rollout-Policytest" -IsEnabled $true -IsAppliedToOrganization $false -Description } | Should -Throw "Missing an argument for parameter 'Description'*"
        }

        It "Should fail when AppliesTo is empty" {
            { New-EntraBetaFeatureRolloutPolicy -Feature "passwordHashSync" -DisplayName "Feature-Rollout-Policytest" -IsEnabled $true -IsAppliedToOrganization $false -Description "Feature-Rollout-test" -AppliesTo  } | Should -Throw "Missing an argument for parameter 'AppliesTo'*"
        }

        It "Should fail when AppliesTo is invalid" {
            { New-EntraBetaFeatureRolloutPolicy -Feature "passwordHashSync" -DisplayName "Feature-Rollout-Policytest" -IsEnabled $true -IsAppliedToOrganization $false -Description "Feature-Rollout-test" -AppliesTo ""} | Should -Throw "Cannot process argument transformation on parameter 'AppliesTo'*"
        }

        It "Result should Contain ObjectId" {
            $result = New-EntraBetaFeatureRolloutPolicy -Feature "passwordHashSync" -DisplayName "Feature-Rollout-Policytest" -IsEnabled $true -IsAppliedToOrganization $false -Description "Feature-Rollout-test"
            $result.ObjectId | should -Be "bbbbbbbb-1111-2222-3333-cccccccccc55"
        } 

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraBetaFeatureRolloutPolicy"

            $result =  New-EntraBetaFeatureRolloutPolicy -Feature "passwordHashSync" -DisplayName "Feature-Rollout-Policytest" -IsEnabled $true -IsAppliedToOrganization $false -Description "Feature-Rollout-test"
            $result | Should -Not -BeNullOrEmpty

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraBetaFeatureRolloutPolicy"

            Should -Invoke -CommandName New-MgBetaPolicyFeatureRolloutPolicy -ModuleName Microsoft.Graph.Entra.Beta -Times 1 -ParameterFilter {
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
                { New-EntraBetaFeatureRolloutPolicy -Feature "passwordHashSync" -DisplayName "Feature-Rollout-Policytest" -IsEnabled $true -IsAppliedToOrganization $false -Description "Feature-Rollout-test" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
}