# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.SignIns) -eq $null) {
        Import-Module Microsoft.Entra.SignIns
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    Mock -CommandName Remove-MgOAuth2PermissionGrant -MockWith {} -ModuleName Microsoft.Entra.SignIns
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @('DelegatedPermissionGrant.ReadWrite.All') } } -ModuleName Microsoft.Entra.SignIns
}

Describe "Remove-EntraGroupAppRoleAssignment" {
    Context "Test for Remove-EntraGroupAppRoleAssignment" {
        It "Should return empty object" {
            $result = Remove-EntraOAuth2PermissionGrant -OAuth2PermissionGrantId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgOAuth2PermissionGrant -ModuleName Microsoft.Entra.SignIns -Times 1
        }
        It "Should fail when OAuth2PermissionGrantId is empty" {
            { Remove-EntraOAuth2PermissionGrant -OAuth2PermissionGrantId } | Should -Throw "Missing an argument for parameter 'OAuth2PermissionGrantId'*"
        }  
        It "Should fail when OAuth2PermissionGrantId is invalid" {
            { Remove-EntraOAuth2PermissionGrant -OAuth2PermissionGrantId "" } | Should -Throw "Cannot bind argument to parameter 'OAuth2PermissionGrantId' because it is an empty string."
        }
        It "Should contain OAuth2PermissionGrantId in parameters when passed OAuth2PermissionGrantId to it" { 
            Mock -CommandName Remove-MgOAuth2PermissionGrant -MockWith { $args } -ModuleName Microsoft.Entra.SignIns

            $result = Remove-EntraOAuth2PermissionGrant -OAuth2PermissionGrantId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $params = Get-Parameters -data $result
            $params.OAuth2PermissionGrantId | Should -Be "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraOAuth2PermissionGrant"

            Remove-EntraOAuth2PermissionGrant -OAuth2PermissionGrantId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraOAuth2PermissionGrant"

            Should -Invoke -CommandName Remove-MgOAuth2PermissionGrant -ModuleName Microsoft.Entra.SignIns -Times 1 -ParameterFilter {
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
                { Remove-EntraOAuth2PermissionGrant -OAuth2PermissionGrantId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        } 
    }
}