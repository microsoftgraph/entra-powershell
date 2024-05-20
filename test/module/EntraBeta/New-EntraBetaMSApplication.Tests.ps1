BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta    
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        # Write-Host "Mocking New-MgBetaApplication with parameters: $($args | ConvertTo-Json -Depth 3)"
        return @(
            [PSCustomObject]@{
                "AppId"                        = "5f783237-3457-45d8-93e7-a0edb1cfbfd1"
                "DeletedDateTime"              = $null
                "Id"                           = "111cc9b5-fce9-485e-9566-c68debafac5f"
                "DisplayName"                  = "Mock-App"
                "Info"                         = @{LogoUrl=""; MarketingUrl=""; PrivacyStatementUrl=""; SupportUrl=""; TermsOfServiceUrl=""}
                "IsDeviceOnlyAuthSupported"    = $True
                "IsFallbackPublicClient"       = $True
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
                "AdditionalProperties"         = @{Context="application"}
                "Parameters"                   = $args
            }
        )
    }

    Mock -CommandName New-MgBetaApplication -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "New-EntraBetaMSApplication"{
    Context "Test for New-EntraBetaMSApplication" {
        It "Should return created Application"{
            $result = New-EntraBetaMSApplication -DisplayName "Mock-App"
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | should -Be "Mock-App"
            $result.IsDeviceOnlyAuthSupported | should -Be "True"
            $result.IsFallbackPublicClient | should -Be "True"
            $result.SignInAudience | should -Be "AzureADandPersonalMicrosoftAccount" 
            Should -Invoke -CommandName New-MgBetaApplication -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should fail when DisplayName is empty" {
            { New-EntraBetaMSApplication -DisplayName "" } | Should -Throw "Cannot bind argument to parameter*"
        }
        It "Should fail when invalid parameter is passed" {
            { New-EntraBetaMSApplication -Power "abc" } | Should -Throw "A parameter cannot be found that matches parameter name 'Power'*"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraBetaMSApplication"
            $result = New-EntraBetaMSApplication -DisplayName "Mock-App"
            $params = Get-Parameters -data $result.Parameters
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }
    }
}