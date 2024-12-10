# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if ((Get-Module -Name Microsoft.Graph.Entra) -eq $null) {
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        return @(
            [Microsoft.Graph.PowerShell.Models.MicrosoftGraphOAuth2PermissionGrant]@{
                "ClientId"    = "bbbbbbbb-1111-2222-3333-cccccccccccc"
                "ConsentType" = "AllPrincipals"
                "PrincipalId" = $null
                "ResourceId"  = "bbbbbbbb-1111-2222-3333-rrrrrrrrrrrr"
                "Scope"       = "DelegatedPermissionGrant.ReadWrite.All"
            }
        )
    }
    
    Mock -CommandName Invoke-GraphRequest -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}
  
Describe "New-EntraOauth2PermissionGrant" {
    Context "Test for New-EntraOauth2PermissionGrant" {
        It "Should return created Oauth2PermissionGrant" {
            $result = New-EntraOauth2PermissionGrant -ClientId "bbbbbbbb-1111-2222-3333-cccccccccccc" -ConsentType "AllPrincipals" -ResourceId "bbbbbbbb-1111-2222-3333-rrrrrrrrrrrr" -Scope "DelegatedPermissionGrant.ReadWrite.All"
            $result | Should -Not -BeNullOrEmpty
            $result.ClientId | should -Be "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $result.ConsentType | should -Be "AllPrincipals"
            $result.ResourceId | should -Be "bbbbbbbb-1111-2222-3333-rrrrrrrrrrrr" 
            $result.Scope | should -Be "DelegatedPermissionGrant.ReadWrite.All" 

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when ClientId is invalid" {
            { New-EntraOauth2PermissionGrant -ClientId "" } | Should -Throw "Cannot bind argument to parameter 'ClientId'*"
        }
        It "Should fail when ClientId is empty" {
            { New-EntraOauth2PermissionGrant -ClientId } | Should -Throw "Missing an argument for parameter 'ClientId'.*"
        }
        It "Should fail when ConsentType is invalid" {
            { New-EntraOauth2PermissionGrant -ConsentType "" } | Should -Throw "Cannot bind argument to parameter 'ConsentType'*"
        }
        It "Should fail when ConsentType is empty" {
            { New-EntraOauth2PermissionGrant -ConsentType } | Should -Throw "Missing an argument for parameter 'ConsentType'.*"
        }
        It "Should fail when ResourceId is invalid" {
            { New-EntraOauth2PermissionGrant -ResourceId "" } | Should -Throw "Cannot bind argument to parameter 'ResourceId'*"
        }
        It "Should fail when ResourceId is empty" {
            { New-EntraOauth2PermissionGrant -ResourceId } | Should -Throw "Missing an argument for parameter 'ResourceId'.*"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraOauth2PermissionGrant"
            $result = New-EntraOauth2PermissionGrant -ClientId "bbbbbbbb-1111-2222-3333-cccccccccccc" -ConsentType "AllPrincipals" -ResourceId "bbbbbbbb-1111-2222-3333-rrrrrrrrrrrr" -Scope "DelegatedPermissionGrant.ReadWrite.All"
            $result | Should -Not -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraOauth2PermissionGrant"
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
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
                { New-EntraOauth2PermissionGrant -ClientId "bbbbbbbb-1111-2222-3333-cccccccccccc" -ConsentType "AllPrincipals" -ResourceId "bbbbbbbb-1111-2222-3333-rrrrrrrrrrrr" -Scope "DelegatedPermissionGrant.ReadWrite.All" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }   
    }
}