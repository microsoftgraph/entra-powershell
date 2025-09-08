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
              "Id"                           = "Google-OAUTH"
              "DisplayName"                  = "Mock-App"
              "AdditionalProperties"         = @{
                                                  "@odata.context"       = 'https://graph.microsoft.com/v1.0/`$metadata#identity/identityProviders/`$entity'
                                                  "@odata.type"          = "#microsoft.graph.socialIdentityProvider"
                                                  "clientId"             = "Google123"
                                                  "clientSecret"         = "******"
                                                  "identityProviderType" = "Google"
                                                }
              "Parameters"                   = $args
            }
        )
    }

    Mock -CommandName Get-MgIdentityProvider -MockWith $scriptblock -ModuleName Microsoft.Entra.SignIns
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("IdentityProvider.Read.All") } } -ModuleName Microsoft.Entra.SignIns
}

Describe "Get-EntraIdentityProvider" {
    Context "Test for Get-EntraIdentityProvider" {
        It "Should throw when not connected and not invoke SDK call" {
            Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.SignIns
            { Get-EntraIdentityProvider -IdentityProviderBaseId "Google-OAUTH"  } | Should -Throw "Not connected to Microsoft Graph*"
            Should -Invoke -CommandName Get-MgIdentityProvider -ModuleName Microsoft.Entra.SignIns -Times 0
        }

        It "Should return specific identity provider" {
            $result = Get-EntraIdentityProvider -IdentityProviderBaseId "Google-OAUTH" 
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "Google-OAUTH"
            $result.DisplayName | Should -Be "Mock-App"
            $result.identityProviderType | Should -Be "Google"

            Should -Invoke -CommandName Get-MgIdentityProvider  -ModuleName Microsoft.Entra.SignIns -Times 1
        }
        It "Should return specific identity provider with alias" {
            $result = Get-EntraIdentityProvider -IdentityProviderBaseId "Google-OAUTH" 
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "Google-OAUTH"
            $result.DisplayName | Should -Be "Mock-App"
            $result.identityProviderType | Should -Be "Google"

            Should -Invoke -CommandName Get-MgIdentityProvider  -ModuleName Microsoft.Entra.SignIns -Times 1
        }
        It "Should fail when Id is empty" {
            { Get-EntraIdentityProvider -IdentityProviderBaseId   } | Should -Throw "Missing an argument for parameter 'IdentityProviderBaseId'*"
        }
        It "Should fail when Id is invalid" {
            { Get-EntraIdentityProvider -IdentityProviderBaseId "" } | Should -Throw "Cannot bind argument to parameter 'IdentityProviderBaseId' because it is an empty string."
        }
        It "Result should Contain Alias properties" {
            $result = Get-EntraIdentityProvider -IdentityProviderBaseId "Google-OAUTH"
            $result.ObjectId | should -Be "Google-OAUTH"
            $result.Name | should -Be "Mock-App"
            $result.Type | should -Be "Google"
        }
        It "Should contain IdentityProviderBaseId in parameters when passed Id to it" {    
            
            $result = Get-EntraIdentityProvider -IdentityProviderBaseId "Google-OAUTH"
            $params = Get-Parameters -data $result.Parameters
            $params.IdentityProviderBaseId | Should -Be "Google-OAUTH"
        }
        It "Property parameter should work" {
            $result = Get-EntraIdentityProvider -IdentityProviderBaseId "Google-OAUTH" -Property DisplayName
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | Should -Be 'Mock-App'

            Should -Invoke -CommandName Get-MgIdentityProvider -ModuleName Microsoft.Entra.SignIns -Times 1
        }
        It "Should fail when Property is empty" {
             { Get-EntraIdentityProvider -IdentityProviderBaseId "Google-OAUTH" -Property } | Should -Throw "Missing an argument for parameter 'Property'*"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraIdentityProvider"

            Get-EntraIdentityProvider -IdentityProviderBaseId "Google-OAUTH"
            
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraIdentityProvider"

            Should -Invoke -CommandName Get-MgIdentityProvider -ModuleName Microsoft.Entra.SignIns -Times 1 -ParameterFilter {
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
                { Get-EntraIdentityProvider -IdentityProviderBaseId "Google-OAUTH" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
}   

