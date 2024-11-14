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
                    '@odata.context'                = "https://graph.microsoft.com/beta/`$metadata#policies/featureRolloutPolicies/`$entity"
                }
                "Parameters"            = $args
                }
            )
        }
    Mock -CommandName  Get-MgBetaPolicyFeatureRolloutPolicy -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Get-EntraBetaFeatureRolloutPolicy" {
    Context "Test for Get-EntraBetaFeatureRolloutPolicy" {
        It "Should retrieves cloud authentication roll-out in Azure AD with given Id" {
            $result = Get-EntraBetaFeatureRolloutPolicy -Id "bbbbbbbb-1111-2222-3333-cccccccccc55"
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | should -Be "Feature-Rollout-Policytest"
            $result.Description | should -Be "Feature-Rollout-test"
            $result.IsEnabled | should -Be $true
            $result.Feature | should -Be "passwordHashSync"
            $result.IsAppliedToOrganization | should -Be $false
            $result.AppliesTo | should -BeNullOrEmpty
            $result.ObjectId | should -Be "bbbbbbbb-1111-2222-3333-cccccccccc55"

            Should -Invoke -CommandName Get-MgBetaPolicyFeatureRolloutPolicy -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when Id is empty" {
            { Get-EntraBetaFeatureRolloutPolicy -Id } | Should -Throw "Missing an argument for parameter 'Id'*"
        }

        It "Should fail when Id is invalid" {
            { Get-EntraBetaFeatureRolloutPolicy -Id "" } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string."
        }

        It "Should retrieves cloud authentication roll-out in Azure AD with given Filter." {
            $displayName = Get-EntraBetaFeatureRolloutPolicy -Filter "DisplayName eq 'Feature-Rollout-Policytest'"
            $displayName | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgBetaPolicyFeatureRolloutPolicy -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }  

        It "Should fail when Filter is empty" {
            { Get-EntraBetaFeatureRolloutPolicy -Filter } | Should -Throw "Missing an argument for parameter 'Filter'*"
        }  

        It "Should retrieves cloud authentication roll-out in Azure AD with given Search String." {
            $searchString = Get-EntraBetaFeatureRolloutPolicy -SearchString "Feature-Rollout-Policytest"
            $searchString | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgBetaPolicyFeatureRolloutPolicy -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }  

        It "Should fail when SearchString is empty" {
            { Get-EntraBetaFeatureRolloutPolicy -SearchString } | Should -Throw "Missing an argument for parameter 'SearchString'*"
        }  

        It "Result should Contain ObjectId" {
            $result = Get-EntraBetaFeatureRolloutPolicy -Id "bbbbbbbb-1111-2222-3333-cccccccccc55"
            $result.ObjectId | should -Be "bbbbbbbb-1111-2222-3333-cccccccccc55"
        } 

        It "Should contain Filter in parameters when SearchString passed to it" {
            $result = Get-EntraBetaFeatureRolloutPolicy -SearchString "Feature-Rollout-Policytest"
            $params = Get-Parameters -data $result.Parameters
            $expectedFilter = "displayName eq 'Feature-Rollout-Policytest' or startswith(displayName,'Feature-Rollout-Policytest')"
            $params.Filter | Should -Contain $expectedFilter
        }
        
        It "Should contain FeatureRolloutPolicyId in parameters when passed Id to it" {
            $result = Get-EntraBetaFeatureRolloutPolicy -Id "bbbbbbbb-1111-2222-3333-cccccccccc55"
            $params = Get-Parameters -data $result.Parameters
            $params.FeatureRolloutPolicyId | Should -Be "bbbbbbbb-1111-2222-3333-cccccccccc55"
        }
        
        It "Property parameter should work" {
            $result = Get-EntraBetaFeatureRolloutPolicy -Id "bbbbbbbb-1111-2222-3333-cccccccccc55" -Property DisplayName
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | Should -Be 'Feature-Rollout-Policytest'

            Should -Invoke -CommandName Get-MgBetaPolicyFeatureRolloutPolicy  -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should fail when Property is empty" {
            { Get-EntraBetaFeatureRolloutPolicy -Id "bbbbbbbb-1111-2222-3333-cccccccccc55" -Property } | Should -Throw "Missing an argument for parameter 'Property'*"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaFeatureRolloutPolicy"
            $result = Get-EntraBetaFeatureRolloutPolicy -Id "bbbbbbbb-1111-2222-3333-cccccccccc55"
            $result | Should -Not -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaFeatureRolloutPolicy"
            Should -Invoke -CommandName Get-MgBetaPolicyFeatureRolloutPolicy -ModuleName Microsoft.Graph.Entra.Beta -Times 1 -ParameterFilter {
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
                { Get-EntraBetaFeatureRolloutPolicy -Id "bbbbbbbb-1111-2222-3333-cccccccccc55" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
}