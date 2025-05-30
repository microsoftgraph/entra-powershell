# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.Applications) -eq $null) {
        Import-Module Microsoft.Entra.Applications
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    Mock -CommandName Remove-MgServicePrincipalAppRoleAssignment -MockWith {} -ModuleName Microsoft.Entra.Applications
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("AppRoleAssignment.ReadWrite.All") } } -ModuleName Microsoft.Entra.Applications
}
Describe "Remove-EntraServicePrincipalAppRoleAssignment" {
    Context "Test for Remove-EntraServicePrincipalAppRoleAssignment" {
        It "Should return empty ServicePrincipalId" {
            $result = Remove-EntraServicePrincipalAppRoleAssignment -ServicePrincipalId "cc7fcc82-ac1b-4785-af47-2ca3b7052886" -AppRoleAssignmentId "gsx_zBushUevRyyjtwUohm_RMYjcGsJIjXwKOVMr3ww"
            $result | Should -BeNullOrEmpty
            Should -Invoke -CommandName Remove-MgServicePrincipalAppRoleAssignment -ModuleName Microsoft.Entra.Applications -Times 1
        }
        It "Should execute successfully with Alias" {
            $result = Remove-EntraServicePrincipalAppRoleAssignment -ObjectId "cc7fcc82-ac1b-4785-af47-2ca3b7052886" -AppRoleAssignmentId "gsx_zBushUevRyyjtwUohm_RMYjcGsJIjXwKOVMr3ww"
            $result | Should -BeNullOrEmpty
            Should -Invoke -CommandName Remove-MgServicePrincipalAppRoleAssignment -ModuleName Microsoft.Entra.Applications -Times 1
        }

        It "Should fail when ServicePrincipalId is empty" {
            { Remove-EntraServicePrincipalAppRoleAssignment -ServicePrincipalId -AppRoleAssignmentId "gsx_zBushUevRyyjtwUohm_RMYjcGsJIjXwKOVMr3ww" } | Should -Throw "Missing an argument for parameter 'ServicePrincipalId'.*"                
        } 
        It "Should fail when ServicePrincipalId is invalid" {
            { Remove-EntraServicePrincipalAppRoleAssignment -ServicePrincipalId "" -AppRoleAssignmentId "gsx_zBushUevRyyjtwUohm_RMYjcGsJIjXwKOVMr3ww" } | Should -Throw "Cannot validate argument on parameter 'ServicePrincipalId'. The argument is null or empty. Provide an argument that is not null or empty, and then try the command again."
        }
        It "Should fail when AppRoleAssignmentId is empty" {
            { Remove-EntraServicePrincipalAppRoleAssignment -ServicePrincipalId "cc7fcc82-ac1b-4785-af47-2ca3b7052886" -AppRoleAssignmentId } | Should -Throw "Missing an argument for parameter 'AppRoleAssignmentId'.*"                
        } 
        It "Should fail when AppRoleAssignmentId is invalid" {
            { Remove-EntraServicePrincipalAppRoleAssignment -ServicePrincipalId "cc7fcc82-ac1b-4785-af47-2ca3b7052886" -AppRoleAssignmentId "" } | Should -Throw "Cannot validate argument on parameter 'AppRoleAssignmentId'. The argument is null or empty. Provide an argument that is not null or empty, and then try the command again."
        }
        It "Should contain ServicePrincipalId in parameters when passed ServicePrincipalId to it" {
            Mock -CommandName Remove-MgServicePrincipalAppRoleAssignment -MockWith { $args } -ModuleName Microsoft.Entra.Applications

            $result = Remove-EntraServicePrincipalAppRoleAssignment -ServicePrincipalId "cc7fcc82-ac1b-4785-af47-2ca3b7052886" -AppRoleAssignmentId "gsx_zBushUevRyyjtwUohm_RMYjcGsJIjXwKOVMr3ww" 
            $params = Get-Parameters -data $result
            $params.ServicePrincipalId | Should -Be "cc7fcc82-ac1b-4785-af47-2ca3b7052886"
        
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraServicePrincipalAppRoleAssignment"
            Remove-EntraServicePrincipalAppRoleAssignment -ServicePrincipalId "cc7fcc82-ac1b-4785-af47-2ca3b7052886" -AppRoleAssignmentId "gsx_zBushUevRyyjtwUohm_RMYjcGsJIjXwKOVMr3ww"
            Should -Invoke -CommandName Remove-MgServicePrincipalAppRoleAssignment -ModuleName Microsoft.Entra.Applications -Times 1 -ParameterFilter {
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
                { Remove-EntraServicePrincipalAppRoleAssignment -ServicePrincipalId "cc7fcc82-ac1b-4785-af47-2ca3b7052886" -AppRoleAssignmentId "gsx_zBushUevRyyjtwUohm_RMYjcGsJIjXwKOVMr3ww" -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
}
