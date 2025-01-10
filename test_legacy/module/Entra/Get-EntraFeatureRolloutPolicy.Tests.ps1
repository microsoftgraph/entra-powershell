# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if ((Get-Module -Name Microsoft.Graph.Entra) -eq $null) {
        Import-Module Microsoft.Graph.Entra        
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        return @(
            [Microsoft.Graph.PowerShell.Models.MicrosoftGraphFeatureRolloutPolicy]@{
                "DisplayName"     = "Feature-Rollout-Policy"
                "Id"              = "bbbbbbbb-1111-2222-3333-cccccccccccc"
                "IsAppliedToOrganization"     = "False"
                "Description"     = "Feature-Rollout-Policy"
                "Feature"    = "emailAsAlternateId"
                "IsEnabled" = "True"
            }
        )
    }

    Mock -CommandName Invoke-GraphRequest -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}
  
Describe "Get-EntraFeatureRolloutPolicy" {
    Context "Test for Get-EntraFeatureRolloutPolicy" {
        It "Should return specific FeatureRolloutPolicy" {
            $result = Get-EntraFeatureRolloutPolicy -Id "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be 'bbbbbbbb-1111-2222-3333-cccccccccccc'

            Should -Invoke -CommandName Invoke-GraphRequest  -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when Id is invalid" {
            { Get-EntraFeatureRolloutPolicy -Id "" } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string."
        }
        It "Should fail when Id is empty" {
            { Get-EntraFeatureRolloutPolicy -Id } | Should -Throw "Missing an argument for parameter 'Id'*"
        }
        It "Should fail when searchstring is empty" {
            { Get-EntraFeatureRolloutPolicy -SearchString } | Should -Throw "Missing an argument for parameter 'SearchString'*"
        } 
        It "Should fail when filter is empty" {
            { Get-EntraFeatureRolloutPolicy -Filter } | Should -Throw "Missing an argument for parameter 'Filter'*"
        }           
        It "Should return specific FeatureRolloutPolicy by searchstring" {
            $result = Get-EntraFeatureRolloutPolicy -SearchString 'Feature-Rollout-Policy'
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | should -Be 'Feature-Rollout-Policy'

            Should -Invoke -CommandName Invoke-GraphRequest  -ModuleName Microsoft.Graph.Entra -Times 1
        } 
        It "Should return specific FeatureRolloutPolicy by filter" {
            $result = Get-EntraFeatureRolloutPolicy -Filter "DisplayName -eq 'Feature-Rollout-Policy'"
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | should -Be 'Feature-Rollout-Policy'

            Should -Invoke -CommandName Invoke-GraphRequest  -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should return specific Property" {
            $result = Get-EntraFeatureRolloutPolicy -Property Id
            $result.Id | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Invoke-GraphRequest  -ModuleName Microsoft.Graph.Entra -Times 1
        }  
        
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraFeatureRolloutPolicy"

            $result = Get-EntraFeatureRolloutPolicy
            $result | Should -Not -BeNullOrEmpty

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraFeatureRolloutPolicy"

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
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
                { Get-EntraFeatureRolloutPolicy -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }   
    }
}
