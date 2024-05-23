BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
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
              "PublicClient"                 = @{RedirectUris=$null}
              "PublisherDomain"              = "M365x99297270.onmicrosoft.com"
              "SignInAudience"               = "AzureADandPersonalMicrosoftAccount"
              "Web"                          = @{HomePageUrl="https://localhost/demoapp"; ImplicitGrantSettings=""; LogoutUrl="";}
              "Parameters"                    = $args
            }
        )
    }

    Mock -CommandName Get-MgApplication -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
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
        It "Should contain ApplicationId in parameters when passed ObjectId to it" {              
            $result = Get-EntraApplication -ObjectId "111cc9b5-fce9-485e-9566-c68debafac5f"
            $params = Get-Parameters -data $result.Parameters
            $params.ApplicationId | Should -Be "111cc9b5-fce9-485e-9566-c68debafac5f"
        }
        It "Should contain Filter in parameters when passed SearchString to it" {               
            $result = Get-EntraApplication -SearchString 'Mock-App'
            $params = Get-Parameters -data $result.Parameters
            $params.Filter | Should -Match "Mock-App"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraApplication"
            $result = Get-EntraApplication -SearchString 'Mock-App'
            $params = Get-Parameters -data $result.Parameters
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }
        It "Should support minimum set of parameter sets" {
            $GetAzureADApplication = Get-Command Get-EntraApplication
            $GetAzureADApplication.ParameterSets.Name | Should -BeIn @("GetQuery", "GetVague", "GetById")
            $GetAzureADApplication.Visibility | Should -Be "Public"
            $GetAzureADApplication.CommandType | Should -Be "Function"
        }
    
        It "Should return a list of applications by default" {
            $GetAzureADApplication = Get-Command Get-EntraApplication
            $GetAzureADApplication.ModuleName | Should -Be "Microsoft.Graph.Entra"
            $GetAzureADApplication.DefaultParameterSet | Should -Be "GetQuery"
        }    
        It 'Should have List parameterSet' {
            $GetAzureADApplication = Get-Command Get-EntraApplication
            $ListParameterSet = $GetAzureADApplication.ParameterSets | Where-Object Name -eq "GetQuery"
            $ListParameterSet.Parameters.Name | Should -Contain All
            $ListParameterSet.Parameters.Name | Should -Contain Filter
            $ListParameterSet.Parameters.Name | Should -Contain Top
        }    
        It 'Should have Get parameterSet' {
            $GetAzureADApplication = Get-Command Get-EntraApplication
            $GetParameterSet = $GetAzureADApplication.ParameterSets | Where-Object Name -eq "GetById"
            $GetParameterSet.Parameters.Name | Should -Contain ObjectId
        }    
        It 'Should have GetViaIdentity parameterSet' {
            $GetAzureADApplication = Get-Command Get-EntraApplication
            $GetViaIdentityParameterSet = $GetAzureADApplication.ParameterSets | Where-Object Name -eq "GetVague"
            $GetViaIdentityParameterSet.Parameters.Name | Should -Contain SearchString
            $GetViaIdentityParameterSet.Parameters.Name | Should -Contain All
        }
    }
}