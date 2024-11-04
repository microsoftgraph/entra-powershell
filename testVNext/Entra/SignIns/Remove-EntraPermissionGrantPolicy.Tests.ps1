# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra
    }
    Import-Module .\test\module\Common-Functions.ps1 -Force

    Mock -CommandName Remove-MgPolicyPermissionGrantPolicy -MockWith {} -ModuleName Microsoft.Graph.Entra
}

Describe "Remove-EntraPermissionGrantPolicy" {
    Context "Test for Remove-EntraPermissionGrantPolicy" {
        It "Should return empty object" {
            $result = Remove-EntraPermissionGrantPolicy -Id "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgPolicyPermissionGrantPolicy -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when Id is empty" {
            { Remove-EntraPermissionGrantPolicy -Id  } | Should -Throw "Missing an argument for parameter 'Id'*"
        } 
        It "Should fail when Id is invalid" {
            { Remove-EntraPermissionGrantPolicy -Id "" } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string*"
        }
        It "Should contain PermissionGrantPolicyId in parameters when passed Id to it" {
            Mock -CommandName Remove-MgPolicyPermissionGrantPolicy -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $result = Remove-EntraPermissionGrantPolicy -Id "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
            $params = Get-Parameters -data $result
            $params.PermissionGrantPolicyId | Should -Be "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
        }   
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraPermissionGrantPolicy"

            Remove-EntraPermissionGrantPolicy -Id "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraPermissionGrantPolicy"

            Should -Invoke -CommandName Remove-MgPolicyPermissionGrantPolicy -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
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
                {Remove-EntraPermissionGrantPolicy -Id "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        } 
    }
}