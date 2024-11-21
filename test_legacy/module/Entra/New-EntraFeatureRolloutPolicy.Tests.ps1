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
            [PSCustomObject]@{
                "DisplayName"             = "FeatureRolloutPolicy"
                "Id"                      = "bbbbbbbb-1111-2222-3333-cccccccccccc"
                "IsEnabled"               = "False"
                "Description"             = "FeatureRolloutPolicy"
                "Feature"                 = "passwordHashSync"
                "IsAppliedToOrganization" = "False"
                "AppliesTo"               = ""
            }
        )
    }
    
    Mock -CommandName Invoke-GraphRequest -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}
  
Describe "New-EntraFeatureRolloutPolicy" {
    Context "Test for New-EntraFeatureRolloutPolicy" {
        It "Should return created FeatureRolloutPolicy" {
            $result = New-EntraFeatureRolloutPolicy -Feature 'PasswordHashSync' -DisplayName 'FeatureRolloutPolicy1' -Description 'FeatureRolloutPolicy1' -IsEnabled $false 
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | should -Be "FeatureRolloutPolicy"
            $result.IsAppliedToOrganization | should -Be "False"
            $result.IsEnabled | should -Be "False"
            $result.Description | should -Be "FeatureRolloutPolicy" 

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when Feature are invalid" {
            { New-EntraFeatureRolloutPolicy -Feature "" } | Should -Throw "Cannot bind argument to parameter 'Feature'*"
        }
        It "Should fail when Feature are empty" {
            { New-EntraFeatureRolloutPolicy -Feature } | Should -Throw "Missing an argument for parameter 'Feature'*"
        } 
        It "Should fail when DisplayName are invalid" {
            { New-EntraFeatureRolloutPolicy -DisplayName "" } | Should -Throw "Cannot bind argument to parameter 'DisplayName'*"
        }
        It "Should fail when DisplayName are empty" {
            { New-EntraFeatureRolloutPolicy -DisplayName } | Should -Throw "Missing an argument for parameter 'DisplayName'*"
        } 
        It "Should fail when Description are empty" {
            { New-EntraFeatureRolloutPolicy -Feature 'PasswordHashSync' -DisplayName 'FeatureRolloutPolicy1' -Description -IsEnabled $false  } | Should -Throw "Missing an argument for parameter 'Description'*"
        }
        It "Should fail when IsEnabled are invalid" {
            { New-EntraFeatureRolloutPolicy -IsEnabled "" } | Should -Throw "Cannot process argument transformation on parameter 'IsEnabled'.*"
        }
        It "Should fail when IsEnabled are empty" {
            { New-EntraFeatureRolloutPolicy -IsEnabled } | Should -Throw "Missing an argument for parameter 'IsEnabled'*"
        } 
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraFeatureRolloutPolicy"
            $result = New-EntraFeatureRolloutPolicy -Feature 'PasswordHashSync' -DisplayName 'FeatureRolloutPolicy1' -Description 'FeatureRolloutPolicy1' -IsEnabled $false 
            $result | Should -Not -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraFeatureRolloutPolicy"
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
                $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
                $true
            }
        } 
        It "Should execute successfully without throwing an error " {
            # Disable confirmation prompts       
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'
    
            try {
                # Act & Assert: Ensure the function doesn't throw an exception
                { New-EntraFeatureRolloutPolicy -Feature 'PasswordHashSync' -DisplayName 'FeatureRolloutPolicy1' -Description 'FeatureRolloutPolicy1' -IsEnabled $false -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        } 
    }
}
