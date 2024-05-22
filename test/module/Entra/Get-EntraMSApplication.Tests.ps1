BeforeAll {  
    if ((Get-Module -Name Microsoft.Graph.Entra) -eq $null) {
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        # Write-Host "Mocking Get-MgApplication with parameters: $($args | ConvertTo-Json -Depth 3)"
        return @(
            [PSCustomObject]@{
                "AppId"                     = "5f783237-3457-45d8-93e7-a0edb1cfbfd1"
                "DeletedDateTime"           = $null
                "Id"                        = "111cc9b5-fce9-485e-9566-c68debafac5f"
                "DisplayName"               = "Mock-App"
                "Info"                      = @{LogoUrl = ""; MarketingUrl = ""; PrivacyStatementUrl = ""; SupportUrl = ""; TermsOfServiceUrl = "" }
                "IsDeviceOnlyAuthSupported" = $True
                "IsFallbackPublicClient"    = $true
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
                "PublisherDomain"           = "M365x99297270.onmicrosoft.com"
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
            $result = Get-EntraMSApplication -ObjectId "111cc9b5-fce9-485e-9566-c68debafac5f"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be @('111cc9b5-fce9-485e-9566-c68debafac5f')

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
        It "Should fail when filter is empty" {
            { Get-EntraMSApplication -Top } | Should -Throw "Missing an argument for parameter 'Top'*"
        }
        It "Should fail when filter is invalid" {
            { Get-EntraMSApplication -Top XY } | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
        }
        It "Should return all applications" {
            $result = Get-EntraMSApplication -All
            $result | Should -Not -BeNullOrEmpty     
            
            Should -Invoke -CommandName Get-MgApplication  -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when All is empty" {
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
            $result = Get-EntraMSApplication -ObjectId "111cc9b5-fce9-485e-9566-c68debafac5f"
            $result.ObjectId | should -Be "111cc9b5-fce9-485e-9566-c68debafac5f"
        }     
        It "Should contain ApplicationId in parameters when passed ObjectId to it" {    
            $result = Get-EntraMSApplication -ObjectId "111cc9b5-fce9-485e-9566-c68debafac5f"
            $params = Get-Parameters -data $result.Parameters
            $params.ApplicationId | Should -Be "111cc9b5-fce9-485e-9566-c68debafac5f"
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