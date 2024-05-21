BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra       
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Update-MgIdentityConditionalAccessPolicy -MockWith {} -ModuleName Microsoft.Graph.Entra
}

Describe "Set-EntraMSConditionalAccessPolicy" {
    Context "Test for Set-EntraMSConditionalAccessPolicy" {
        It "Should updates a conditional access policy in Microsoft Entra ID by PolicyId" {
            $Condition  = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessConditionSet
            $Controls   = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessGrantControls
            $SessionControls = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessSessionControls
            $result = Set-EntraMSConditionalAccessPolicy -PolicyId "9cc10bb0-3d8f-4a2b-aafa-e00107b919fc" -DisplayName "test" -State enabled -Conditions $Condition -GrantControls $Controls -SessionControls $SessionControls
            $result | Should -BeNullOrEmpty
            
            Should -Invoke -CommandName Update-MgIdentityConditionalAccessPolicy -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should fail when PolicyId parameter is empty" {
            { Set-EntraMSConditionalAccessPolicy -PolicyId } | Should -Throw "Missing an argument for parameter 'PolicyId'*"
        } 

        It "Should fail when PolicyId parameter is invalid" {
            { Set-EntraMSConditionalAccessPolicy -PolicyId ""  } | Should -Throw "Cannot bind argument to parameter 'PolicyId' because it is an empty string.*"
        }

        It "Should fail when DisplayName parameter is empty" {
            { Set-EntraMSConditionalAccessPolicy -PolicyId "9cc10bb0-3d8f-4a2b-aafa-e00107b919fc" -DisplayName } | Should -Throw "Missing an argument for parameter*"
        }

        It "Should fail when State parameter is empty" {
            { Set-EntraMSConditionalAccessPolicy -PolicyId "9cc10bb0-3d8f-4a2b-aafa-e00107b919fc" -State } | Should -Throw "Missing an argument for parameter*"
        }

        It "Should fail when Conditions parameter is empty" {
            { Set-EntraMSConditionalAccessPolicy -PolicyId "9cc10bb0-3d8f-4a2b-aafa-e00107b919fc" -Conditions  } | Should -Throw "Missing an argument for parameter*"
        }

        It "Should fail when Conditions parameter is invalid" {
            { Set-EntraMSConditionalAccessPolicy -PolicyId "9cc10bb0-3d8f-4a2b-aafa-e00107b919fc" -Conditions "" } | Should -Throw "Cannot process argument transformation on parameter 'Conditions'.*"
        }

        It "Should fail when GrantControls parameter is empty" {
            { Set-EntraMSConditionalAccessPolicy -PolicyId "9cc10bb0-3d8f-4a2b-aafa-e00107b919fc" -GrantControls } | Should -Throw "Missing an argument for parameter*"
        }

        It "Should fail when GrantControls parameter is invalid" {
            { Set-EntraMSConditionalAccessPolicy -PolicyId "9cc10bb0-3d8f-4a2b-aafa-e00107b919fc" -GrantControls "" } | Should -Throw "Cannot process argument transformation on parameter 'GrantControls'.*"
        }

        It "Should fail when SessionControls parameter is empty" {
            { Set-EntraMSConditionalAccessPolicy -PolicyId "9cc10bb0-3d8f-4a2b-aafa-e00107b919fc" -SessionControls } | Should -Throw "Missing an argument for parameter*"
        }

        It "Should fail when SessionControls parameter is invalid" {
            { Set-EntraMSConditionalAccessPolicy -PolicyId "9cc10bb0-3d8f-4a2b-aafa-e00107b919fc" -SessionControls "" } | Should -Throw "Cannot process argument transformation on parameter 'SessionControls'.*"
        }

        It "Should contain ConditionalAccessPolicyId in parameters when passed PolicyId to it" {
            Mock -CommandName Update-MgIdentityConditionalAccessPolicy -MockWith {$args} -ModuleName Microsoft.Graph.Entra
            
            $result = Set-EntraMSConditionalAccessPolicy -PolicyId "9cc10bb0-3d8f-4a2b-aafa-e00107b919fc" -DisplayName "test"
            $params = Get-Parameters -data $result
            $params.ConditionalAccessPolicyId | Should -Be "9cc10bb0-3d8f-4a2b-aafa-e00107b919fc"
        }

        It "Should contain ClientAppTypes in parameters when passed Conditions to it" {
            Mock -CommandName Update-MgIdentityConditionalAccessPolicy -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $Condition = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessConditionSet
            $Condition.clientAppTypes = @("mobileAppsAndDesktopClients","browser")
            $Controls = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessGrantControls
            $SessionControls = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessSessionControls
            $result = Set-EntraMSConditionalAccessPolicy -PolicyId "9cc10bb0-3d8f-4a2b-aafa-e00107b919fc" -DisplayName "test" -State enabled -Conditions $Condition -GrantControls $Controls -SessionControls $SessionControls
            $params = Get-Parameters -data $result
            $params.Conditions.ClientAppTypes | Should -Be @("mobileAppsAndDesktopClients","browser")

            Should -Invoke -CommandName Update-MgIdentityConditionalAccessPolicy -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should contain BuiltInControls in parameters when passed GrantControls to it" {
            Mock -CommandName Update-MgIdentityConditionalAccessPolicy -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $Condition = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessConditionSet
            $Controls = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessGrantControls
            $Controls._Operator = "AND"
            $Controls.BuiltInControls = @("mfa")
            $SessionControls = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessSessionControls
            $result = Set-EntraMSConditionalAccessPolicy -PolicyId "9cc10bb0-3d8f-4a2b-aafa-e00107b919fc" -DisplayName "test" -State enabled -Conditions $Condition -GrantControls $Controls -SessionControls $SessionControls
            $params = Get-Parameters -data $result
            $params.GrantControls.BuiltInControls | Should -Be @("mfa")

            Should -Invoke -CommandName Update-MgIdentityConditionalAccessPolicy -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should contain 'User-Agent' header" {
            Mock -CommandName Update-MgIdentityConditionalAccessPolicy -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraMSConditionalAccessPolicy"
            $result = Set-EntraMSConditionalAccessPolicy -PolicyId "9cc10bb0-3d8f-4a2b-aafa-e00107b919fc" -DisplayName "test"
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }  
    }
}