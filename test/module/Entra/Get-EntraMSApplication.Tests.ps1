BeforeAll {  
    if ((Get-Module -Name Microsoft.Graph.Entra) -eq $null) {
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        # Write-Host "Mocking Get-MgApplication with parameters: $($args | ConvertTo-Json -Depth 3)"
        return @(
            [PSCustomObject]@{
                "AppId"                     = "aaaaaaaa-1111-2222-3333-cccccccccccc"
                "DeletedDateTime"           = $null
                "Id"                        = "bbbbbbbb-1111-2222-3333-cccccccccccc"
                "DisplayName"               = "Mock-App"
                "Info"                      = @{LogoUrl = ""; MarketingUrl = ""; PrivacyStatementUrl = ""; SupportUrl = ""; TermsOfServiceUrl = "" }
                "IsDeviceOnlyAuthSupported" = $True
                "IsFallbackPublicClient"    = $true
                "KeyCredentials"            = @{CustomKeyIdentifier = @(211, 174, 247); DisplayName = ""; Key = ""; KeyId = "pppppppp-1111-2222-3333-cccccccccccc"; Type = "Symmetric"; Usage = "Sign" }
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
                "PublisherDomain"           = "aaaabbbbbccccc.onmicrosoft.com"
                "SignInAudience"            = "AzureADandPersonalMicrosoftAccount"
                "Web"                       = @{HomePageUrl = "https://localhost/demoapp"; ImplicitGrantSettings = ""; LogoutUrl = ""; }
                "Parameters"                = $args
            }
        )
    }

    Mock -CommandName Get-MgApplication -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}
  
Describe "Get-EntraMSApplication" {
    Context "Test for Get-EntraMSApplication" {
        It "Should return specific application" {
            $result = Get-EntraMSApplication -ObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be @('bbbbbbbb-1111-2222-3333-cccccccccccc')

            Should -Invoke -CommandName Get-MgApplication  -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when ObjectId is invalid" {
            { Get-EntraMSApplication -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }
        It "Should fail when ObjectId is empty" {
            { Get-EntraMSApplication -ObjectId } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
        }
        It "Should fail when searchstring is empty" {
            { Get-EntraMSApplication -SearchString } | Should -Throw "Missing an argument for parameter 'SearchString'*"
        } 
        It "Should fail when filter is empty" {
            { Get-EntraMSApplication -Filter } | Should -Throw "Missing an argument for parameter 'Filter'*"
        }
        It "Should fail when Top is empty" {
            { Get-EntraMSApplication -Top } | Should -Throw "Missing an argument for parameter 'Top'*"
        }
        It "Should fail when Top is invalid" {
            { Get-EntraMSApplication -Top XY } | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
        }
        It "Should return all applications" {
            $result = Get-EntraMSApplication -All
            $result | Should -Not -BeNullOrEmpty     
            
            Should -Invoke -CommandName Get-MgApplication  -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when All has an argument" {
            { Get-EntraMSApplication -All $true } | Should -Throw "A positional parameter cannot be found that accepts argument 'True'.*"
        }           
        It "Should return specific application by searchstring" {
            $result = Get-EntraMSApplication -SearchString 'Mock-App'
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | should -Be 'Mock-App'

            Should -Invoke -CommandName Get-MgApplication  -ModuleName Microsoft.Graph.Entra -Times 1
        } 
        It "Should return specific application by filter" {
            $result = Get-EntraMSApplication -Filter "DisplayName -eq 'Mock-App'"
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | should -Be 'Mock-App'

            Should -Invoke -CommandName Get-MgApplication  -ModuleName Microsoft.Graph.Entra -Times 1
        }  
        It "Should return top application" {
            $result = @(Get-EntraMSApplication -Top 1)
            $result | Should -Not -BeNullOrEmpty
            $result | Should -HaveCount 1 

            Should -Invoke -CommandName Get-MgApplication  -ModuleName Microsoft.Graph.Entra -Times 1
        }  
        It "Result should Contain ObjectId" {            
            $result = Get-EntraMSApplication -ObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $result.ObjectId | should -Be "bbbbbbbb-1111-2222-3333-cccccccccccc"
        }     
        It "Should contain ApplicationId in parameters when passed ObjectId to it" {    
            $result = Get-EntraMSApplication -ObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $params = Get-Parameters -data $result.Parameters
            $params.ApplicationId | Should -Be "bbbbbbbb-1111-2222-3333-cccccccccccc"
        }
        It "Should contain Filter in parameters when passed SearchString to it" {               
            $result = Get-EntraMSApplication -SearchString 'Mock-App'
            $params = Get-Parameters -data $result.Parameters
            $params.Filter | Should -Match "Mock-App"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraMSApplication"

            $result = Get-EntraMSApplication -SearchString 'Mock-App'
            $params = Get-Parameters -data $result.Parameters
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }
    }
}