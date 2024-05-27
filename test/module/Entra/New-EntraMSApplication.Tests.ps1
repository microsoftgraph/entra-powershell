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
                "IsFallbackPublicClient"    = $True
                "KeyCredentials"            = @{CustomKeyIdentifier = @(211, 174, 247); DisplayName = ""; Key = ""; KeyId = "d903c7a3-75ea-4772-8935-5c0cf82068a7"; Type = "Symmetric"; Usage = "Sign" }
                "OptionalClaims"            = @{AccessToken = ""; IdToken = ""; Saml2Token = "" }
                "ParentalControlSettings"   = @{CountriesBlockedForMinors = $null; LegalAgeGroupRule = "Allow" }
                "PasswordCredentials"       = @{}
                "AddIns"                    = @{}
                "Logo"                      = $null
                "AppRoles"                  = $null
                "GroupMembershipClaims"     = $null
                "IdentifierUris"            = $null
                "Oauth2RequirePostResponse" = $null
                "Api"                       = @{AcceptMappedClaims = $null; KnownClientApplications = $null; Oauth2PermissionScopes = $null;
                    PreAuthorizedApplications = $null; RequestedAccessTokenVersion = 2; AdditionalProperties = $null
                }
                "PublicClient"              = @{RedirectUris = $null }
                "RequiredResourceAccess"    = $false
                "PublisherDomain"           = "aaaabbbbbcccc.onmicrosoft.com"
                "SignInAudience"            = "AzureADandPersonalMicrosoftAccount"
                "Web"                       = @{HomePageUrl = "https://localhost/demoapp"; ImplicitGrantSettings = ""; LogoutUrl = ""; }
                "AdditionalProperties"      = @{Context = "application" }
                "Parameters"                = $args
            }
        )
    }

    Mock -CommandName New-MgApplication -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}

Describe "New-EntraMSApplication" {
    Context "Test for New-EntraMSApplication" {
        It "Should return created Application" {
            $result = New-EntraMSApplication -DisplayName "Mock-App"
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | should -Be "Mock-App"
            $result.IsDeviceOnlyAuthSupported | should -Be "True"
            $result.IsFallbackPublicClient | should -Be "True"
            $result.SignInAudience | should -Be "AzureADandPersonalMicrosoftAccount" 

            Should -Invoke -CommandName New-MgApplication -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when DisplayName is empty" {
            { New-EntraMSApplication -DisplayName "" } | Should -Throw "Cannot bind argument to parameter 'DisplayName' because it is an empty string."
        }
        It "Should fail when DisplayName is empty" {
            { New-EntraMSApplication -DisplayName } | Should -Throw "Missing an argument for parameter 'DisplayName'.*"
        }
        It "Result should Contain ObjectId" {            
            $result = New-EntraMSApplication -DisplayName "Mock-App"
            $result.ObjectId | should -Be "bbbbbbbb-1111-2222-3333-cccccccccccc"
        } 
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraMSApplication"

            $result = New-EntraMSApplication -DisplayName "Mock-App"
            $params = Get-Parameters -data $result.Parameters
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }
    }
}