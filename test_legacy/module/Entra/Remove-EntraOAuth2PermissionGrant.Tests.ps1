# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra
    }
    Import-Module .\test_legacy\module\Common-Functions.ps1 -Force

    Mock -CommandName Remove-MgOAuth2PermissionGrant -MockWith {} -ModuleName Microsoft.Graph.Entra
}

Describe "Remove-EntraGroupAppRoleAssignment" {
    Context "Test for Remove-EntraGroupAppRoleAssignment" {
        It "Should return empty object" {
            $result = Remove-EntraOAuth2PermissionGrant -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgOAuth2PermissionGrant -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when ObjectId is empty" {
            { Remove-EntraOAuth2PermissionGrant -ObjectId  } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
        }  
        It "Should fail when ObjectId is invalid" {
            { Remove-EntraOAuth2PermissionGrant -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }
        It "Should contain OAuth2PermissionGrantId in parameters when passed ObjectId to it" { 
            Mock -CommandName Remove-MgOAuth2PermissionGrant -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $result = Remove-EntraOAuth2PermissionGrant -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $params = Get-Parameters -data $result
            $params.OAuth2PermissionGrantId | Should -Be "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraOAuth2PermissionGrant"

            Remove-EntraOAuth2PermissionGrant -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraOAuth2PermissionGrant"

            Should -Invoke -CommandName Remove-MgOAuth2PermissionGrant -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
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
                { Remove-EntraOAuth2PermissionGrant -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        } 
    }
}