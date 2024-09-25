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
              "AppId"                     = "aaaaaaaa-1111-2222-3333-cccccccccccc"
              "DeletedDateTime"           = $null
              "Id"                        = "bbbbbbbb-1111-2222-3333-cccccccccccc"
              "DisplayName"               = "Mock-App"
              "Info"                      = @{LogoUrl = ""; MarketingUrl = ""; PrivacyStatementUrl = ""; SupportUrl = ""; TermsOfServiceUrl = "" }
              "IsDeviceOnlyAuthSupported" = $True
              "IsFallbackPublicClient"    = $true
              "KeyCredentials"            = @{CustomKeyIdentifier = @(211, 174, 247); DisplayName = ""; Key = ""; KeyId = "d903c7a3-75ea-4772-8935-5c0cf82068a7"; Type = "Symmetric"; Usage = "Sign" }
              "OptionalClaims"            = @{AccessToken = ""; IdToken = ""; Saml2Token = "" }
              "ParentalControlSettings"   = @{CountriesBlockedForMinors = $null; LegalAgeGroupRule = "Allow" }
              "PasswordCredentials"       = @{}
              "PublicClient"              = @{RedirectUris = $null }
              "PublisherDomain"           = "aaaabbbbbccccc.contoso.com"
              "SignInAudience"            = "AzureADandPersonalMicrosoftAccount"
              "Web"                       = @{HomePageUrl = "https://localhost/demoapp"; ImplicitGrantSettings = ""; LogoutUrl = ""; }              
              "AdditionalProperties" = @{CountriesBlockedForMinors = $null; LegalAgeGroupRule = "Allow" }
            }
        )
    }

    Mock -CommandName New-MgApplication -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}

Describe "New-EntraApplication"{
    Context "Test for New-EntraApplication" {
        It "Should return created Application"{
            $result = New-EntraApplication -DisplayName "Mock-App"
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | should -Be "Mock-App"
            $result.IsDeviceOnlyAuthSupported | should -Be "True"
            $result.IsFallbackPublicClient | should -Be "True"
            $result.SignInAudience | should -Be "AzureADandPersonalMicrosoftAccount" 

            Should -Invoke -CommandName New-MgApplication -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when DisplayName is empty" {
            { New-EntraApplication -DisplayName "" } | Should -Throw "Cannot bind argument to parameter 'DisplayName' because it is an empty string."
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraApplication"
            $result = New-EntraApplication -DisplayName "Mock-App"
            $result | Should -Not -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraApplication"
            Should -Invoke -CommandName New-MgApplication -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
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
                { New-EntraApplication -DisplayName "Mock-App" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }   
    }
}