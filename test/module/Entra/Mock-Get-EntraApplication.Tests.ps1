BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        # Import-Module .\bin\Microsoft.Graph.Entra.psm1 -Force
        Import-Module Microsoft.Graph.Entra
    }
    $scriptblock = {
        param($args)
        Write-Host "Mocking Get-MgApplication with parameters: $($args | ConvertTo-Json -Depth 3)"
        return @(
            [PSCustomObject]@{
              "AppId"                        = "5f783237-3457-45d8-93e7-a0edb1cfbfd1"
              "DeletedDateTime"              = $null
              "Id"                           = "111cc9b5-fce9-485e-9566-c68debafac5f"
              "DisplayName"                  = "Mock-App"
              "Info"                         = @{LogoUrl=""; MarketingUrl=""; PrivacyStatementUrl=""; SupportUrl=""; TermsOfServiceUrl=""}
              "IsDeviceOnlyAuthSupported"    = $True
              "IsFallbackPublicClient"       = $true
              "KeyCredentials"               = @{CustomKeyIdentifier = @(211, 174, 247);DisplayName =""; Key="";KeyId="d903c7a3-75ea-4772-8935-5c0cf82068a7";Type="Symmetric";Usage="Sign"}
              "OptionalClaims"               = @{AccessToken=""; IdToken=""; Saml2Token=""}
              "ParentalControlSettings"      = @{CountriesBlockedForMinors=$null; LegalAgeGroupRule="Allow"}
              "PasswordCredentials"          = @{}
              "PublicClient"                 = @{RedirectUris=$null}
              "PublisherDomain"              = "M365x99297270.onmicrosoft.com"
              "SignInAudience"               = "AzureADandPersonalMicrosoftAccount"
              "Web"                          = @{HomePageUrl="https://localhost/demoapp"; ImplicitGrantSettings=""; LogoutUrl="";}
            }
        )
        }     
          Mock -CommandName Get-MgApplication -MockWith $scriptBlock -ModuleName Microsoft.Graph.Entra
  }
  
  Describe "Get-EntraApplication" {
    Context "Test for Get-EntraApplication" {
        It "Should return specific application" {
            $result = Get-EntraApplication -ObjectId "111cc9b5-fce9-485e-9566-c68debafac5f"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be @('111cc9b5-fce9-485e-9566-c68debafac5f')

            Should -Invoke -CommandName Get-MgApplication  -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when ObjectId is empty" {
            { Get-EntraApplication -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }
        It "Should return all applications" {
            $result = Get-EntraApplication -All $true
            $result | Should -Not -BeNullOrEmpty            
            
            Should -Invoke -CommandName Get-MgApplication  -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when All is empty" {
            { Get-EntraApplication -All } | Should -Throw "Missing an argument for parameter 'All'*"
        }           
        It "Should return specific application by searchstring" {
            $result = Get-EntraApplication -SearchString 'Mock-App'
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | should -Be 'Mock-App'

            Should -Invoke -CommandName Get-MgApplication  -ModuleName Microsoft.Graph.Entra -Times 1
        } 
        It "Should return specific application by filter" {
            $result = Get-EntraApplication -Filter "DisplayName -eq 'Mock-App'"
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | should -Be 'Mock-App'

            Should -Invoke -CommandName Get-MgApplication  -ModuleName Microsoft.Graph.Entra -Times 1
        }  
        It "Should return top application" {
            $result = Get-EntraApplication -Top 1
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgApplication  -ModuleName Microsoft.Graph.Entra -Times 1
        }  
        It "Result should Contain ObjectId" {
            $result = Get-EntraApplication -ObjectId "111cc9b5-fce9-485e-9566-c68debafac5f"
            $result.ObjectId | should -Be "111cc9b5-fce9-485e-9566-c68debafac5f"
        }      
    }
  }