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
              "identityProviderType"         = "Google"
              "AdditionalProperties"         = @{
                                                  "@odata.context"       = "https://graph.microsoft.com/v1.0/`$metadata#identity/identityProviders/`$entity"
                                                  "@odata.type"          = "#microsoft.graph.socialIdentityProvider"
                                                  "clientId"             = "Google123"
                                                  "clientSecret"         = "******"
                                                }
              "Parameters"                   = $args
            }
        )
    }

    Mock -CommandName New-MgIdentityProvider -MockWith $scriptblock -ModuleName Microsoft.Entra.SignIns
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @('IdentityProvider.ReadWrite.All') } } -ModuleName Microsoft.Entra.SignIns
}

Describe "New-EntraIdentityProvider" {
    Context "Test for New-EntraIdentityProvider" {
        It "Should throw when not connected and not invoke SDK call" {
            Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.SignIns
            { New-EntraIdentityProvider -Type "Google" -Name "Mock-App" -ClientId "Google123" -ClientSecret "GoogleId" } | Should -Throw "Not connected to Microsoft Graph*"
            Should -Invoke -CommandName New-MgIdentityProvider -ModuleName Microsoft.Entra.SignIns -Times 0
        }

        It "Should return created identity provider" {
            $result = New-EntraIdentityProvider -Type "Google" -Name "Mock-App" -ClientId "Google123" -ClientSecret "GoogleId"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "Google-OAUTH"
            $result.DisplayName | Should -Be "Mock-App"
            $result.identityProviderType | Should -Be "Google"

            Should -Invoke -CommandName New-MgIdentityProvider  -ModuleName Microsoft.Entra.SignIns -Times 1
        }
        It "Should fail when Type is empty" {
            { New-EntraIdentityProvider -Type  -Name "Mock-App" -ClientId "Google123" -ClientSecret "GoogleId"  } | Should -Throw "Missing an argument for parameter 'Type'*"
        }
        It "Should fail when Type is invalid" {
            { New-EntraIdentityProvider -Type "" -Name "Mock-App" -ClientId "Google123" -ClientSecret "GoogleId" } | Should -Throw "Cannot bind argument to parameter 'Type' because it is an empty string."
        }
        It "Should fail when Name is empty" {
            { New-EntraIdentityProvider -Type "Google" -Name  -ClientId "Google123" -ClientSecret "GoogleId"  } | Should -Throw "Missing an argument for parameter 'Name'*"
        }
        It "Should fail when ClientId is empty" {
            { New-EntraIdentityProvider -Type "Google" -Name "Mock-App" -ClientId  -ClientSecret "GoogleId" } | Should -Throw "Missing an argument for parameter 'ClientId'*"
        }
        It "Should fail when ClientId is invalid" {
            { New-EntraIdentityProvider -Type "Google" -Name "Mock-App" -ClientId "" -ClientSecret "GoogleId" } | Should -Throw "Cannot bind argument to parameter 'ClientId' because it is an empty string."
        }
        It "Should fail when ClientSecret is empty" {
            { New-EntraIdentityProvider -Type "Google" -Name "Mock-App" -ClientId "Google123"  -ClientSecret  } | Should -Throw "Missing an argument for parameter 'ClientSecret'*"
        }
        It "Should fail when ClientSecret is invalid" {
            { New-EntraIdentityProvider -Type "Google" -Name "Mock-App" -ClientId "Google123" -ClientSecret "" } | Should -Throw "Cannot bind argument to parameter 'ClientSecret' because it is an empty string."
        }
        It "Result should contain Alias properties" {
            $result = New-EntraIdentityProvider -Type "Google" -Name "Mock-App" -ClientId "Google123" -ClientSecret "GoogleId"
            $result.ObjectId | should -Be "Google-OAUTH"
            $result.Name | should -Be "Mock-App"
            $result.Type | should -Be "Google"
        }
        It "Should contain displayName in parameters when passed Name to it" {    
            
            $result = New-EntraIdentityProvider -Type "Google" -Name "Mock-App" -ClientId "Google123" -ClientSecret "GoogleId"
            $params = Get-Parameters -data $result.Parameters
            $Para = $params | convertTo-json -depth 10 | convertFrom-json
            $Para.BodyParameter.displayName | Should -Be "Mock-App"
        }
        It "Should contain identityProviderType in parameters when passed Type to it" {    
            
            $result = New-EntraIdentityProvider -Type "Google" -Name "Mock-App" -ClientId "Google123" -ClientSecret "GoogleId"
            $Param= $result.Parameters | convertTo-json -depth 10 | convertFrom-json
            $params = Get-Parameters -data $Param
            $Para = $params | convertTo-json -depth 10 | convertFrom-json
            $Para.BodyParameter.AdditionalProperties.identityProviderType | Should -Be "Google"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraIdentityProvider"

            New-EntraIdentityProvider -Type "Google" -Name "Mock-App" -ClientId "Google123" -ClientSecret "GoogleId"
            
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraIdentityProvider"

            Should -Invoke -CommandName New-MgIdentityProvider -ModuleName Microsoft.Entra.SignIns -Times 1 -ParameterFilter {
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
                { New-EntraIdentityProvider -Type "Google" -Name "Mock-App" -ClientId "Google123" -ClientSecret "GoogleId" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
}

