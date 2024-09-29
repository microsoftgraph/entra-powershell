# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Remove-MgServicePrincipalAppRoleAssignment -MockWith {} -ModuleName Microsoft.Graph.Entra
}
Describe "Remove-EntraServicePrincipalAppRoleAssignment" {
    Context "Test for Remove-EntraServicePrincipalAppRoleAssignment" {
        It "Should return empty object" {
            $result =  Remove-EntraServicePrincipalAppRoleAssignment -ObjectId "cc7fcc82-ac1b-4785-af47-2ca3b7052886"  -AppRoleAssignmentId "gsx_zBushUevRyyjtwUohm_RMYjcGsJIjXwKOVMr3ww"
            $result | Should -BeNullOrEmpty
            Should -Invoke -CommandName Remove-MgServicePrincipalAppRoleAssignment -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should fail when ObjectId is empty" {
            { Remove-EntraServicePrincipalAppRoleAssignment -ObjectId  -AppRoleAssignmentId "gsx_zBushUevRyyjtwUohm_RMYjcGsJIjXwKOVMr3ww"}| Should -Throw "Missing an argument for parameter 'ObjectId'.*"                
        } 
        It "Should fail when ObjectId is invalid" {
            { Remove-EntraServicePrincipalAppRoleAssignment -ObjectId "" -AppRoleAssignmentId "gsx_zBushUevRyyjtwUohm_RMYjcGsJIjXwKOVMr3ww" } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string.*"
        }
        It "Should fail when AppRoleAssignmentId is empty" {
            { Remove-EntraServicePrincipalAppRoleAssignment -ObjectId "cc7fcc82-ac1b-4785-af47-2ca3b7052886" -AppRoleAssignmentId }| Should -Throw "Missing an argument for parameter 'AppRoleAssignmentId'.*"                
        } 
        It "Should fail when AppRoleAssignmentId is invalid" {
            { Remove-EntraServicePrincipalAppRoleAssignment -ObjectId "cc7fcc82-ac1b-4785-af47-2ca3b7052886" -AppRoleAssignmentId "" } | Should -Throw "Cannot bind argument to parameter 'AppRoleAssignmentId' because it is an empty string.*"
        }
        It "Should contain ServicePrincipalId in parameters when passed ObjectId to it" {
            Mock -CommandName Remove-MgServicePrincipalAppRoleAssignment -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $result = Remove-EntraServicePrincipalAppRoleAssignment -ObjectId "cc7fcc82-ac1b-4785-af47-2ca3b7052886"  -AppRoleAssignmentId "gsx_zBushUevRyyjtwUohm_RMYjcGsJIjXwKOVMr3ww" 
            $params = Get-Parameters -data $result
            $params.ServicePrincipalId | Should -Be "cc7fcc82-ac1b-4785-af47-2ca3b7052886"
        
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraServicePrincipalAppRoleAssignment"
            $result = Remove-EntraServicePrincipalAppRoleAssignment -ObjectId "cc7fcc82-ac1b-4785-af47-2ca3b7052886"  -AppRoleAssignmentId "gsx_zBushUevRyyjtwUohm_RMYjcGsJIjXwKOVMr3ww" 
            $result | Should -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraServicePrincipalAppRoleAssignment"
            Should -Invoke -CommandName Remove-MgServicePrincipalAppRoleAssignment -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
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
                { Remove-EntraServicePrincipalAppRoleAssignment -ObjectId "cc7fcc82-ac1b-4785-af47-2ca3b7052886"  -AppRoleAssignmentId "gsx_zBushUevRyyjtwUohm_RMYjcGsJIjXwKOVMr3ww"  -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }   
    }
}