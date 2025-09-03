# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Entra.SignIns) -eq $null){
        Import-Module Microsoft.Entra.SignIns      
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        return @(
            [PSCustomObject]@{
              "Id"                           = "00001111-aaaa-2222-bbbb-3333cccc4444"
              "ClientId"                     = "aaaaaaaa-bbbb-cccc-1111-222222222222"
              "PrincipalId"                  = $null
              "ResourceId"                   = "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
              "ConsentType"                  = "AllPrincipals"
              "Scope"                        = "Policy.Read.All Policy.ReadWrite.ConditionalAccess User.Read"
              "AdditionalProperties"         = @{}
              "Parameters"                   = $args
            }
        )
    }

    Mock -CommandName Get-MgOAuth2PermissionGrant -MockWith $scriptblock -ModuleName Microsoft.Entra.SignIns
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("Directory.Read.All") } } -ModuleName Microsoft.Entra.SignIns
}

Describe "Get-EntraOAuth2PermissionGrant" {
    Context "Test for Get-EntraOAuth2PermissionGrant" {
        It "Should throw when not connected and not invoke SDK call" {
            Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.SignIns
            { Get-EntraOAuth2PermissionGrant  } | Should -Throw "Not connected to Microsoft Graph*"
            Should -Invoke -CommandName Get-MgOAuth2PermissionGrant -ModuleName Microsoft.Entra.SignIns -Times 0
        }

        It "Should return OAuth2 Permission Grant" {
            $result = Get-EntraOAuth2PermissionGrant
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "00001111-aaaa-2222-bbbb-3333cccc4444"
            $result.ResourceId | Should -Be "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result.PrincipalId | Should -BeNullOrEmpty
            $result.ClientId | Should -Be "aaaaaaaa-bbbb-cccc-1111-222222222222"

            Should -Invoke -CommandName Get-MgOAuth2PermissionGrant  -ModuleName Microsoft.Entra.SignIns -Times 1
        }
        It "Should return All Group AppRole Assignment" {
            $result = Get-EntraOAuth2PermissionGrant -All
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "00001111-aaaa-2222-bbbb-3333cccc4444"
            $result.ResourceId | Should -Be "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result.PrincipalId | Should -BeNullOrEmpty
            $result.ClientId | Should -Be "aaaaaaaa-bbbb-cccc-1111-222222222222"


            Should -Invoke -CommandName Get-MgOAuth2PermissionGrant  -ModuleName Microsoft.Entra.SignIns -Times 1
        }
        It "Should fail when All is invalid" {
            { Get-EntraOAuth2PermissionGrant -All xyz } | Should -Throw "A positional parameter cannot be found that accepts argument 'xyz'.*"
        }
        It "Should return top 1 Group AppRole Assignment" {
            $result = Get-EntraOAuth2PermissionGrant -Top 1
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "00001111-aaaa-2222-bbbb-3333cccc4444"
            $result.ResourceId | Should -Be "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result.PrincipalId | Should -BeNullOrEmpty
            $result.ClientId | Should -Be "aaaaaaaa-bbbb-cccc-1111-222222222222"


            Should -Invoke -CommandName Get-MgOAuth2PermissionGrant  -ModuleName Microsoft.Entra.SignIns -Times 1
        }
        It "Should fail when Top is empty" {
            { Get-EntraOAuth2PermissionGrant -Top  } | Should -Throw "Missing an argument for parameter 'Top'*"
        }
        It "Should fail when Top is invalid" {
            { Get-EntraOAuth2PermissionGrant -Top xyz } | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
        }
        It "Result should Contain ObjectId" {
            $result = Get-EntraOAuth2PermissionGrant -Top 1
            $result.ObjectId | should -Be "00001111-aaaa-2222-bbbb-3333cccc4444"
        }
        It "Property parameter should work" {
            $result = Get-EntraOAuth2PermissionGrant -Property ConsentType
            $result | Should -Not -BeNullOrEmpty
            $result.ConsentType | Should -Be 'AllPrincipals'

            Should -Invoke -CommandName Get-MgOAuth2PermissionGrant -ModuleName Microsoft.Entra.SignIns -Times 1
        }
        It "Should fail when Property is empty" {
             { Get-EntraOAuth2PermissionGrant -Property } | Should -Throw "Missing an argument for parameter 'Property'*"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraOAuth2PermissionGrant"

            $result = Get-EntraOAuth2PermissionGrant -Top 1
            $result | Should -Not -BeNullOrEmpty

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraOAuth2PermissionGrant"

            Should -Invoke -CommandName Get-MgOAuth2PermissionGrant -ModuleName Microsoft.Entra.SignIns -Times 1 -ParameterFilter {
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
                { Get-EntraOAuth2PermissionGrant -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }

    }
}

