BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta    
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName New-MgBetaDirectoryFeatureRolloutPolicyApplyToByRef -MockWith {} -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Add-EntraBetaMSFeatureRolloutPolicyDirectoryObject" {
    Context "Test for Add-EntraBetaMSFeatureRolloutPolicyDirectoryObject" {
        It "Should adds a group to the cloud authentication roll-out policy in Azure AD." {
            $result = Add-EntraBetaMSFeatureRolloutPolicyDirectoryObject -Id "a03b6d9e-6654-46e6-8d0a-8ed83c675ca9" -RefObjectId "0a1068c0-dbb6-4537-9db3-b48f3e31dd76"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName New-MgBetaDirectoryFeatureRolloutPolicyApplyToByRef -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when Id is empty" {
            { Add-EntraBetaMSFeatureRolloutPolicyDirectoryObject -Id  -RefObjectId "0a1068c0-dbb6-4537-9db3-b48f3e31dd76"  } | Should -Throw "Missing an argument for parameter 'Id'.*"
        }

        It "Should fail when Id is invalid" {
            { Add-EntraBetaMSFeatureRolloutPolicyDirectoryObject -Id "" -RefObjectId "0a1068c0-dbb6-4537-9db3-b48f3e31dd76"  } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string."
        }

        It "Should fail when RefObjectId is empty" {
            { Add-EntraBetaMSFeatureRolloutPolicyDirectoryObject -Id "a03b6d9e-6654-46e6-8d0a-8ed83c675ca9" -RefObjectId   } | Should -Throw "Missing an argument for parameter 'RefObjectId'.*"
        }

        It "Should fail when RefObjectId is invalid" {
            { Add-EntraBetaMSFeatureRolloutPolicyDirectoryObject -Id "a03b6d9e-6654-46e6-8d0a-8ed83c675ca9" -RefObjectId ""  } | Should -Throw "Cannot bind argument to parameter 'RefObjectId' because it is an empty string."
        }

        It "Should contain FeatureRolloutPolicyId in parameters when passed Id to it" {
            Mock -CommandName New-MgBetaDirectoryFeatureRolloutPolicyApplyToByRef -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta

            $result = Add-EntraBetaMSFeatureRolloutPolicyDirectoryObject -Id "a03b6d9e-6654-46e6-8d0a-8ed83c675ca9" -RefObjectId "0a1068c0-dbb6-4537-9db3-b48f3e31dd76"
            $params = Get-Parameters -data $result
            $params.FeatureRolloutPolicyId | Should -Be "a03b6d9e-6654-46e6-8d0a-8ed83c675ca9"
        }

        It "Should contain OdataId in parameters when passed RefObjectId to it" {
            Mock -CommandName New-MgBetaDirectoryFeatureRolloutPolicyApplyToByRef -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta

            $result = Add-EntraBetaMSFeatureRolloutPolicyDirectoryObject -Id "a03b6d9e-6654-46e6-8d0a-8ed83c675ca9" -RefObjectId "0a1068c0-dbb6-4537-9db3-b48f3e31dd76"
            $value = "https://graph.microsoft.com/v1.0/directoryObjects/0a1068c0-dbb6-4537-9db3-b48f3e31dd76" 
            $params= Get-Parameters -data $result
            $params.OdataId | Should -Be $value
        }

        It "Should contain 'User-Agent' header" {
            Mock -CommandName New-MgBetaDirectoryFeatureRolloutPolicyApplyToByRef -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Add-EntraBetaMSFeatureRolloutPolicyDirectoryObject"
            $result = Add-EntraBetaMSFeatureRolloutPolicyDirectoryObject -Id "a03b6d9e-6654-46e6-8d0a-8ed83c675ca9" -RefObjectId "0a1068c0-dbb6-4537-9db3-b48f3e31dd76"
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }
    }
}        
