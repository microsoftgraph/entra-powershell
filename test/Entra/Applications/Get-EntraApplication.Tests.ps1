# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.Applications) -eq $null) {
        Import-Module Microsoft.Entra.Applications      
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1" ) -Force
    
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
                "KeyCredentials"            = @{CustomKeyIdentifier = @(211, 174, 247); DisplayName = ""; Key = ""; KeyId = "pppppppp-1111-2222-3333-cccccccccccc"; Type = "Symmetric"; Usage = "Sign" }
                "OptionalClaims"            = @{AccessToken = ""; IdToken = ""; Saml2Token = "" }
                "ParentalControlSettings"   = @{CountriesBlockedForMinors = $null; LegalAgeGroupRule = "Allow" }
                "PasswordCredentials"       = @{}
                "PublicClient"              = @{RedirectUris = $null }
                "PublisherDomain"           = "aaaabbbbbcccc.onmicrosoft.com"
                "SignInAudience"            = "AzureADandPersonalMicrosoftAccount"
                "Web"                       = @{HomePageUrl = "https://localhost/demoapp"; ImplicitGrantSettings = ""; LogoutUrl = ""; }
                "Parameters"                = $args
            }
        )
    }

    Mock -CommandName Get-MgApplication -MockWith $scriptblock -ModuleName Microsoft.Entra.Applications
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("Application.Read.All") } } -ModuleName Microsoft.Entra.Applications
}
  
Describe "Get-EntraApplication" {
    Context "Test for Get-EntraApplication" {
        It "Should return specific application" {
            $result = Get-EntraApplication -ApplicationId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be @('bbbbbbbb-1111-2222-3333-cccccccccccc')

            Should -Invoke -CommandName Get-MgApplication -ModuleName Microsoft.Entra.Applications -Times 1
        }
        It "Should fail when ApplicationId is invalid" {
            { Get-EntraApplication -ApplicationId "" } | Should -Throw "Cannot validate argument on parameter 'ApplicationId'. The argument is null or empty. Provide an argument that is not null or empty, and then try the command again."
        }
        It "Should fail when ApplicationId is empty" {
            { Get-EntraApplication -ApplicationId } | Should -Throw "Missing an argument for parameter 'ApplicationId'*"
        }
        It "Should return all applications" {
            $result = Get-EntraApplication -All
            $result | Should -Not -BeNullOrEmpty            
            
            Should -Invoke -CommandName Get-MgApplication -ModuleName Microsoft.Entra.Applications -Times 1
        }
        It "Should fail when All has an argument" {
            { Get-EntraApplication -All $true } | Should -Throw "A positional parameter cannot be found that accepts argument 'True'.*"
        }   
        It "Should fail when searchstring is empty" {
            { Get-EntraApplication -SearchString } | Should -Throw "Missing an argument for parameter 'SearchString'*"
        } 
        It "Should fail when filter is empty" {
            { Get-EntraApplication -Filter } | Should -Throw "Missing an argument for parameter 'Filter'*"
        }
        It "Should fail when Top is empty" {
            { Get-EntraApplication -Top } | Should -Throw "Missing an argument for parameter 'Top'*"
        }
        It "Should fail when Top is invalid" {
            { Get-EntraApplication -Top XY } | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
        }        
        It "Should return specific application by searchstring" {
            $result = Get-EntraApplication -SearchString 'Mock-App'
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | should -Be 'Mock-App'

            Should -Invoke -CommandName Get-MgApplication -ModuleName Microsoft.Entra.Applications -Times 1
        } 
        It "Should return specific application by filter" {
            $result = Get-EntraApplication -Filter "DisplayName -eq 'Mock-App'"
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | should -Be 'Mock-App'

            Should -Invoke -CommandName Get-MgApplication -ModuleName Microsoft.Entra.Applications -Times 1
        }  
        It "Should return top application" {
            $result = @(Get-EntraApplication -Top 1)
            $result | Should -Not -BeNullOrEmpty
            $result | Should -HaveCount 1 

            Should -Invoke -CommandName Get-MgApplication -ModuleName Microsoft.Entra.Applications -Times 1
        }  
        It "Result should Contain ApplicationId" {
            $result = Get-EntraApplication -ApplicationId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $result.ObjectId | should -Be "bbbbbbbb-1111-2222-3333-cccccccccccc"
        }     
        It "Should contain ApplicationId in parameters when passed ApplicationId to it" {              
            $result = Get-EntraApplication -ApplicationId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $params = Get-Parameters -data $result.Parameters
            $params.ApplicationId | Should -Be "bbbbbbbb-1111-2222-3333-cccccccccccc"
        }
        It "Should contain Filter in parameters when passed SearchString to it" {               
            $result = Get-EntraApplication -SearchString 'Mock-App'
            $params = Get-Parameters -data $result.Parameters
            $params.Filter | Should -Match "Mock-App"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraApplication"

            $result = Get-EntraApplication -ObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $result | Should -Not -BeNullOrEmpty

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraApplication"

            Should -Invoke -CommandName Get-MgApplication -ModuleName Microsoft.Entra.Applications -Times 1 -ParameterFilter {
                $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
                $true
            }
        } 
        It "Property parameter should work" {
            $result = Get-EntraApplication -Top 1 -Property DisplayName
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | Should -Be 'Mock-App'

            Should -Invoke -CommandName Get-MgApplication -ModuleName Microsoft.Entra.Applications -Times 1
        }
        It "Should fail when Property is empty" {
            { Get-EntraApplication -ObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc" -Property } | Should -Throw "Missing an argument for parameter 'Property'*"
        }
        It "Should execute successfully without throwing an error " {
            # Disable confirmation prompts       
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'

            try {
                # Act & Assert: Ensure the function doesn't throw an exception
                { Get-EntraApplication -Top 1 -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        } 
        It "Should execute successfully with Alias" {
            $result = Get-EntraApplication -ObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            Write-Verbose "Result : {$result}" -Verbose
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be @('bbbbbbbb-1111-2222-3333-cccccccccccc')

            Should -Invoke -CommandName Get-MgApplication -ModuleName Microsoft.Entra.Applications -Times 1
        }
    }
}

