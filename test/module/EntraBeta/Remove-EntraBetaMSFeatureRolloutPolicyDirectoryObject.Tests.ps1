BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta    
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Remove-MgBetaPolicyFeatureRolloutPolicyApplyToByRef -MockWith {} -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Remove-EntraBetaMSFeatureRolloutPolicyDirectoryObject" {
    Context "Test for Remove-EntraBetaMSFeatureRolloutPolicyDirectoryObject" {
        It "Should removes a group from the cloud authentication roll-out policy from Azure AD" {
            $result = Remove-EntraBetaMSFeatureRolloutPolicyDirectoryObject -Id "a03b6d9e-6654-46e6-8d0a-8ed83c675ca9" -ObjectId "0a1068c0-dbb6-4537-9db3-b48f3e31dd76"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgBetaPolicyFeatureRolloutPolicyApplyToByRef -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when Id is empty" {
            { Remove-EntraBetaMSFeatureRolloutPolicyDirectoryObject -Id  -ObjectId "0a1068c0-dbb6-4537-9db3-b48f3e31dd76" } | Should -Throw "Missing an argument for parameter 'Id'*"
        }   

        It "Should fail when Id is invalid" {
            { Remove-EntraBetaMSFeatureRolloutPolicyDirectoryObject -Id "" -ObjectId "0a1068c0-dbb6-4537-9db3-b48f3e31dd76" } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string."
        }   

        It "Should fail when ObjectId is empty" {
            { Remove-EntraBetaMSFeatureRolloutPolicyDirectoryObject -Id "a03b6d9e-6654-46e6-8d0a-8ed83c675ca9" -ObjectId  } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
        }   

        It "Should fail when ObjectId is invalid" {
            { Remove-EntraBetaMSFeatureRolloutPolicyDirectoryObject -Id "a03b6d9e-6654-46e6-8d0a-8ed83c675ca9" -ObjectId ""} | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }   

        It "Should contain DirectoryObjectId in parameters when passed ObjectId to it" {
            Mock -CommandName Remove-MgBetaPolicyFeatureRolloutPolicyApplyToByRef -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta

            $result = Remove-EntraBetaMSFeatureRolloutPolicyDirectoryObject -Id "a03b6d9e-6654-46e6-8d0a-8ed83c675ca9" -ObjectId "0a1068c0-dbb6-4537-9db3-b48f3e31dd76"
            $params = Get-Parameters -data $result
            $params.DirectoryObjectId | Should -Be "0a1068c0-dbb6-4537-9db3-b48f3e31dd76"
        }

        It "Should contain FeatureRolloutPolicyId in parameters when passed Id to it" {
            Mock -CommandName Remove-MgBetaPolicyFeatureRolloutPolicyApplyToByRef -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta

            $result = Remove-EntraBetaMSFeatureRolloutPolicyDirectoryObject -Id "a03b6d9e-6654-46e6-8d0a-8ed83c675ca9" -ObjectId "0a1068c0-dbb6-4537-9db3-b48f3e31dd76"
            $params = Get-Parameters -data $result
            $params.FeatureRolloutPolicyId | Should -Be "a03b6d9e-6654-46e6-8d0a-8ed83c675ca9"
        }

        It "Should contain 'User-Agent' header" {
            Mock -CommandName Remove-MgBetaPolicyFeatureRolloutPolicyApplyToByRef -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraBetaMSFeatureRolloutPolicyDirectoryObject"
            $result = Remove-EntraBetaMSFeatureRolloutPolicyDirectoryObject -Id "a03b6d9e-6654-46e6-8d0a-8ed83c675ca9" -ObjectId "0a1068c0-dbb6-4537-9db3-b48f3e31dd76"
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        } 
    }
}