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
                "Id"                                = "60184e48-569b-4ba5-a3bb-1d74cb9c2e5e"
                "IsAppliedToOrganization"           = $false
                "IsEnabled"                         = $true
                "AdditionalProperties"              = @{
                    '@odata.context'                = "https://graph.microsoft.com/beta/$metadata#policies/featureRolloutPolicies/$entity"
                }
                "Parameters"            = $args
                }
            )
        }
    Mock -CommandName  Get-MgBetaPolicyFeatureRolloutPolicy -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Get-EntraBetaMSFeatureRolloutPolicy" {
    Context "Test for Get-EntraBetaMSFeatureRolloutPolicy" {
        It "Should retrieves cloud authentication roll-out in Azure AD with given Id" {
            $result = Get-EntraBetaMSFeatureRolloutPolicy -Id "60184e48-569b-4ba5-a3bb-1d74cb9c2e5e"
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | should -Be "Feature-Rollout-Policytest"
            $result.Description | should -Be "Feature-Rollout-test"
            $result.IsEnabled | should -Be $true
            $result.Feature | should -Be "passwordHashSync"
            $result.IsAppliedToOrganization | should -Be $false
            $result.AppliesTo | should -BeNullOrEmpty
            $result.ObjectId | should -Be "60184e48-569b-4ba5-a3bb-1d74cb9c2e5e"

            Should -Invoke -CommandName Get-MgBetaPolicyFeatureRolloutPolicy -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when Id is empty" {
            { Get-EntraBetaMSFeatureRolloutPolicy -Id } | Should -Throw "Missing an argument for parameter 'Id'*"
        }

        It "Should fail when Id is invalid" {
            { Get-EntraBetaMSFeatureRolloutPolicy -Id "" } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string."
        }

        It "Should retrieves cloud authentication roll-out in Azure AD with given Filter." {
            $displayName = Get-EntraBetaMSFeatureRolloutPolicy -Filter "DisplayName eq 'Feature-Rollout-Policytest'"
            $displayName | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgBetaPolicyFeatureRolloutPolicy -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }  

        It "Should fail when Filter is empty" {
            { Get-EntraBetaMSFeatureRolloutPolicy -Filter } | Should -Throw "Missing an argument for parameter 'Filter'*"
        }  

        It "Should retrieves cloud authentication roll-out in Azure AD with given Search String." {
            $searchString = Get-EntraBetaMSFeatureRolloutPolicy -SearchString "Feature-Rollout-Policytest"
            $searchString | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgBetaPolicyFeatureRolloutPolicy -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }  

        It "Should fail when SearchString is empty" {
            { Get-EntraBetaMSFeatureRolloutPolicy -SearchString } | Should -Throw "Missing an argument for parameter 'SearchString'*"
        }  

        It "Result should Contain ObjectId" {
            $result = Get-EntraBetaMSFeatureRolloutPolicy -Id "60184e48-569b-4ba5-a3bb-1d74cb9c2e5e"
            $result.ObjectId | should -Be "60184e48-569b-4ba5-a3bb-1d74cb9c2e5e"
        } 

        It "Should contain Filter in parameters when SearchString passed to it" {
            $result = Get-EntraBetaMSFeatureRolloutPolicy -SearchString "Feature-Rollout-Policytest"
            $params = Get-Parameters -data $result.Parameters
            $expectedFilter = "displayName eq 'Feature-Rollout-Policytest' or startswith(displayName,'Feature-Rollout-Policytest')"
            $params.Filter | Should -Contain $expectedFilter
        }
        
        It "Should contain FeatureRolloutPolicyId in parameters when passed Id to it" {
            $result = Get-EntraBetaMSFeatureRolloutPolicy -Id "60184e48-569b-4ba5-a3bb-1d74cb9c2e5e"
            $params = Get-Parameters -data $result.Parameters
            $params.FeatureRolloutPolicyId | Should -Be "60184e48-569b-4ba5-a3bb-1d74cb9c2e5e"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaMSFeatureRolloutPolicy"

            $result = Get-EntraBetaMSFeatureRolloutPolicy -Id "60184e48-569b-4ba5-a3bb-1d74cb9c2e5e"
            $params = Get-Parameters -data $result.Parameters
            $params.Headers["User-Agent"] | Should -Contain $userAgentHeaderValue
        }    
    }
}