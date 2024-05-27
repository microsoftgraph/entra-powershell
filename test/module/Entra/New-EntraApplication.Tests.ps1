BeforeAll {  
    if ((Get-Module -Name Microsoft.Graph.Entra) -eq $null) {
        Import-Module Microsoft.Graph.Entra    
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        # Write-Host "Mocking New-MgApplication with parameters: $($args | ConvertTo-Json -Depth 3)"
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
                "PublisherDomain"           = "aaaabbbbbccccc.onmicrosoft.com"
                "SignInAudience"            = "AzureADandPersonalMicrosoftAccount"
                "Web"                       = @{HomePageUrl = "https://localhost/demoapp"; ImplicitGrantSettings = ""; LogoutUrl = ""; }
                "Parameters"                = $args
            }
        )
    }

    Mock -CommandName New-MgApplication -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}

Describe "New-EntraApplication" {
    Context "Test for New-EntraApplication" {
        It "Should return created Application" {
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
        It "Should fail when DisplayName is empty" {
            { New-EntraApplication -DisplayName } | Should -Throw "Missing an argument for parameter 'DisplayName'.*"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraApplication"

            $result = New-EntraApplication -DisplayName "Mock-App"
            $params = Get-Parameters -data $result.Parameters
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }
    }
}