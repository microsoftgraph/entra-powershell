# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.Beta.Groups) -eq $null) {
        Import-Module Microsoft.Entra.Beta.Groups    
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    Mock -CommandName Remove-MgBetaGroupLifecyclePolicy -MockWith {} -ModuleName Microsoft.Entra.Beta.Groups
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("Directory.ReadWrite.All") } } -ModuleName Microsoft.Entra.Beta.Groups
}

Describe "Remove-EntraBetaGroupLifecyclePolicy" {
    Context "Test for Remove-EntraBetaGroupLifecyclePolicy" {
        It "Should return empty Id" {
            $result = Remove-EntraBetaGroupLifecyclePolicy -GroupLifecyclePolicyId "aaaabbbb-0000-cccc-1111-dddd2222eeee"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgBetaGroupLifecyclePolicy -ModuleName Microsoft.Entra.Beta.Groups -Times 1
        }

        It "Should execute successfully with Alias" {
            $result = Remove-EntraBetaGroupLifecyclePolicy -Id "aaaabbbb-0000-cccc-1111-dddd2222eeee"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgBetaGroupLifecyclePolicy -ModuleName Microsoft.Entra.Beta.Groups -Times 1
        }

        It "Should fail when GroupLifecyclePolicyId is empty" {
            { Remove-EntraBetaGroupLifecyclePolicy -GroupLifecyclePolicyId } | Should -Throw "Missing an argument for parameter 'GroupLifecyclePolicyId'*"
        }   

        It "Should contain GroupLifecyclePolicyId in parameters when passed GroupLifecyclePolicyId to it" {
            Mock -CommandName Remove-MgBetaGroupLifecyclePolicy -MockWith { $args } -ModuleName Microsoft.Entra.Beta.Groups

            $result = Remove-EntraBetaGroupLifecyclePolicy -GroupLifecyclePolicyId "aaaabbbb-0000-cccc-1111-dddd2222eeee"
            $params = Get-Parameters -data $result
            $params.GroupLifecyclePolicyId | Should -Be "aaaabbbb-0000-cccc-1111-dddd2222eeee"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraBetaGroupLifecyclePolicy"
            $result = Remove-EntraBetaGroupLifecyclePolicy -GroupLifecyclePolicyId "aaaabbbb-0000-cccc-1111-dddd2222eeee"
            $result | Should -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraBetaGroupLifecyclePolicy"
            Should -Invoke -CommandName Remove-MgBetaGroupLifecyclePolicy -ModuleName Microsoft.Entra.Beta.Groups -Times 1 -ParameterFilter {
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
                { Remove-EntraBetaGroupLifecyclePolicy -GroupLifecyclePolicyId "aaaabbbb-0000-cccc-1111-dddd2222eeee" -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        } 
    }
}

