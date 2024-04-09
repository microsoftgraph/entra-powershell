BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        #Import-Module .\bin\Microsoft.Graph.Entra.psm1 -Force
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module .\test\module\Common-Functions.ps1 -Force
    
    $scriptblock = {
        # Write-Host "Mocking Get-MgApplication with parameters: $($args | ConvertTo-Json -Depth 3)"
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
              "AddIns"                       = @{}
              "Logo"                         = $null
              "AppRoles"                     = $null
              "GroupMembershipClaims"        = $null
              "IdentifierUris"               = $null
              "Oauth2RequirePostResponse"    = $null
              "Api"                          = @{AcceptMappedClaims= $null; KnownClientApplications=$null; Oauth2PermissionScopes=$null;
                                                PreAuthorizedApplications=$null; RequestedAccessTokenVersion=2; AdditionalProperties= $null}
              "PublicClient"                 = @{RedirectUris=$null}
              "RequiredResourceAccess"       = $false
              "PublisherDomain"              = "M365x99297270.onmicrosoft.com"
              "SignInAudience"               = "AzureADandPersonalMicrosoftAccount"
              "Web"                          = @{HomePageUrl="https://localhost/demoapp"; ImplicitGrantSettings=""; LogoutUrl="";}
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
        It "Should fail when ObjectId is empty" {
            { Get-EntraMSApplication -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }
        It "Should return all applications" {
            $result = Get-EntraMSApplication -All $true
            $result | Should -Not -BeNullOrEmpty            
            
            Should -Invoke -CommandName Get-MgApplication  -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when All is empty" {
            { Get-EntraMSApplication -All } | Should -Throw "Missing an argument for parameter 'All'*"
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
            $result = Get-EntraMSApplication -Top 1
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgApplication  -ModuleName Microsoft.Graph.Entra -Times 1
        }  
        It "Result should Contain ObjectId" {            
            $result = Get-EntraMSApplication -ObjectId "111cc9b5-fce9-485e-9566-c68debafac5f"
            $result.ObjectId | should -Be "111cc9b5-fce9-485e-9566-c68debafac5f"
        }  
        # issue in addins param transformation in args, will uncomment after resolve.   
        # It "Should contain ApplicationId in parameters when passed ObjectId to it" {    
        #     Mock -CommandName Get-MgApplication -MockWith {$args} -ModuleName Microsoft.Graph.Entra
            
        #     $result = Get-EntraMSApplication -ObjectId "111cc9b5-fce9-485e-9566-c68debafac5f"
        #     $params = Get-Parameters -data $result
        #     $params.ApplicationId | Should -Be "111cc9b5-fce9-485e-9566-c68debafac5f"
        # }
        # It "Should contain Filter in parameters when passed SearchString to it" {               
        #     Mock -CommandName Get-MgApplication -MockWith {$args} -ModuleName Microsoft.Graph.Entra

        #     $result = Get-EntraMSApplication -SearchString 'Mock-App'
        #     $params = Get-Parameters -data $result
        #     $params.Filter | Should -Match "Mock-App"
        # }
        # It "Should contain 'User-Agent' header" {
        #     Mock -CommandName Get-MgApplication -MockWith {$args} -ModuleName Microsoft.Graph.Entra

        #     $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraMSApplication"

        #     $result = Get-EntraMSApplication -SearchString 'Mock-App'
        #     $params = Get-Parameters -data $result
        #     $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        # }
    }
}