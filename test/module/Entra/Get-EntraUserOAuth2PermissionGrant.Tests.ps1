# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra        
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        return @(
            [PSCustomObject]@{
                "ClientId"              = "00001111-aaaa-2222-bbbb-3333cccc4444"
                "ConsentType"           = "Principal"
                "Id"                    = "Aa1Bb2Cc3.-Dd4Ee5Ff6Gg7Hh8Ii9_~Jj0Kk1Ll2"
                "PrincipalId"           = "aaaaaaaa-bbbb-cccc-1111-222222222222"
                "ResourceId"            = "bbbbbbbb-cccc-dddd-2222-333333333333"
                "Scope"                 = "User.Read openid profile offline_access"
                "AdditionalProperties"  = @{}
                "Parameters"            = $args
            }
        )
    }
    Mock -CommandName Get-MgUserOAuth2PermissionGrant -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}
  
Describe "Get-EntraUserOAuth2PermissionGrant" {
    Context "Test for Get-EntraUserOAuth2PermissionGrant" {
        It "Should return specific UserOAuth2PermissionGrant" {
            $result = Get-EntraUserOAuth2PermissionGrant -ObjectId "aaaaaaaa-bbbb-cccc-1111-222222222222"
            $result | Should -Not -BeNullOrEmpty
            $result.PrincipalId | should -Contain 'aaaaaaaa-bbbb-cccc-1111-222222222222'
            $result.Id | Should -Contain 'Aa1Bb2Cc3.-Dd4Ee5Ff6Gg7Hh8Ii9_~Jj0Kk1Ll2'

            Should -Invoke -CommandName Get-MgUserOAuth2PermissionGrant -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should fail when ObjectId is empty" {
            { Get-EntraUserOAuth2PermissionGrant -ObjectId } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
        }

        It "Should fail when ObjectId is invalid" {
            { Get-EntraUserOAuth2PermissionGrant -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }

        It "Should return all User OAuth2Permission Grant" {
            $result = Get-EntraUserOAuth2PermissionGrant -ObjectId "aaaaaaaa-bbbb-cccc-1111-222222222222" -All
            $result | Should -Not -BeNullOrEmpty            
            
            Should -Invoke -CommandName Get-MgUserOAuth2PermissionGrant -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should fail when All has an argument" {
            { Get-EntraUserOAuth2PermissionGrant -ObjectId "aaaaaaaa-bbbb-cccc-1111-222222222222" -All $true } | Should -Throw "A positional parameter cannot be found that accepts argument 'True'.*"
        }      
        
        It "Should return top User OAuth2Permission Grant" {
            $result = Get-EntraUserOAuth2PermissionGrant -ObjectId "aaaaaaaa-bbbb-cccc-1111-222222222222" -Top 1
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgUserOAuth2PermissionGrant -ModuleName Microsoft.Graph.Entra -Times 1
        }  

        It "Should fail when top is empty" {
            { Get-EntraUserOAuth2PermissionGrant -ObjectId "aaaaaaaa-bbbb-cccc-1111-222222222222" -Top } | Should -Throw "Missing an argument for parameter 'Top'*"
        }  

        It "Should fail when top is invalid" {
            { Get-EntraUserOAuth2PermissionGrant -ObjectId "aaaaaaaa-bbbb-cccc-1111-222222222222" -Top XY } | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
        }  

        It "Result should Contain PrincipalId" {
            $result = Get-EntraUserOAuth2PermissionGrant -ObjectId "aaaaaaaa-bbbb-cccc-1111-222222222222"
            $result.PrincipalId | should -Contain "aaaaaaaa-bbbb-cccc-1111-222222222222"
        } 

        It "Should contain UserId in parameters when passed ObjectId to it" {
            $result = Get-EntraUserOAuth2PermissionGrant -ObjectId "aaaaaaaa-bbbb-cccc-1111-222222222222"
            $params = Get-Parameters -data $result.Parameters
            $params.UserId | Should -Be "aaaaaaaa-bbbb-cccc-1111-222222222222"
        }

        
        It "Property parameter should work" {
            $result = Get-EntraUserOAuth2PermissionGrant -ObjectId "aaaaaaaa-bbbb-cccc-1111-222222222222" -Property ConsentType 
            $result | Should -Not -BeNullOrEmpty
            $result.ConsentType | Should -Be "Principal"

            Should -Invoke -CommandName Get-MgUserOAuth2PermissionGrant -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should fail when Property is empty" {
             { Get-EntraUserOAuth2PermissionGrant -ObjectId "aaaaaaaa-bbbb-cccc-1111-222222222222" -Property } | Should -Throw "Missing an argument for parameter 'Property'*"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraUserOAuth2PermissionGrant"

            $result = Get-EntraUserOAuth2PermissionGrant -ObjectId "aaaaaaaa-bbbb-cccc-1111-222222222222"
            $result | Should -Not -BeNullOrEmpty

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraUserOAuth2PermissionGrant"

            Should -Invoke -CommandName Get-MgUserOAuth2PermissionGrant -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
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
                { Get-EntraUserOAuth2PermissionGrant -ObjectId "aaaaaaaa-bbbb-cccc-1111-222222222222" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }  

    }
}