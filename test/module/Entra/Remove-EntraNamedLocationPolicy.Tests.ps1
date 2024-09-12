# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra
    }
    Import-Module .\test\module\Common-Functions.ps1 -Force

    Mock -CommandName Remove-MgIdentityConditionalAccessNamedLocation -MockWith {} -ModuleName Microsoft.Graph.Entra
}

Describe "Remove-EntraNamedLocationPolicy" {
    Context "Test for Remove-EntraNamedLocationPolicy" {
        It "Should return empty object" {
            $result = Remove-EntraNamedLocationPolicy -PolicyId "1aaaaaa1-2bb2-3cc3-4dd4-5eeeeeeeeee5"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgIdentityConditionalAccessNamedLocation -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when PolicyId is empty" {
            { Remove-EntraNamedLocationPolicy -PolicyId  } | Should -Throw "Missing an argument for parameter 'PolicyId'*"
        } 
        It "Should fail when PolicyId is invalid" {
            { Remove-EntraNamedLocationPolicy -PolicyId "" } | Should -Throw "Cannot bind argument to parameter 'PolicyId' because it is an empty string*"
        }
        It "Should contain NamedLocationId in parameters when passed PolicyId to it" {
            Mock -CommandName Remove-MgIdentityConditionalAccessNamedLocation -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $result = Remove-EntraNamedLocationPolicy -PolicyId "1aaaaaa1-2bb2-3cc3-4dd4-5eeeeeeeeee5"
            $params = Get-Parameters -data $result
            $params.NamedLocationId | Should -Be "1aaaaaa1-2bb2-3cc3-4dd4-5eeeeeeeeee5"
        }   
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraNamedLocationPolicy"

            Remove-EntraNamedLocationPolicy -PolicyId "1aaaaaa1-2bb2-3cc3-4dd4-5eeeeeeeeee5"

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraNamedLocationPolicy"

            Should -Invoke -CommandName Remove-MgIdentityConditionalAccessNamedLocation -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
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
                { Remove-EntraNamedLocationPolicy -PolicyId "1aaaaaa1-2bb2-3cc3-4dd4-5eeeeeeeeee5" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        } 
    }
}