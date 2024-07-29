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
    Mock -CommandName  New-MgBetaPolicyFeatureRolloutPolicy -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "New-EntraBetaMSFeatureRolloutPolicy" {
    Context "Test for New-EntraBetaMSFeatureRolloutPolicy" {
        It "Should creates the policy for cloud authentication roll-out in Azure AD." {
            $result = New-EntraBetaMSFeatureRolloutPolicy -Feature "passwordHashSync" -DisplayName "Feature-Rollout-Policytest" -IsEnabled $true -IsAppliedToOrganization $false -Description "Feature-Rollout-test"
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | should -Be "Feature-Rollout-Policytest"
            $result.Description | should -Be "Feature-Rollout-test"
            $result.IsEnabled | should -Be $true
            $result.Feature | should -Be "passwordHashSync"
            $result.IsAppliedToOrganization | should -Be $false
            $result.AppliesTo | should -BeNullOrEmpty
            $result.ObjectId | should -Be "60184e48-569b-4ba5-a3bb-1d74cb9c2e5e"

            Should -Invoke -CommandName New-MgBetaPolicyFeatureRolloutPolicy -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when Feature is empty" {
            { New-EntraBetaMSFeatureRolloutPolicy -Feature  -DisplayName "Feature-Rollout-Policytest" -IsEnabled $true -IsAppliedToOrganization $false -Description "Feature-Rollout-test" } | Should -Throw "Missing an argument for parameter 'Feature'*"
        }

        It "Should fail when Feature is invalid" {
            { New-EntraBetaMSFeatureRolloutPolicy -Feature "" -DisplayName "Feature-Rollout-Policytest" -IsEnabled $true -IsAppliedToOrganization $false -Description "Feature-Rollout-test" } | Should -Throw "Cannot process argument transformation on parameter 'Feature'*"
        }

        It "Should fail when DisplayName is empty" {
            { New-EntraBetaMSFeatureRolloutPolicy -Feature "passwordHashSync" -DisplayName -IsEnabled $true -IsAppliedToOrganization $false -Description "Feature-Rollout-test" } | Should -Throw "Missing an argument for parameter 'DisplayName'*"
        }

        It "Should fail when DisplayName is invalid" {
            { New-EntraBetaMSFeatureRolloutPolicy -Feature "passwordHashSync" -DisplayName "" -IsEnabled $true -IsAppliedToOrganization $false -Description "Feature-Rollout-test" } | Should -Throw "Cannot bind argument to parameter 'DisplayName' because it is an empty string."
        }

        It "Should fail when IsEnabled is empty" {
            { New-EntraBetaMSFeatureRolloutPolicy -Feature "passwordHashSync" -DisplayName "Feature-Rollout-Policytest" -IsEnabled -IsAppliedToOrganization $false -Description "Feature-Rollout-test" } | Should -Throw "Missing an argument for parameter 'IsEnabled'*"
        }

        It "Should fail when IsEnabled is invalid" {
            { New-EntraBetaMSFeatureRolloutPolicy -Feature "passwordHashSync" -DisplayName "Feature-Rollout-Policytest" -IsEnabled "" -IsAppliedToOrganization $false -Description "Feature-Rollout-test" } | Should -Throw "Cannot process argument transformation on parameter 'IsEnabled'*"
        }

        It "Should fail when IsAppliedToOrganization is empty" {
            { New-EntraBetaMSFeatureRolloutPolicy -Feature "passwordHashSync" -DisplayName "Feature-Rollout-Policytest" -IsEnabled $true -IsAppliedToOrganization -Description "Feature-Rollout-test" } | Should -Throw "Missing an argument for parameter 'IsAppliedToOrganization'*"
        }

        It "Should fail when IsAppliedToOrganization is invalid" {
            { New-EntraBetaMSFeatureRolloutPolicy -Feature "passwordHashSync" -DisplayName "Feature-Rollout-Policytest" -IsEnabled $true -IsAppliedToOrganization "" -Description "Feature-Rollout-test" } | Should -Throw "Cannot process argument transformation on parameter 'IsAppliedToOrganization'*"
        }

        It "Should fail when Description is empty" {
            { New-EntraBetaMSFeatureRolloutPolicy -Feature "passwordHashSync" -DisplayName "Feature-Rollout-Policytest" -IsEnabled $true -IsAppliedToOrganization $false -Description } | Should -Throw "Missing an argument for parameter 'Description'*"
        }

        It "Should fail when AppliesTo is empty" {
            { New-EntraBetaMSFeatureRolloutPolicy -Feature "passwordHashSync" -DisplayName "Feature-Rollout-Policytest" -IsEnabled $true -IsAppliedToOrganization $false -Description "Feature-Rollout-test" -AppliesTo  } | Should -Throw "Missing an argument for parameter 'AppliesTo'*"
        }

        It "Should fail when AppliesTo is invalid" {
            { New-EntraBetaMSFeatureRolloutPolicy -Feature "passwordHashSync" -DisplayName "Feature-Rollout-Policytest" -IsEnabled $true -IsAppliedToOrganization $false -Description "Feature-Rollout-test" -AppliesTo ""} | Should -Throw "Cannot process argument transformation on parameter 'AppliesTo'*"
        }

        It "Result should Contain ObjectId" {
            $result = New-EntraBetaMSFeatureRolloutPolicy -Feature "passwordHashSync" -DisplayName "Feature-Rollout-Policytest" -IsEnabled $true -IsAppliedToOrganization $false -Description "Feature-Rollout-test"
            $result.ObjectId | should -Be "60184e48-569b-4ba5-a3bb-1d74cb9c2e5e"
        } 

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraBetaMSFeatureRolloutPolicy"

            $result = New-EntraBetaMSFeatureRolloutPolicy -Feature "passwordHashSync" -DisplayName "Feature-Rollout-Policytest" -IsEnabled $true -IsAppliedToOrganization $false -Description "Feature-Rollout-test"
            $params = Get-Parameters -data $result.Parameters
            $params.Headers["User-Agent"] | Should -Contain $userAgentHeaderValue
        }    
    }
}