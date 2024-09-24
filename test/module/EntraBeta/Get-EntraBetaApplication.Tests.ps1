# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta    
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    $scriptblock = {
        # Write-Host "Mocking Get-MgBetaApplication with parameters: $($args | ConvertTo-Json -Depth 3)"
        return @(
            [PSCustomObject]@{
              "AppId"                        = "5f783237-3457-45d8-93e7-a0edb1cfbfd1"
              "AppRoles"                     = $null
              "DeletedDateTime"              = $null
              "Id"                           = "aaaaaaaa-1111-1111-1111-000000000000"
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

    Mock -CommandName Get-MgBetaApplication -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Get-EntraBetaApplication" {
    Context "Test for Get-EntraBetaApplication" {
        It "Should return specific application" {
            $result = Get-EntraBetaApplication -ObjectId "aaaaaaaa-1111-1111-1111-000000000000"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be @('aaaaaaaa-1111-1111-1111-000000000000')
            Should -Invoke -CommandName Get-MgBetaApplication  -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should fail when ObjectId is empty" {
            { Get-EntraBetaApplication -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }
        It "Should return all applications" {
            $result = Get-EntraBetaApplication -All
            $result | Should -Not -BeNullOrEmpty  
            Should -Invoke -CommandName Get-MgBetaApplication  -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should fail when All has argument" {
            { Get-EntraBetaAuditDirectoryLog -All $true } | Should -Throw "A positional parameter cannot be found that accepts argument 'True'."
        }     
        It "Should fail when invalid parameter is passed" {
            { Get-EntraBetaApplication -Power "abc" } | Should -Throw "A parameter cannot be found that matches parameter name 'Power'*"
        }       
        It "Should return specific application by searchstring" {
            $result = Get-EntraBetaApplication -SearchString 'Mock-App'
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | should -Be 'Mock-App'
            Should -Invoke -CommandName Get-MgBetaApplication  -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        } 
        It "Should return specific application by filter" {
            $result = Get-EntraBetaApplication -Filter "DisplayName -eq 'Mock-App'"
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | should -Be 'Mock-App'
            Should -Invoke -CommandName Get-MgBetaApplication  -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }  
        It "Should return top application" {
            $result = Get-EntraBetaApplication -Top 1
            $result | Should -Not -BeNullOrEmpty
            Should -Invoke -CommandName Get-MgBetaApplication  -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }  
        It "Result should Contain ObjectId" {
            $result = Get-EntraBetaApplication -ObjectId "aaaaaaaa-1111-1111-1111-000000000000"
            $result.ObjectId | should -Be "aaaaaaaa-1111-1111-1111-000000000000"
        }     
        It "Should contain ApplicationId in parameters when passed ObjectId to it" {              
            $result = Get-EntraBetaApplication -ObjectId "aaaaaaaa-1111-1111-1111-000000000000"
            $params = Get-Parameters -data $result.Parameters
            $params.ApplicationId | Should -Be "aaaaaaaa-1111-1111-1111-000000000000"
        }
        It "Should contain Filter in parameters when passed SearchString to it" {               
            $result = Get-EntraBetaApplication -SearchString 'Mock-App'
            $params = Get-Parameters -data $result.Parameters
            $params.Filter | Should -Match "Mock-App"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaApplication"
            $result =  Get-EntraBetaApplication -ObjectId "aaaaaaaa-1111-1111-1111-000000000000"
            $result | Should -Not -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaApplication"
            Should -Invoke -CommandName Get-MgBetaApplication -ModuleName Microsoft.Graph.Entra.Beta -Times 1 -ParameterFilter {
                $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
                $true
            }
        }
        It "Property parameter should work" {
            $result = Get-EntraBetaApplication -ObjectId "aaaaaaaa-1111-1111-1111-000000000000" -Property DisplayName
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | Should -Be 'Mock-App'
    
            Should -Invoke -CommandName Get-MgBetaApplication  -ModuleName Microsoft.Graph.Entra.Beta -Times 1
           }
    
           It "Should fail when Property is empty" {
            { Get-EntraBetaApplication -ObjectId "aaaaaaaa-1111-1111-1111-000000000000" -Property } | Should -Throw "Missing an argument for parameter 'Property'*"
           }
        It "Should execute successfully without throwing an error " {
            # Disable confirmation prompts       
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'
    
            try {
                # Act & Assert: Ensure the function doesn't throw an exception
                { Get-EntraBetaApplication -ObjectId "aaaaaaaa-1111-1111-1111-000000000000" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
        It "Should support minimum set of parameter sets" {
            $GetAzureADApplication = Get-Command Get-EntraBetaApplication
            $GetAzureADApplication.ParameterSets.Name | Should -BeIn @("GetQuery", "GetVague", "GetById")
            $GetAzureADApplication.Visibility | Should -Be "Public"
            $GetAzureADApplication.CommandType | Should -Be "Function"
        }

        It "Should return a list of applications by default" {
            $GetAzureADApplication = Get-Command Get-EntraBetaApplication
            $GetAzureADApplication.ModuleName | Should -Be "Microsoft.Graph.Entra.Beta"
            $GetAzureADApplication.DefaultParameterSet | Should -Be "GetQuery"
        }    
        It 'Should have List parameterSet' {
            $GetAzureADApplication = Get-Command Get-EntraBetaApplication
            $ListParameterSet = $GetAzureADApplication.ParameterSets | Where-Object Name -eq "GetQuery"
            $ListParameterSet.Parameters.Name | Should -Contain All
            $ListParameterSet.Parameters.Name | Should -Contain Filter
            $ListParameterSet.Parameters.Name | Should -Contain Top
        }    
        It 'Should have Get parameterSet' {
            $GetAzureADApplication = Get-Command Get-EntraBetaApplication
            $GetParameterSet = $GetAzureADApplication.ParameterSets | Where-Object Name -eq "GetById"
            $GetParameterSet.Parameters.Name | Should -Contain ObjectId
        }    
        It 'Should have GetViaIdentity parameterSet' {
            $GetAzureADApplication = Get-Command Get-EntraBetaApplication
            $GetViaIdentityParameterSet = $GetAzureADApplication.ParameterSets | Where-Object Name -eq "GetVague"
            $GetViaIdentityParameterSet.Parameters.Name | Should -Contain SearchString
            $GetViaIdentityParameterSet.Parameters.Name | Should -Contain All
        }
    }
}