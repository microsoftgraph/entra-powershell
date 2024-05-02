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
        
        It "Should contain displayName in parameters when passed Name to it" {    
            
            $result = New-EntraMSIdentityProvider -Type "Google" -Name "Mock-App" -ClientId "Google123" -ClientSecret "GoogleId"
            $params = Get-Parameters -data $result.Parameters
            $Para = $params | convertTo-json -depth 10 | convertFrom-json
            # $Para.BodyParameter.AdditionalProperties | Should -Be "Mock-App"
        }
        # It "Should contain 'User-Agent' header" {
        #     $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraMSIdentityProvider"

        #     $result = New-EntraMSIdentityProvider -Type "Google" -Name "Mock-App" -ClientId "Google123" -ClientSecret "GoogleId"
        #     $params = Get-Parameters -data $result.Parameters
        #     $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        # }


    }

}