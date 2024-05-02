BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        return @(
            [PSCustomObject]@{
              "Id"                           = "Google-OAUTH"
              "DisplayName"                  = "Mock-App"
              "identityProviderType"         = "Google"
              "AdditionalProperties"         = @{
                                                  "@odata.context"       = "https://graph.microsoft.com/v1.0/$metadata#identity/identityProviders/$entity"
                                                  "@odata.type"          = "#microsoft.graph.socialIdentityProvider"
                                                  "clientId"             = "Google123"
                                                  "clientSecret"         = "******"
                                                }
              "Parameters"                   = $args
            }
        )
    }

    Mock -CommandName New-MgIdentityProvider -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}

Describe "New-EntraMSIdentityProvider" {
Context "Test for New-EntraMSIdentityProvider" {
        It "Should return created Ms identity provider" {
            $result = New-EntraMSIdentityProvider -Type "Google" -Name "Mock-App" -ClientId "Google123" -ClientSecret "GoogleId"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "Google-OAUTH"
            $result.DisplayName | Should -Be "Mock-App"
            $result.identityProviderType | Should -Be "Google"

            Should -Invoke -CommandName New-MgIdentityProvider  -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when Type is empty" {
            { New-EntraMSIdentityProvider -Type  -Name "Mock-App" -ClientId "Google123" -ClientSecret "GoogleId"  } | Should -Throw "Missing an argument for parameter 'Type'*"
        }
        It "Should fail when Type is invalid" {
            { New-EntraMSIdentityProvider -Type "" -Name "Mock-App" -ClientId "Google123" -ClientSecret "GoogleId" } | Should -Throw "Cannot bind argument to parameter 'Type' because it is an empty string."
        }
        It "Should fail when Name is empty" {
            { New-EntraMSIdentityProvider -Type "Google" -Name  -ClientId "Google123" -ClientSecret "GoogleId"  } | Should -Throw "Missing an argument for parameter 'Name'*"
        }
        It "Should fail when ClientId is empty" {
            { New-EntraMSIdentityProvider -Type "Google" -Name "Mock-App" -ClientId  -ClientSecret "GoogleId" } | Should -Throw "Missing an argument for parameter 'ClientId'*"
        }
        It "Should fail when ClientId is invalid" {
            { New-EntraMSIdentityProvider -Type "Google" -Name "Mock-App" -ClientId "" -ClientSecret "GoogleId" } | Should -Throw "Cannot bind argument to parameter 'ClientId' because it is an empty string."
        }
        It "Should fail when ClientSecret is empty" {
            { New-EntraMSIdentityProvider -Type "Google" -Name "Mock-App" -ClientId "Google123"  -ClientSecret  } | Should -Throw "Missing an argument for parameter 'ClientSecret'*"
        }
        It "Should fail when ClientSecret is invalid" {
            { New-EntraMSIdentityProvider -Type "Google" -Name "Mock-App" -ClientId "Google123" -ClientSecret "" } | Should -Throw "Cannot bind argument to parameter 'ClientSecret' because it is an empty string."
        }
        It "Result should Contain ObjectId" {
            $result = New-EntraMSIdentityProvider -Type "Google" -Name "Mock-App" -ClientId "Google123" -ClientSecret "GoogleId"
            $result.ObjectId | should -Be "Google-OAUTH"
        }
        It "Result should Contain Name" {
            $result = New-EntraMSIdentityProvider -Type "Google" -Name "Mock-App" -ClientId "Google123" -ClientSecret "GoogleId"
            $result.Name | should -Be "Mock-App"
        }
        It "Result should Contain Type" {
            $result = New-EntraMSIdentityProvider -Type "Google" -Name "Mock-App" -ClientId "Google123" -ClientSecret "GoogleId"
            $result.Type | should -Be "Google"
        }
            # Testcase failed not found params value
        # It "Should contain identityProviderType in parameters when passed Type to it" {    
            
        #     $result = New-EntraMSIdentityProvider -Type "Google" -Name "Mock-App" -ClientId "Google123" -ClientSecret "GoogleId"
        #     $params = Get-Parameters -data $result.Parameters
            # Write-host $params
            # $params = Get-Parameters -data $result.Parameters
            # $Para = $params | convertTo-json -depth 10 | convertFrom-json
            #  Write-host $Para.BodyParameter
            # $Para.BodyParameter.identityProviderType | Should -Be "Google"
        # }
        It "Should contain displayName in parameters when passed Name to it" {    
            
            $result = New-EntraMSIdentityProvider -Type "Google" -Name "Mock-App" -ClientId "Google123" -ClientSecret "GoogleId"
            $params = Get-Parameters -data $result.Parameters
            $Para = $params | convertTo-json -depth 10 | convertFrom-json
            $Para.BodyParameter.displayName | Should -Be "Mock-App"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraMSIdentityProvider"

            $result = New-EntraMSIdentityProvider -Type "Google" -Name "Mock-App" -ClientId "Google123" -ClientSecret "GoogleId"
            $params = Get-Parameters -data $result.Parameters
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }


    }

}