BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        return @(
            [PSCustomObject]@{
                "AddIns"                            = {}
                "AppRoles"                          = {}
                "GroupMembershipClaims"             = {}
                "IdentifierUris"                    = {}
                "Info"                              = @{
                                                        LogoUrl=""; 
                                                        MarketingUrl=""; 
                                                        PrivacyStatementUrl=""; 
                                                        SupportUrl=""; 
                                                        TermsOfServiceUrl="";
                                                    }
                "IsDeviceOnlyAuthSupported"         = $null
                "KeyCredentials"                    = {}
                "OptionalClaims"                    = {}
                "ParentalControlSettings"           = @{
                                                        CountriesBlockedForMinors=@{}; 
                                                        LegalAgeGroupRule="Allow";
                                                    }
                "PasswordCredentials"               = {}
                "Api"                               = @{
                                                        AcceptMappedClaims=@{}; 
                                                        KnownClientApplications=@{};
                                                        Oauth2PermissionScopes=@{}; 
                                                        PreAuthorizedApplications=@{};
                                                        RequestedAccessTokenVersion="2";
                                                    }
                "PublicClient"                      = @{
                                                        RedirectUris=@{};
                                                    }
                "PublisherDomain"                   = "M365x99297270.onmicrosoft.com"
                "Web"                               = @{
                                                        HomePageUrl=""; 
                                                        ImplicitGrantSettings=""; 
                                                        LogoutUrl="";
                                                        RedirectUriSettings=@{}; 
                                                        RedirectUris=@{};
                                                    }
                "RequiredResourceAccess"            = $null                
                "AppId"                             = "9c17362d-20b6-4572-bb6f-600e57c840e5"
                "AppManagementPolicies"             = $null
                "ApplicationTemplateId"             = $null
                "Certification"                     = {}
                "CreatedDateTime"                   = "12/12/2023 11:28:45 AM"
                "CreatedOnBehalfOf"                 = {}
                "DefaultRedirectUri"                = $null
                "DeletedDateTime"                   = "12/12/2023 12:23:39 PM"
                "Description"                       = $null
                "DisabledByMicrosoftStatus"         = $null
                "DisplayName"                       = "Mock-test-App"
                "ExtensionProperties"               = $null
                "FederatedIdentityCredentials"      = $null
                "HomeRealmDiscoveryPolicies"        = $null
                "Id"                                = "01157307-373c-47b0-889a-3bc57033d73e"
                "IsFallbackPublicClient"            = $null
                "Logo"                              = $null
                "Notes"                             = $null
                "Oauth2RequirePostResponse"         = $null
                "Owners"                            = $null
                "RequestSignatureVerification"      = {}
                "SamlMetadataUrl"                   = $null
                "ServiceManagementReference"        = $null
                "ServicePrincipalLockConfiguration" = {}
                "SignInAudience"                    = "AzureADandPersonalMicrosoftAccount"
                "Spa"                               = {}
                "Synchronization"                   = {}
                "Tags"                              = {}
                "TokenEncryptionKeyId"              = $null
                "TokenIssuancePolicies"             = $null
                "TokenLifetimePolicies"             = $null
                "UniqueName"                        = $null
                "VerifiedPublisher"                 = {}
                "AdditionalProperties"              = {}
                "Parameters"                        = $args
            }
        )
    }

    Mock -CommandName Get-MgDirectoryDeletedItemAsApplication -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}
  
Describe "Get-EntraDeletedApplication" {
    Context "Test for Get-EntraDeletedApplication" {        
        It "Should return all applications" {
            $result = Get-EntraDeletedApplication | ConvertTo-Json | ConvertFrom-Json
            $result | Should -Not -BeNullOrEmpty
            Should -Invoke -CommandName Get-MgDirectoryDeletedItemAsApplication -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when All is empty" {
            { Get-EntraDeletedApplication -All } | Should -Throw "Missing an argument for parameter 'All'*"
        }
        It "Should fail when invalid parameter is passed" {
            { Get-EntraDeletedApplication -DisplayName "abc" } | Should -Throw "A parameter cannot be found that matches parameter name 'DisplayName'*"
        }         
        It "Should return specific application by searchstring" {
            $result = Get-EntraDeletedApplication -SearchString 'Mock-test-App' | ConvertTo-Json | ConvertFrom-Json
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | should -Be 'Mock-test-App'

            Should -Invoke -CommandName Get-MgDirectoryDeletedItemAsApplication -ModuleName Microsoft.Graph.Entra -Times 1
        } 
        It "Should return specific application by filter" {
            $result = Get-EntraDeletedApplication -Filter "DisplayName -eq 'Mock-test-App'" | ConvertTo-Json | ConvertFrom-Json
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | should -Be 'Mock-test-App'

            Should -Invoke -CommandName Get-MgDirectoryDeletedItemAsApplication -ModuleName Microsoft.Graph.Entra -Times 1
        }  
        It "Should return top application" {
            $result = Get-EntraDeletedApplication -Top 1 | ConvertTo-Json | ConvertFrom-Json
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgDirectoryDeletedItemAsApplication -ModuleName Microsoft.Graph.Entra -Times 1
        }  
        It "Result should Contain ObjectId" {
            $result = Get-EntraDeletedApplication -Filter "DisplayName -eq 'Mock-test-App'" | ConvertTo-Json | ConvertFrom-Json
            $result.ObjectId | should -Be "01157307-373c-47b0-889a-3bc57033d73e"
        }
        It "Should contain Filter in parameters when passed SearchString to it" {               
            $result = Get-EntraDeletedApplication -SearchString 'Mock-test-App' | ConvertTo-Json | ConvertFrom-Json
            $params = Get-Parameters -data $result.Parameters
            $params.Filter | Should -Match "Mock-test-App"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraDeletedApplication"
            $result = Get-EntraDeletedApplication -Top 1 | ConvertTo-Json | ConvertFrom-Json
            $params = Get-Parameters -data $result.Parameters
            $a= $params | ConvertTo-json | ConvertFrom-Json
            $a.headers.'User-Agent' | Should -Be $userAgentHeaderValue
        }
    }
}