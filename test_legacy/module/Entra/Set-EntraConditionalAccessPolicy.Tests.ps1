# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra       
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Update-MgIdentityConditionalAccessPolicy -MockWith {} -ModuleName Microsoft.Graph.Entra
}

Describe "Set-EntraConditionalAccessPolicy" {
    Context "Test for Set-EntraConditionalAccessPolicy" {
        It "Should updates a conditional access policy in Microsoft Entra ID by PolicyId" {
            $Condition  = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessConditionSet
            $Controls   = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessGrantControls
            $SessionControls = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessSessionControls
            $result = Set-EntraConditionalAccessPolicy -PolicyId "1aaaaaa1-2bb2-3cc3-4dd4-5eeeeeeeeee5" -DisplayName "test" -State enabled -Conditions $Condition -GrantControls $Controls -SessionControls $SessionControls
            $result | Should -BeNullOrEmpty
            
            Should -Invoke -CommandName Update-MgIdentityConditionalAccessPolicy -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should fail when PolicyId parameter is empty" {
            { Set-EntraConditionalAccessPolicy -PolicyId } | Should -Throw "Missing an argument for parameter 'PolicyId'*"
        } 

        It "Should fail when PolicyId parameter is invalid" {
            { Set-EntraConditionalAccessPolicy -PolicyId ""  } | Should -Throw "Cannot bind argument to parameter 'PolicyId' because it is an empty string.*"
        }

        It "Should fail when DisplayName parameter is empty" {
            { Set-EntraConditionalAccessPolicy -PolicyId "1aaaaaa1-2bb2-3cc3-4dd4-5eeeeeeeeee5" -DisplayName } | Should -Throw "Missing an argument for parameter*"
        }

        It "Should fail when State parameter is empty" {
            { Set-EntraConditionalAccessPolicy -PolicyId "1aaaaaa1-2bb2-3cc3-4dd4-5eeeeeeeeee5" -State } | Should -Throw "Missing an argument for parameter*"
        }

        It "Should fail when Conditions parameter is empty" {
            { Set-EntraConditionalAccessPolicy -PolicyId "1aaaaaa1-2bb2-3cc3-4dd4-5eeeeeeeeee5" -Conditions  } | Should -Throw "Missing an argument for parameter*"
        }

        It "Should fail when Conditions parameter is invalid" {
            { Set-EntraConditionalAccessPolicy -PolicyId "1aaaaaa1-2bb2-3cc3-4dd4-5eeeeeeeeee5" -Conditions "" } | Should -Throw "Cannot process argument transformation on parameter 'Conditions'.*"
        }

        It "Should fail when GrantControls parameter is empty" {
            { Set-EntraConditionalAccessPolicy -PolicyId "1aaaaaa1-2bb2-3cc3-4dd4-5eeeeeeeeee5" -GrantControls } | Should -Throw "Missing an argument for parameter*"
        }

        It "Should fail when GrantControls parameter is invalid" {
            { Set-EntraConditionalAccessPolicy -PolicyId "1aaaaaa1-2bb2-3cc3-4dd4-5eeeeeeeeee5" -GrantControls "" } | Should -Throw "Cannot process argument transformation on parameter 'GrantControls'.*"
        }

        It "Should fail when SessionControls parameter is empty" {
            { Set-EntraConditionalAccessPolicy -PolicyId "1aaaaaa1-2bb2-3cc3-4dd4-5eeeeeeeeee5" -SessionControls } | Should -Throw "Missing an argument for parameter*"
        }

        It "Should fail when SessionControls parameter is invalid" {
            { Set-EntraConditionalAccessPolicy -PolicyId "1aaaaaa1-2bb2-3cc3-4dd4-5eeeeeeeeee5" -SessionControls "" } | Should -Throw "Cannot process argument transformation on parameter 'SessionControls'.*"
        }

        It "Should contain ConditionalAccessPolicyId in parameters when passed PolicyId to it" {
            Mock -CommandName Update-MgIdentityConditionalAccessPolicy -MockWith {$args} -ModuleName Microsoft.Graph.Entra
            
            $result = Set-EntraConditionalAccessPolicy -PolicyId "1aaaaaa1-2bb2-3cc3-4dd4-5eeeeeeeeee5" -DisplayName "test"
            $params = Get-Parameters -data $result
            $params.ConditionalAccessPolicyId | Should -Be "1aaaaaa1-2bb2-3cc3-4dd4-5eeeeeeeeee5"
        }

        It "Should contain ClientAppTypes in parameters when passed Conditions to it" {
            Mock -CommandName Update-MgIdentityConditionalAccessPolicy -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $Condition = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessConditionSet
            $Condition.clientAppTypes = @("mobileAppsAndDesktopClients","browser")
            $Controls = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessGrantControls
            $SessionControls = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessSessionControls
            $result = Set-EntraConditionalAccessPolicy -PolicyId "1aaaaaa1-2bb2-3cc3-4dd4-5eeeeeeeeee5" -DisplayName "test" -State enabled -Conditions $Condition -GrantControls $Controls -SessionControls $SessionControls
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
            $result = Set-EntraConditionalAccessPolicy -PolicyId "1aaaaaa1-2bb2-3cc3-4dd4-5eeeeeeeeee5" -DisplayName "test" -State enabled -Conditions $Condition -GrantControls $Controls -SessionControls $SessionControls
            $params = Get-Parameters -data $result
            $params.GrantControls.BuiltInControls | Should -Be @("mfa")

            Should -Invoke -CommandName Update-MgIdentityConditionalAccessPolicy -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraConditionalAccessPolicy"
            $Condition = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessConditionSet
            $Controls = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessGrantControls
            $Controls._Operator = "AND"
            $Controls.BuiltInControls = @("mfa")
            $SessionControls = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessSessionControls

            Set-EntraConditionalAccessPolicy -PolicyId "1aaaaaa1-2bb2-3cc3-4dd4-5eeeeeeeeee5" -DisplayName "test" -State enabled -Conditions $Condition -GrantControls $Controls -SessionControls $SessionControls

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraConditionalAccessPolicy"

            Should -Invoke -CommandName Update-MgIdentityConditionalAccessPolicy -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
                $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
                $true
            }
        } 
        It "Should execute successfully without throwing an error" {
            # Disable confirmation prompts       
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'
            $Condition = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessConditionSet
            $Controls = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessGrantControls
            $Controls._Operator = "AND"
            $Controls.BuiltInControls = @("mfa")
            $SessionControls = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessSessionControls

            try {
                # Act & Assert: Ensure the function doesn't throw an exception
                { Set-EntraConditionalAccessPolicy -PolicyId "1aaaaaa1-2bb2-3cc3-4dd4-5eeeeeeeeee5" -DisplayName "test" -State enabled -Conditions $Condition -GrantControls $Controls -SessionControls $SessionControls -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        } 
    }
}