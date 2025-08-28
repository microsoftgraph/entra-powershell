# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Entra.Beta.Governance) -eq $null){
        Import-Module Microsoft.Entra.Beta.Governance       
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    Mock -CommandName Remove-MgBetaRoleManagementDirectoryRoleAssignment -MockWith {} -ModuleName Microsoft.Entra.Beta.Governance

    Mock -CommandName Get-EntraContext -MockWith {
        @{
            Environment = @{
                Name = "Global"
            }
            Scopes      = @('RoleManagement.ReadWrite.Directory', 'EntitlementManagement.ReadWrite.All')
        }
    } -ModuleName Microsoft.Entra.Beta.Governance
}
  
Describe "Remove-EntraBetaDirectoryRoleAssignment" {
    Context "Test for Remove-EntraBetaDirectoryRoleAssignment" {
        It "Should return empty object" {
            $result = Remove-EntraBetaDirectoryRoleAssignment -UnifiedRoleAssignmentId "Aa1Bb2Cc3.-Dd4Ee5Ff6Gg7Hh8Ii9_~Jj0Kk1Ll2"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgBetaRoleManagementDirectoryRoleAssignment -ModuleName Microsoft.Entra.Beta.Governance -Times 1
        }
        It "Should execute successfully with Alias" {
            $result = Remove-EntraBetaDirectoryRoleAssignment -Id "Aa1Bb2Cc3.-Dd4Ee5Ff6Gg7Hh8Ii9_~Jj0Kk1Ll2"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgBetaRoleManagementDirectoryRoleAssignment -ModuleName Microsoft.Entra.Beta.Governance -Times 1
        }
        It "Should fail when UnifiedRoleAssignmentId is empty" {
            { Remove-EntraBetaDirectoryRoleAssignment -UnifiedRoleAssignmentId  } | Should -Throw "Missing an argument for parameter 'UnifiedRoleAssignmentId'*"
        }
        It "Should fail when UnifiedRoleAssignmentId is invalid" {
            { Remove-EntraBetaDirectoryRoleAssignment -UnifiedRoleAssignmentId "" } | Should -Throw "Cannot bind argument to parameter 'UnifiedRoleAssignmentId' because it is an empty string."
        }   
        It "Should contain UnifiedRoleAssignmentId in parameters when passed Id to it" {
            Mock -CommandName Remove-MgBetaRoleManagementDirectoryRoleAssignment -MockWith {$args} -ModuleName Microsoft.Entra.Beta.Governance

            $result = Remove-EntraBetaDirectoryRoleAssignment -UnifiedRoleAssignmentId "Aa1Bb2Cc3.-Dd4Ee5Ff6Gg7Hh8Ii9_~Jj0Kk1Ll2"
            $params = Get-Parameters -data $result
            $params.UnifiedRoleAssignmentId | Should -Be "Aa1Bb2Cc3.-Dd4Ee5Ff6Gg7Hh8Ii9_~Jj0Kk1Ll2"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraBetaDirectoryRoleAssignment"

            Remove-EntraBetaDirectoryRoleAssignment -UnifiedRoleAssignmentId "Aa1Bb2Cc3.-Dd4Ee5Ff6Gg7Hh8Ii9_~Jj0Kk1Ll2"
            
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraBetaDirectoryRoleAssignment"

            Should -Invoke -CommandName Remove-MgBetaRoleManagementDirectoryRoleAssignment -ModuleName Microsoft.Entra.Beta.Governance -Times 1 -ParameterFilter {
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
                { Remove-EntraBetaDirectoryRoleAssignment -UnifiedRoleAssignmentId "Aa1Bb2Cc3.-Dd4Ee5Ff6Gg7Hh8Ii9_~Jj0Kk1Ll2" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
}