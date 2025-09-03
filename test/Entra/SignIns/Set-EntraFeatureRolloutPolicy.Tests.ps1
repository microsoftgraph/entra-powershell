# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.SignIns) -eq $null) {
        Import-Module Microsoft.Entra.SignIns      
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    Mock -CommandName Invoke-GraphRequest -MockWith {} -ModuleName Microsoft.Entra.SignIns
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @('Directory.ReadWrite.All') } } -ModuleName Microsoft.Entra.SignIns
}

Describe "Set-EntraFeatureRolloutPolicy" {
    Context "Test for Set-EntraFeatureRolloutPolicy" {
        It "Should return created FeatureRolloutPolicy" {
            $result = Set-EntraFeatureRolloutPolicy -Id 7e22e9df-abf0-4ee2-bcf8-fd7b62eff2f5 -DisplayName 'Feature-Rollout-Policytest' -Description 'Feature-Rollout-test' -IsEnabled $false
            $result | Should -BeNullOrEmpty 

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.SignIns -Times 1
        }
        It "Should fail when Id are invalid" {
            { Set-EntraFeatureRolloutPolicy -Id "" } | Should -Throw "Cannot bind argument to parameter 'Id'*"
        }
        It "Should fail when Id are empty" {
            { Set-EntraFeatureRolloutPolicy -Id } | Should -Throw "Missing an argument for parameter 'Id'*"
        } 
        It "Should fail when Feature are empty" {
            { Set-EntraFeatureRolloutPolicy -Id 7e22e9df-abf0-4ee2-bcf8-fd7b62eff2f5 -Feature } | Should -Throw "Missing an argument for parameter 'Feature'*"
        } 
        It "Should fail when DisplayName are empty" {
            { Set-EntraFeatureRolloutPolicy -Id 7e22e9df-abf0-4ee2-bcf8-fd7b62eff2f5 -DisplayName } | Should -Throw "Missing an argument for parameter 'DisplayName'*"
        } 
        It "Should fail when Description are empty" {
            { Set-EntraFeatureRolloutPolicy -Id 7e22e9df-abf0-4ee2-bcf8-fd7b62eff2f5 -Description  } | Should -Throw "Missing an argument for parameter 'Description'*"
        }
        It "Should fail when IsEnabled are invalid" {
            { Set-EntraFeatureRolloutPolicy -Id 7e22e9df-abf0-4ee2-bcf8-fd7b62eff2f5 -IsEnabled "" } | Should -Throw "Cannot process argument transformation on parameter 'IsEnabled'.*"
        }
        It "Should fail when IsEnabled are empty" {
            { Set-EntraFeatureRolloutPolicy -Id 7e22e9df-abf0-4ee2-bcf8-fd7b62eff2f5 -IsEnabled } | Should -Throw "Missing an argument for parameter 'IsEnabled'*"
        } 
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraFeatureRolloutPolicy"

            Set-EntraFeatureRolloutPolicy -Id 7e22e9df-abf0-4ee2-bcf8-fd7b62eff2f5 -DisplayName 'Feature-Rollout-Policytest' -Description 'Feature-Rollout-test' -IsEnabled $false

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraFeatureRolloutPolicy"

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.SignIns -Times 1 -ParameterFilter {
                $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
                $true
            }
        } 
        It "Should execute successfully without throwing an error" {
            # Disable confirmation prompts       
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'

            try {
                # Act & Assert: Ensure the function doesn't throw an exception
                { Set-EntraFeatureRolloutPolicy -Id 7e22e9df-abf0-4ee2-bcf8-fd7b62eff2f5 -DisplayName 'Feature-Rollout-Policytest' -Description 'Feature-Rollout-test' -IsEnabled $false -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }   
    }
}

