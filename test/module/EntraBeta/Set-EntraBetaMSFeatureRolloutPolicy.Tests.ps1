BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta    
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName  Update-MgBetaPolicyFeatureRolloutPolicy -MockWith {} -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Set-EntraBetaMSFeatureRolloutPolicy" {
    Context "Test for Set-EntraBetaMSFeatureRolloutPolicy" {
        It "Should creates the policy for cloud authentication roll-out in Azure AD." {
            $result = Set-EntraBetaMSFeatureRolloutPolicy -Id "60184e48-569b-4ba5-a3bb-1d74cb9c2e5e" -Feature "passwordHashSync" -DisplayName "Feature-Rollout-Policytest" -IsEnabled $true -IsAppliedToOrganization $false -Description "Feature-Rollout-test"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Update-MgBetaPolicyFeatureRolloutPolicy -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when Feature is empty" {
            { Set-EntraBetaMSFeatureRolloutPolicy -Id "60184e48-569b-4ba5-a3bb-1d74cb9c2e5e" -Feature  -DisplayName "Feature-Rollout-Policytest" -IsEnabled $true -IsAppliedToOrganization $false -Description "Feature-Rollout-test" } | Should -Throw "Missing an argument for parameter 'Feature'*"
        }

        It "Should fail when Feature is invalid" {
            { Set-EntraBetaMSFeatureRolloutPolicy -Id "60184e48-569b-4ba5-a3bb-1d74cb9c2e5e" -Feature "" -DisplayName "Feature-Rollout-Policytest" -IsEnabled $true -IsAppliedToOrganization $false -Description "Feature-Rollout-test" } | Should -Throw "Cannot process argument transformation on parameter 'Feature'*"
        }

        It "Should fail when DisplayName is empty" {
            { Set-EntraBetaMSFeatureRolloutPolicy -Id "60184e48-569b-4ba5-a3bb-1d74cb9c2e5e" -Feature "passwordHashSync" -DisplayName -IsEnabled $true -IsAppliedToOrganization $false -Description "Feature-Rollout-test" } | Should -Throw "Missing an argument for parameter 'DisplayName'*"
        }

        It "Should fail when IsEnabled is empty" {
            { Set-EntraBetaMSFeatureRolloutPolicy -Id "60184e48-569b-4ba5-a3bb-1d74cb9c2e5e" -Feature "passwordHashSync" -DisplayName "Feature-Rollout-Policytest" -IsEnabled -IsAppliedToOrganization $false -Description "Feature-Rollout-test" } | Should -Throw "Missing an argument for parameter 'IsEnabled'*"
        }

        It "Should fail when IsEnabled is invalid" {
            { Set-EntraBetaMSFeatureRolloutPolicy -Id "60184e48-569b-4ba5-a3bb-1d74cb9c2e5e" -Feature "passwordHashSync" -DisplayName "Feature-Rollout-Policytest" -IsEnabled "" -IsAppliedToOrganization $false -Description "Feature-Rollout-test" } | Should -Throw "Cannot process argument transformation on parameter 'IsEnabled'*"
        }

        It "Should fail when IsAppliedToOrganization is empty" {
            { Set-EntraBetaMSFeatureRolloutPolicy -Id "60184e48-569b-4ba5-a3bb-1d74cb9c2e5e" -Feature "passwordHashSync" -DisplayName "Feature-Rollout-Policytest" -IsEnabled $true -IsAppliedToOrganization -Description "Feature-Rollout-test" } | Should -Throw "Missing an argument for parameter 'IsAppliedToOrganization'*"
        }

        It "Should fail when IsAppliedToOrganization is invalid" {
            { Set-EntraBetaMSFeatureRolloutPolicy -Id "60184e48-569b-4ba5-a3bb-1d74cb9c2e5e" -Feature "passwordHashSync" -DisplayName "Feature-Rollout-Policytest" -IsEnabled $true -IsAppliedToOrganization "" -Description "Feature-Rollout-test" } | Should -Throw "Cannot process argument transformation on parameter 'IsAppliedToOrganization'*"
        }

        It "Should fail when Description is empty" {
            { Set-EntraBetaMSFeatureRolloutPolicy -Id "60184e48-569b-4ba5-a3bb-1d74cb9c2e5e" -Feature "passwordHashSync" -DisplayName "Feature-Rollout-Policytest" -IsEnabled $true -IsAppliedToOrganization $false -Description } | Should -Throw "Missing an argument for parameter 'Description'*"
        }

        It "Should fail when AppliesTo is empty" {
            { Set-EntraBetaMSFeatureRolloutPolicy -Id "60184e48-569b-4ba5-a3bb-1d74cb9c2e5e" -Feature "passwordHashSync" -DisplayName "Feature-Rollout-Policytest" -IsEnabled $true -IsAppliedToOrganization $false -Description "Feature-Rollout-test" -AppliesTo  } | Should -Throw "Missing an argument for parameter 'AppliesTo'*"
        }

        It "Should fail when AppliesTo is invalid" {
            { Set-EntraBetaMSFeatureRolloutPolicy -Id "60184e48-569b-4ba5-a3bb-1d74cb9c2e5e" -Feature "passwordHashSync" -DisplayName "Feature-Rollout-Policytest" -IsEnabled $true -IsAppliedToOrganization $false -Description "Feature-Rollout-test" -AppliesTo ""} | Should -Throw "Cannot process argument transformation on parameter 'AppliesTo'*"
        }

        It "Should contain FeatureRolloutPolicyId in parameters when passed Id to it" {
            Mock -CommandName  Update-MgBetaPolicyFeatureRolloutPolicy -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta

            $result = Set-EntraBetaMSFeatureRolloutPolicy -Id "60184e48-569b-4ba5-a3bb-1d74cb9c2e5e" -Feature "passwordHashSync" -DisplayName "Feature-Rollout-Policytest" -IsEnabled $true -IsAppliedToOrganization $false -Description "Feature-Rollout-test"
            $params = Get-Parameters -data $result
            $params.FeatureRolloutPolicyId | Should -Be "60184e48-569b-4ba5-a3bb-1d74cb9c2e5e"
        }

        It "Should contain 'User-Agent' header" {
            Mock -CommandName  Update-MgBetaPolicyFeatureRolloutPolicy -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraBetaMSFeatureRolloutPolicy"
            $result = Set-EntraBetaMSFeatureRolloutPolicy -Id "60184e48-569b-4ba5-a3bb-1d74cb9c2e5e" -Feature "passwordHashSync" -DisplayName "Feature-Rollout-Policytest" -IsEnabled $true -IsAppliedToOrganization $false -Description "Feature-Rollout-test"
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Contain $userAgentHeaderValue
        }    
    }
}