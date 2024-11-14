# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if ((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null) {
        Import-Module Microsoft.Graph.Entra.Beta      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        return @(
            [Microsoft.Graph.Beta.PowerShell.Models.MicrosoftGraphOAuth2PermissionGrant]@{
                "ClientId"    = "bbbbbbbb-1111-2222-3333-cccccccccccc"
                "ConsentType" = "AllPrincipals"
                "PrincipalId" = $null
                "ResourceId"  = "bbbbbbbb-1111-2222-3333-rrrrrrrrrrrr"
                "Scope"       = "DelegatedPermissionGrant.ReadWrite.All"
                "StartTime" = "2023-06-29T03:26:33"
                "ExpiryTime" = "2023-06-29T03:26:33"

            }
        )
    }
    
    Mock -CommandName Invoke-GraphRequest -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra.Beta
}
  
Describe "New-EntraBetaOauth2PermissionGrant" {
    Context "Test for New-EntraBetaOauth2PermissionGrant" {
        It "Should return created Oauth2PermissionGrant" {
            $startTime = Get-Date -Date "2023-06-29T03:26:33"
            $expiryTime = Get-Date -Date "2024-06-29T03:26:33"
            $result = New-EntraBetaOauth2PermissionGrant -ClientId "bbbbbbbb-1111-2222-3333-cccccccccccc" -ConsentType "AllPrincipals" -ResourceId "bbbbbbbb-1111-2222-3333-rrrrrrrrrrrr" -Scope "DelegatedPermissionGrant.ReadWrite.All" -StartTime $startTime -ExpiryTime $expiryTime
            $result | Should -Not -BeNullOrEmpty
            $result.ClientId | should -Be "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $result.ConsentType | should -Be "AllPrincipals"
            $result.ResourceId | should -Be "bbbbbbbb-1111-2222-3333-rrrrrrrrrrrr" 
            $result.Scope | should -Be "DelegatedPermissionGrant.ReadWrite.All" 

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should fail when ClientId is invalid" {
            { New-EntraBetaOauth2PermissionGrant -ClientId "" } | Should -Throw "Cannot bind argument to parameter 'ClientId'*"
        }
        It "Should fail when ClientId is empty" {
            { New-EntraBetaOauth2PermissionGrant -ClientId } | Should -Throw "Missing an argument for parameter 'ClientId'.*"
        }
        It "Should fail when ConsentType is invalid" {
            { New-EntraBetaOauth2PermissionGrant -ConsentType "" } | Should -Throw "Cannot bind argument to parameter 'ConsentType'*"
        }
        It "Should fail when ConsentType is empty" {
            { New-EntraBetaOauth2PermissionGrant -ConsentType } | Should -Throw "Missing an argument for parameter 'ConsentType'.*"
        }
        It "Should fail when ResourceId is invalid" {
            { New-EntraBetaOauth2PermissionGrant -ResourceId "" } | Should -Throw "Cannot bind argument to parameter 'ResourceId'*"
        }
        It "Should fail when ResourceId is empty" {
            { New-EntraBetaOauth2PermissionGrant -ResourceId } | Should -Throw "Missing an argument for parameter 'ResourceId'.*"
        }
        It "Should fail when StartTime is invalid" {
            { New-EntraBetaOauth2PermissionGrant -StartTime "" } | Should -Throw "Cannot process argument transformation on parameter 'StartTime'.*"
        }
        It "Should fail when StartTime is empty" {
            { New-EntraBetaOauth2PermissionGrant -StartTime } | Should -Throw "Missing an argument for parameter 'StartTime'.*"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraBetaOauth2PermissionGrant"
            $startTime = Get-Date -Date "2023-06-29T03:26:33"
            $expiryTime = Get-Date -Date "2024-06-29T03:26:33"
            $result= New-EntraBetaOauth2PermissionGrant -ClientId "bbbbbbbb-1111-2222-3333-cccccccccccc" -ConsentType "AllPrincipals" -ResourceId "bbbbbbbb-1111-2222-3333-rrrrrrrrrrrr" -Scope "DelegatedPermissionGrant.ReadWrite.All" -StartTime $startTime -ExpiryTime $expiryTime
            $result | Should -Not -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraBetaOauth2PermissionGrant"
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra.Beta -Times 1 -ParameterFilter {
                $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
                $true
            }
        }
        It "Should execute successfully without throwing an error " {
            $startTime = Get-Date -Date "2023-06-29T03:26:33"
            $expiryTime = Get-Date -Date "2024-06-29T03:26:33"

            # Disable confirmation prompts       
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'
    
            try {
                # Act & Assert: Ensure the function doesn't throw an exception
                { New-EntraBetaOauth2PermissionGrant -ClientId "bbbbbbbb-1111-2222-3333-cccccccccccc" -ConsentType "AllPrincipals" -ResourceId "bbbbbbbb-1111-2222-3333-rrrrrrrrrrrr" -Scope "DelegatedPermissionGrant.ReadWrite.All" -StartTime $startTime -ExpiryTime $expiryTime -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        } 
    }
}