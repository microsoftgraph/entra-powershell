# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra       
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Remove-MgRoleManagementDirectoryRoleDefinition -MockWith {} -ModuleName Microsoft.Graph.Entra
}

Describe "Remove-EntraRoleDefinition" {
    Context "Test for Remove-EntraRoleDefinition" {
        It "Should return empty object" {
            $result = Remove-EntraRoleDefinition -Id "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" 
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgRoleManagementDirectoryRoleDefinition -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when Id is empty" {
            { Remove-EntraRoleDefinition -Id   } | Should -Throw "Missing an argument for parameter 'Id'*"
        }
        It "Should fail when Id is invalid" {
            { Remove-EntraRoleDefinition -Id "" } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string*"
        }
        It "Should contain UnifiedRoleDefinitionId in parameters when passed Id to it" {
            Mock -CommandName Remove-MgRoleManagementDirectoryRoleDefinition -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $result = Remove-EntraRoleDefinition -Id "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" 
            $params = Get-Parameters -data $result
            $params.UnifiedRoleDefinitionId | Should -Be "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
        }
        It "Should contain 'User-Agent' header" {
            Mock -CommandName Remove-MgRoleManagementDirectoryRoleDefinition -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraRoleDefinition"
            $result = Remove-EntraRoleDefinition -Id "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" 
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }
        It "Should execute successfully without throwing an error" {
            # Disable confirmation prompts       
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'
           
            try {
                # Act & Assert: Ensure the function doesn't throw an exception
                { Remove-EntraRoleDefinition -Id "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
}        