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
              "AdditionalProperties"         = @{
                                                  "@odata.context"       = "https://graph.microsoft.com/v1.0/$metadata#identity/identityProviders/$entity"
                                                  "@odata.type"          = "#microsoft.graph.socialIdentityProvider"
                                                  "clientId"             = "Google123"
                                                  "clientSecret"         = "******"
                                                  "identityProviderType" = "Google"
                                                }
              "Parameters"                   = $args
            }
        )
    }

    Mock -CommandName Get-MgIdentityProvider -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}

Describe "Get-EntraMSIdentityProvider" {
Context "Test for Get-EntraMSIdentityProvider" {
        It "Should return specific Ms identity provider" {
            $result = Get-EntraMSIdentityProvider -Id "Google-OAUTH" 
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "Google-OAUTH"
            $result.DisplayName | Should -Be "Mock-App"
            $result.identityProviderType | Should -Be "Google"

            Should -Invoke -CommandName Get-MgIdentityProvider  -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when Id is empty" {
            { Get-EntraMSIdentityProvider -Id   } | Should -Throw "Missing an argument for parameter 'Id'*"
        }
        It "Should fail when Id is invalid" {
            { Get-EntraMSIdentityProvider -Id "" } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string."
        }
        It "Result should Contain ObjectId" {
            $result = Get-EntraMSIdentityProvider -Id "Google-OAUTH"
            $result.ObjectId | should -Be "Google-OAUTH"
        }
        It "Result should Contain Name" {
            $result = Get-EntraMSIdentityProvider -Id "Google-OAUTH"
            $result.Name | should -Be "Mock-App"
        }
        It "Result should Contain Type" {
            $result = Get-EntraMSIdentityProvider -Id "Google-OAUTH"
            $result.Type | should -Be "Google"
        }
        It "Should contain IdentityProviderBaseId in parameters when passed Id to it" {    
            
            $result = Get-EntraMSIdentityProvider -Id "Google-OAUTH"
            $params = Get-Parameters -data $result.Parameters
            $params.IdentityProviderBaseId | Should -Be "Google-OAUTH"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraMSIdentityProvider"

            $result = Get-EntraMSIdentityProvider -Id "Google-OAUTH"
            $params = Get-Parameters -data $result.Parameters
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }




    }
}   