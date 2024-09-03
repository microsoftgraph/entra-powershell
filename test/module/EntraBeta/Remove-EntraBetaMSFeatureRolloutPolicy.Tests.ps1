BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta    
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Remove-MgBetaPolicyFeatureRolloutPolicy -MockWith {} -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Remove-EntraBetaMSFeatureRolloutPolicy" {
    Context "Test for Remove-EntraBetaMSFeatureRolloutPolicy" {
        It "Should removes the policy for cloud authentication roll-out in Azure AD" {
            $result = Remove-EntraBetaMSFeatureRolloutPolicy -Id "7b10cf40-bc0e-46b5-9456-4520179eef5d"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgBetaPolicyFeatureRolloutPolicy -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when Id is empty" {
            { Remove-EntraBetaMSFeatureRolloutPolicy -Id } | Should -Throw "Missing an argument for parameter 'Id'*"
        }   

        It "Should fail when Id is invalid" {
            { Remove-EntraBetaMSFeatureRolloutPolicy -Id "" } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string."
        }   

        It "Should contain FeatureRolloutPolicyId in parameters when passed Id to it" {
            Mock -CommandName Remove-MgBetaPolicyFeatureRolloutPolicy -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta

            $result = Remove-EntraBetaMSFeatureRolloutPolicy -Id "7b10cf40-bc0e-46b5-9456-4520179eef5d"
            $params = Get-Parameters -data $result
            $params.FeatureRolloutPolicyId | Should -Be "7b10cf40-bc0e-46b5-9456-4520179eef5d"
        }

        It "Should contain 'User-Agent' header" {
            Mock -CommandName Remove-MgBetaPolicyFeatureRolloutPolicy -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraBetaMSFeatureRolloutPolicy"
            $result = Remove-EntraBetaMSFeatureRolloutPolicy -Id "7b10cf40-bc0e-46b5-9456-4520179eef5d"
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        } 
    }
}