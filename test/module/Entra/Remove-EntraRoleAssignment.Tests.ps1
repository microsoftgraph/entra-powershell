# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra       
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Remove-MgRoleManagementDirectoryRoleAssignment -MockWith {} -ModuleName Microsoft.Graph.Entra
}
  
Describe "Remove-EntraRoleAssignment" {
    Context "Test for Remove-EntraRoleAssignment" {
        It "Should return empty object" {
            $result = Remove-EntraRoleAssignment -Id "Aa1Bb2Cc3.-Dd4Ee5Ff6Gg7Hh8Ii9_~Jj0Kk1Ll2"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgRoleManagementDirectoryRoleAssignment -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when Id is empty" {
            { Remove-EntraRoleAssignment -Id  } | Should -Throw "Missing an argument for parameter 'Id'*"
        }
        It "Should fail when Id is invalid" {
            { Remove-EntraRoleAssignment -Id "" } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string."
        }   
        It "Should contain UnifiedRoleAssignmentId in parameters when passed Id to it" {
            Mock -CommandName Remove-MgRoleManagementDirectoryRoleAssignment -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $result = Remove-EntraRoleAssignment -Id "Aa1Bb2Cc3.-Dd4Ee5Ff6Gg7Hh8Ii9_~Jj0Kk1Ll2"
            $params = Get-Parameters -data $result
            $params.UnifiedRoleAssignmentId | Should -Be "Aa1Bb2Cc3.-Dd4Ee5Ff6Gg7Hh8Ii9_~Jj0Kk1Ll2"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraRoleAssignment"

            Remove-EntraRoleAssignment -Id "Aa1Bb2Cc3.-Dd4Ee5Ff6Gg7Hh8Ii9_~Jj0Kk1Ll2"
            
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraRoleAssignment"

            Should -Invoke -CommandName Remove-MgRoleManagementDirectoryRoleAssignment -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
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
                { Remove-EntraRoleAssignment -Id "Aa1Bb2Cc3.-Dd4Ee5Ff6Gg7Hh8Ii9_~Jj0Kk1Ll2" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
}