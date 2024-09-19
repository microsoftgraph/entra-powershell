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
Describe "Remove-EntraServiceAppRoleAssignment" {
    Context "Test for Remove-EntraServiceAppRoleAssignment" {
        It "Should return empty object" {
            $result =  Remove-EntraServiceAppRoleAssignment -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"  -AppRoleAssignmentId "A1bC2dE3fH4iJ5kL6mN7oP8qR9sT0u"
            $result | Should -BeNullOrEmpty
            Should -Invoke -CommandName Remove-MgServicePrincipalAppRoleAssignment -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should fail when ObjectId is empty" {
            { Remove-EntraServiceAppRoleAssignment -ObjectId  -AppRoleAssignmentId "A1bC2dE3fH4iJ5kL6mN7oP8qR9sT0u"}| Should -Throw "Missing an argument for parameter 'ObjectId'.*"                
        } 
        It "Should fail when ObjectId is invalid" {
            { Remove-EntraServiceAppRoleAssignment -ObjectId "" -AppRoleAssignmentId "A1bC2dE3fH4iJ5kL6mN7oP8qR9sT0u" } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string.*"
        }
        It "Should fail when AppRoleAssignmentId is empty" {
            { Remove-EntraServiceAppRoleAssignment -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -AppRoleAssignmentId }| Should -Throw "Missing an argument for parameter 'AppRoleAssignmentId'.*"                
        } 
        It "Should fail when AppRoleAssignmentId is invalid" {
            { Remove-EntraServiceAppRoleAssignment -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -AppRoleAssignmentId "" } | Should -Throw "Cannot bind argument to parameter 'AppRoleAssignmentId' because it is an empty string.*"
        }
        It "Should contain ServicePrincipalId in parameters when passed ObjectId to it" {
            Mock -CommandName Remove-MgServicePrincipalAppRoleAssignment -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $result = Remove-EntraServiceAppRoleAssignment -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"  -AppRoleAssignmentId "A1bC2dE3fH4iJ5kL6mN7oP8qR9sT0u" 
            $params = Get-Parameters -data $result
            $params.ServicePrincipalId | Should -Be "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
        
        }
        
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraServiceAppRoleAssignment"

            Remove-EntraServiceAppRoleAssignment -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -AppRoleAssignmentId "A1bC2dE3fH4iJ5kL6mN7oP8qR9sT0u" 
      
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraServiceAppRoleAssignment"

            Should -Invoke -CommandName Remove-MgServicePrincipalAppRoleAssignment -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
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
                { Remove-EntraServiceAppRoleAssignment -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"  -AppRoleAssignmentId "A1bC2dE3fH4iJ5kL6mN7oP8qR9sT0u" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }   
    }
}