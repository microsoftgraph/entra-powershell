# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Entra.Governance) -eq $null){
        Import-Module Microsoft.Entra.Governance       
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    Mock -CommandName Remove-MgRoleManagementDirectoryRoleDefinition -MockWith {} -ModuleName Microsoft.Entra.Governance

    Mock -CommandName Get-EntraContext -MockWith {
        @{
            Environment = @{
                Name = "Global"
            }
            Scopes      = @('RoleManagement.ReadWrite.Directory')
        }
    } -ModuleName Microsoft.Entra.Applications
}

Describe "Remove-EntraDirectoryRoleDefinition" {
    Context "Test for Remove-EntraDirectoryRoleDefinition" {
        It "Should return empty object" {
            $result = Remove-EntraDirectoryRoleDefinition -UnifiedRoleDefinitionId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" 
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgRoleManagementDirectoryRoleDefinition -ModuleName Microsoft.Entra.Governance -Times 1
        }
        It "Should execute successfully with Alias" {
            $result = Remove-EntraDirectoryRoleDefinition -Id "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" 
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgRoleManagementDirectoryRoleDefinition -ModuleName Microsoft.Entra.Governance -Times 1
        }
        It "Should fail when UnifiedRoleDefinitionId is empty" {
            { Remove-EntraDirectoryRoleDefinition -UnifiedRoleDefinitionId   } | Should -Throw "Missing an argument for parameter 'UnifiedRoleDefinitionId'*"
        }
        It "Should fail when UnifiedRoleDefinitionId is invalid" {
            { Remove-EntraDirectoryRoleDefinition -UnifiedRoleDefinitionId "" } | Should -Throw "Cannot bind argument to parameter 'UnifiedRoleDefinitionId' because it is an empty string*"
        }
        It "Should contain UnifiedRoleDefinitionId in parameters when passed Id to it" {
            Mock -CommandName Remove-MgRoleManagementDirectoryRoleDefinition -MockWith {$args} -ModuleName Microsoft.Entra.Governance

            $result = Remove-EntraDirectoryRoleDefinition -UnifiedRoleDefinitionId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" 
            $params = Get-Parameters -data $result
            $params.UnifiedRoleDefinitionId | Should -Be "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraDirectoryRoleDefinition"

            Remove-EntraDirectoryRoleDefinition -UnifiedRoleDefinitionId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" 
            
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraDirectoryRoleDefinition"

            Should -Invoke -CommandName Remove-MgRoleManagementDirectoryRoleDefinition -ModuleName Microsoft.Entra.Governance -Times 1 -ParameterFilter {
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
                { Remove-EntraDirectoryRoleDefinition -UnifiedRoleDefinitionId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
}        
