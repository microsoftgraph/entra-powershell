BeforeAll {
  Import-Module -Name Microsoft.Graph.Applications -Force

  if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
      Import-Module ..\..\..\bin\Microsoft.Graph.Entra.psm1 -Force
  }
}

# Test cases for Get-EntraApplication
Describe "Get-EntraApplication" {
  Context "Test for Get-EntraApplication" {

      It "Should return all applications" {
      # Mock the Get-MgApplication cmdlet for this specific test case
        $scriptblock = {
        
        param($args)
        Write-Host "Mocking Get-MgApplication with parameters: $($args | ConvertTo-Json -Depth 3)"

        return @(
            [PSCustomObject]@{
              "AddIns"                       = @{}
              "Api"                          = @{AcceptMappedClaims=$null; KnownClientApplications=$null;
                                             Oauth2PermissionScopes=$null; PreAuthorizedApplications=$null;
                                             RequestedAccessTokenVersion=2}
              "AppId"                        = "5f783237-3457-45d8-93e7-a0edb1cfbfd1"
              "AppManagementPolicies"        = $null
              "AppRoles"                     = $null
              "ApplicationTemplateId"        = $null
              "CreatedDateTime"              = $null
              "CreatedOnBehalfOf"            = @{DeletedDateTime=""; Id=""}
              "DefaultRedirectUri"           = $null
              "DeletedDateTime"              = $null
              "Description"                  = $null
              "DisabledByMicrosoftStatus"    = $null
              "GroupMembershipClaims"        = $null
              "Id"                           = "010cc9b5-fce9-485e-9566-c68debafac5f"
              "IdentifierUris"               = @{}
              "Info"                         = @{LogoUrl=""; MarketingUrl=""; PrivacyStatementUrl=""; SupportUrl=""; TermsOfServiceUrl=""}
              "IsDeviceOnlyAuthSupported"    = $True
              "IsFallbackPublicClient"       = $true
              "KeyCredentials"               = @{}
              "Logo"                         = $null
              "Oauth2RequirePostResponse"    = $null
              "OptionalClaims"               = @{AccessToken=""; IdToken=""; Saml2Token=""}
              "Owners"                       = $null
              "ParentalControlSettings"      = @{CountriesBlockedForMinors=$null; LegalAgeGroupRule="Allow"}
              "PasswordCredentials"          = @{}
              "PublicClient"                 = @{RedirectUris=$null}
              "PublisherDomain"              = "M365x99297270.onmicrosoft.com"
              "RequiredResourceAccess"       = @{}
              "SamlMetadataUrl"              = $null
              "ServiceManagementReference"   = $null
              "SignInAudience"               = "AzureADandPersonalMicrosoftAccount"
              "Spa"                          = @{RedirectUris=$null}
              "Synchronization"              = @{Id=""; Jobs=""; Secrets=""; Templates=""}
              "Tags"                         = @{}
              "Web"                          = @{HomePageUrl="https://localhost/demoapp"; ImplicitGrantSettings=""; LogoutUrl="";}
            }
        )
        }     

          Mock -CommandName Get-MgApplication -MockWith $scriptBlock -ModuleName Microsoft.Graph.Entra

          $result = Get-EntraApplication -All $true
          $result | Should -Not -BeNullOrEmpty
      }

      It "Should return specific application" {
        # Mock the Get-MgApplication cmdlet for this specific test case
          $scriptblock = {
          
          param($args)
          Write-Host "Mocking Get-MgApplication with parameters: $($args | ConvertTo-Json -Depth 3)"
  
          return @(
              [PSCustomObject]@{
                "AddIns"                       = @{}
                "Api"                          = @{AcceptMappedClaims=$null; KnownClientApplications=$null;
                                               Oauth2PermissionScopes=$null; PreAuthorizedApplications=$null;
                                               RequestedAccessTokenVersion=2}
                "AppId"                        = "5f783237-3457-45d8-93e7-a0edb1cfbfd1"
                "AppManagementPolicies"        = $null
                "AppRoles"                     = $null
                "ApplicationTemplateId"        = $null
                "CreatedDateTime"              = $null
                "CreatedOnBehalfOf"            = @{DeletedDateTime=""; Id=""}
                "DefaultRedirectUri"           = $null
                "DeletedDateTime"              = $null
                "Description"                  = $null
                "DisabledByMicrosoftStatus"    = $null
                "GroupMembershipClaims"        = $null
                "Id"                           = "010cc9b5-fce9-485e-9566-c68debafac5f"
                "IdentifierUris"               = @{}
                "Info"                         = @{LogoUrl=""; MarketingUrl=""; PrivacyStatementUrl=""; SupportUrl=""; TermsOfServiceUrl=""}
                "IsDeviceOnlyAuthSupported"    = $True
                "IsFallbackPublicClient"       = $true
                "KeyCredentials"               = @{}
                "Logo"                         = $null
                "Oauth2RequirePostResponse"    = $null
                "OptionalClaims"               = @{AccessToken=""; IdToken=""; Saml2Token=""}
                "Owners"                       = $null
                "ParentalControlSettings"      = @{CountriesBlockedForMinors=$null; LegalAgeGroupRule="Allow"}
                "PasswordCredentials"          = @{}
                "PublicClient"                 = @{RedirectUris=$null}
                "PublisherDomain"              = "M365x99297270.onmicrosoft.com"
                "RequiredResourceAccess"       = @{}
                "SamlMetadataUrl"              = $null
                "ServiceManagementReference"   = $null
                "SignInAudience"               = "AzureADandPersonalMicrosoftAccount"
                "Spa"                          = @{RedirectUris=$null}
                "Synchronization"              = @{Id=""; Jobs=""; Secrets=""; Templates=""}
                "Tags"                         = @{}
                "Web"                          = @{HomePageUrl="https://localhost/demoapp"; ImplicitGrantSettings=""; LogoutUrl="";}
              }
          )
          }     
  
            Mock -CommandName Get-MgApplication -MockWith $scriptBlock -ModuleName Microsoft.Graph.Entra
  
            $result = Get-EntraApplication -ObjectId "010cc9b5-fce9-485e-9566-c68debafac5f"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be @('010cc9b5-fce9-485e-9566-c68debafac5f')
    }

    It "Should return specific application by searchstring" {
        # Mock the Get-MgApplication cmdlet for this specific test case
          $scriptblock = {
          
          param($args)
          Write-Host "Mocking Get-MgApplication with parameters: $($args | ConvertTo-Json -Depth 3)"
  
          return @(
              [PSCustomObject]@{
                "AddIns"                       = @{}
                "Api"                          = @{AcceptMappedClaims=$null; KnownClientApplications=$null;
                                               Oauth2PermissionScopes=$null; PreAuthorizedApplications=$null;
                                               RequestedAccessTokenVersion=2}
                "AppId"                        = "5f783237-3457-45d8-93e7-a0edb1cfbfd1"
                "AppManagementPolicies"        = $null
                "AppRoles"                     = $null
                "ApplicationTemplateId"        = $null
                "CreatedDateTime"              = $null
                "CreatedOnBehalfOf"            = @{DeletedDateTime=""; Id=""}
                "DefaultRedirectUri"           = $null
                "DeletedDateTime"              = $null
                "Description"                  = $null
                "DisplayName"                  = "test app"
                "DisabledByMicrosoftStatus"    = $null
                "GroupMembershipClaims"        = $null
                "Id"                           = "010cc9b5-fce9-485e-9566-c68debafac5f"
                "IdentifierUris"               = @{}
                "Info"                         = @{LogoUrl=""; MarketingUrl=""; PrivacyStatementUrl=""; SupportUrl=""; TermsOfServiceUrl=""}
                "IsDeviceOnlyAuthSupported"    = $True
                "IsFallbackPublicClient"       = $true
                "KeyCredentials"               = @{}
                "Logo"                         = $null
                "Oauth2RequirePostResponse"    = $null
                "OptionalClaims"               = @{AccessToken=""; IdToken=""; Saml2Token=""}
                "Owners"                       = $null
                "ParentalControlSettings"      = @{CountriesBlockedForMinors=$null; LegalAgeGroupRule="Allow"}
                "PasswordCredentials"          = @{}
                "PublicClient"                 = @{RedirectUris=$null}
                "PublisherDomain"              = "M365x99297270.onmicrosoft.com"
                "RequiredResourceAccess"       = @{}
                "SamlMetadataUrl"              = $null
                "ServiceManagementReference"   = $null
                "SignInAudience"               = "AzureADandPersonalMicrosoftAccount"
                "Spa"                          = @{RedirectUris=$null}
                "Synchronization"              = @{Id=""; Jobs=""; Secrets=""; Templates=""}
                "Tags"                         = @{}
                "Web"                          = @{HomePageUrl="https://localhost/demoapp"; ImplicitGrantSettings=""; LogoutUrl="";}
              }
          )
          }     
  
            Mock -CommandName Get-MgApplication -MockWith $scriptBlock -ModuleName Microsoft.Graph.Entra
    
              $result = Get-EntraApplication -SearchString 'test app'
              $result | Should -Not -BeNullOrEmpty
              $result.DisplayName | should -Be 'test app'
    }  
        
    It "Should return specific application by filter" {
          # Mock the Get-MgApplication cmdlet for this specific test case
            $scriptblock = {
            # Your mock implementation here
            param($args)
            Write-Host "Mocking Get-MgApplication with parameters: $($args | ConvertTo-Json -Depth 3)"
    
            return @(
                [PSCustomObject]@{
                  "AddIns"                       = @{}
                  "Api"                          = @{AcceptMappedClaims=$null; KnownClientApplications=$null;
                                                 Oauth2PermissionScopes=$null; PreAuthorizedApplications=$null;
                                                 RequestedAccessTokenVersion=2}
                  "AppId"                        = "5f783237-3457-45d8-93e7-a0edb1cfbfd1"
                  "AppManagementPolicies"        = $null
                  "AppRoles"                     = $null
                  "ApplicationTemplateId"        = $null
                  "CreatedDateTime"              = $null
                  "CreatedOnBehalfOf"            = @{DeletedDateTime=""; Id=""}
                  "DefaultRedirectUri"           = $null
                  "DeletedDateTime"              = $null
                  "Description"                  = $null
                  "DisplayName"                  = "test app"
                  "DisabledByMicrosoftStatus"    = $null
                  "GroupMembershipClaims"        = $null
                  "Id"                           = "010cc9b5-fce9-485e-9566-c68debafac5f"
                  "IdentifierUris"               = @{}
                  "Info"                         = @{LogoUrl=""; MarketingUrl=""; PrivacyStatementUrl=""; SupportUrl=""; TermsOfServiceUrl=""}
                  "IsDeviceOnlyAuthSupported"    = $True
                  "IsFallbackPublicClient"       = $true
                  "KeyCredentials"               = @{}
                  "Logo"                         = $null
                  "Oauth2RequirePostResponse"    = $null
                  "OptionalClaims"               = @{AccessToken=""; IdToken=""; Saml2Token=""}
                  "Owners"                       = $null
                  "ParentalControlSettings"      = @{CountriesBlockedForMinors=$null; LegalAgeGroupRule="Allow"}
                  "PasswordCredentials"          = @{}
                  "PublicClient"                 = @{RedirectUris=$null}
                  "PublisherDomain"              = "M365x99297270.onmicrosoft.com"
                  "RequiredResourceAccess"       = @{}
                  "SamlMetadataUrl"              = $null
                  "ServiceManagementReference"   = $null
                  "SignInAudience"               = "AzureADandPersonalMicrosoftAccount"
                  "Spa"                          = @{RedirectUris=$null}
                  "Synchronization"              = @{Id=""; Jobs=""; Secrets=""; Templates=""}
                  "Tags"                         = @{}
                  "Web"                          = @{HomePageUrl="https://localhost/demoapp"; ImplicitGrantSettings=""; LogoutUrl="";}
                }
            )
            }     
    
          Mock -CommandName Get-MgApplication -MockWith $scriptBlock -ModuleName Microsoft.Graph.Entra
  
            $result = Get-EntraApplication -Filter "DisplayName -eq 'test app'"
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | should -Be 'test app'
    }  
    
    It "Should return top application" {
              # Mock the Get-MgApplication cmdlet for this specific test case
                $scriptblock = {
                
                param($args)
                Write-Host "Mocking Get-MgApplication with parameters: $($args | ConvertTo-Json -Depth 3)"
        
                return @(
                    [PSCustomObject]@{
                      "AddIns"                       = @{}
                      "Api"                          = @{AcceptMappedClaims=$null; KnownClientApplications=$null;
                                                     Oauth2PermissionScopes=$null; PreAuthorizedApplications=$null;
                                                     RequestedAccessTokenVersion=2}
                      "AppId"                        = "5f783237-3457-45d8-93e7-a0edb1cfbfd1"
                      "AppManagementPolicies"        = $null
                      "AppRoles"                     = $null
                      "ApplicationTemplateId"        = $null
                      "CreatedDateTime"              = $null
                      "CreatedOnBehalfOf"            = @{DeletedDateTime=""; Id=""}
                      "DefaultRedirectUri"           = $null
                      "DeletedDateTime"              = $null
                      "Description"                  = $null
                      "DisplayName"                  = "test app"
                      "DisabledByMicrosoftStatus"    = $null
                      "GroupMembershipClaims"        = $null
                      "Id"                           = "010cc9b5-fce9-485e-9566-c68debafac5f"
                      "IdentifierUris"               = @{}
                      "Info"                         = @{LogoUrl=""; MarketingUrl=""; PrivacyStatementUrl=""; SupportUrl=""; TermsOfServiceUrl=""}
                      "IsDeviceOnlyAuthSupported"    = $True
                      "IsFallbackPublicClient"       = $true
                      "KeyCredentials"               = @{}
                      "Logo"                         = $null
                      "Oauth2RequirePostResponse"    = $null
                      "OptionalClaims"               = @{AccessToken=""; IdToken=""; Saml2Token=""}
                      "Owners"                       = $null
                      "ParentalControlSettings"      = @{CountriesBlockedForMinors=$null; LegalAgeGroupRule="Allow"}
                      "PasswordCredentials"          = @{}
                      "PublicClient"                 = @{RedirectUris=$null}
                      "PublisherDomain"              = "M365x99297270.onmicrosoft.com"
                      "RequiredResourceAccess"       = @{}
                      "SamlMetadataUrl"              = $null
                      "ServiceManagementReference"   = $null
                      "SignInAudience"               = "AzureADandPersonalMicrosoftAccount"
                      "Spa"                          = @{RedirectUris=$null}
                      "Synchronization"              = @{Id=""; Jobs=""; Secrets=""; Templates=""}
                      "Tags"                         = @{}
                      "Web"                          = @{HomePageUrl="https://localhost/demoapp"; ImplicitGrantSettings=""; LogoutUrl="";}
                    }
                )
                }     
        
                  Mock -CommandName Get-MgApplication -MockWith $scriptBlock -ModuleName Microsoft.Graph.Entra
          
                  $result = Get-EntraApplication -Top 1
                  $result | Should -Not -BeNullOrEmpty
    }  

  
 }
}
