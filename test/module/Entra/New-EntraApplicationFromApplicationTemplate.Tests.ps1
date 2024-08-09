# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll{
    if ((Get-Module -Name Microsoft.Graph.Entra) -eq $null) {
        Import-Module Microsoft.Graph.Entra    
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    $response = @{
        "@odata.context"   =  'https://graph.microsoft.com/v1.0/$metadata#microsoft.graph.applicationServicePrincipal'
        "servicePrincipal" =  @{
                                 "oauth2PermissionScopes" = $null
                                 "servicePrincipalType" = "Application"
                                 "displayName" = "test app"
                                 "passwordCredentials" = $null
                                 "deletedDateTime" = $null
                                 "alternativeNames" = $null
                                 "homepage" = "https://*.e-days.com/SSO/SAML2/SP/AssertionConsumer.aspx?metadata=e-days|ISV9.2|primary|z"
                                 "applicationTemplateId" = "aaaaaaaa-1111-1111-1111-cccccccccccc"
                                 "appRoleAssignmentRequired" = $true
                                 "servicePrincipalNames" = $null
                                 "keyCredentials" = $null
                                 "appOwnerOrganizationId" = "aaaaaaaa-1111-2222-1111-cccccccccccc"
                                 "loginUrl" = $null
                                 "verifiedPublisher" = @{
                                                           "verifiedPublisherId" = $null
                                                           "displayName" = $null
                                                           "addedDateTime" = $null
                                                       }
                                 "logoutUrl" = $null
                                 "preferredSingleSignOnMode" = $null
                                 "appRoles" = $null
                                 "tokenEncryptionKeyId" = $null
                                 "samlSingleSignOnSettings" = $null
                                 "appDisplayName" = "test app"
                                 "id" = "aaaaaaaa-1111-3333-1111-cccccccccccc"
                                 "tags" = $null
                                 "addIns" = $null
                                 "accountEnabled" = $true
                                 "notificationEmailAddresses" = $null
                                 "replyUrls" = $null
                                 "info" =  @{
                                              "marketingUrl" = $null
                                              "privacyStatementUrl" = $null
                                              "termsOfServiceUrl" = $null
                                              "logoUrl" = $null
                                              "supportUrl" = $null
                                          }
                                 "appId" = "aaaaaaaa-1111-4444-1111-cccccccccccc"
                                 "preferredTokenSigningKeyThumbprint" = $null
                                }
        "application" =  @{
                            "passwordCredentials" = $null
                            "defaultRedirectUri" = $null
                            "parentalControlSettings" = @{
                                                            "legalAgeGroupRule" = "Allow"
                                                            "countriesBlockedForMinors" = ""
                                                        }
                            "verifiedPublisher" = @{
                                                      "verifiedPublisherId" = $null
                                                      "displayName" = $null
                                                      "addedDateTime" = $null
                                                    }
                            "info" = @{
                                         "marketingUrl" = $null
                                         "privacyStatementUrl" = $null
                                         "termsOfServiceUrl" = $null
                                         "logoUrl" = $null
                                         "supportUrl" = $null
                                     }
                            "createdDateTime" = $null
                            "keyCredentials" = $null
                            "identifierUris" = $null
                            "displayName" = "test app"
                            "applicationTemplateId" = "aaaaaaaa-1111-1111-1111-cccccccccccc"
                            "samlMetadataUrl" = $null
                            "addIns" = $null
                            "publicClient" = @{
                                                 "redirectUris" = ""
                                             }
                            "groupMembershipClaims" = $null
                            "requiredResourceAccess" = $null
                            "deletedDateTime" = $null
                            "tokenEncryptionKeyId" = $null
                            "optionalClaims" = $null
                            "web" = @{
                                        "homePageUrl" = "https://*.e-days.com/SSO/SAML2/SP/AssertionConsumer.aspx?metadata=e-days|ISV9.2|primary|z"
                                        "redirectUris" = "https://*.signin.e-days.co.uk/* https://*.signin.e-days.com/* https://*.e-days.com/SSO/SAML2/SP/AssertionConsumer.aspx"
                                        "logoutUrl" = $null
                                    }
                            "id" = "aaaaaaaa-2222-1111-1111-cccccccccccc"
                            "tags" = $null
                            "isFallbackPublicClient" = $false
                            "api" = @{
                                        "knownClientApplications" = ""
                                        "requestedAccessTokenVersion" = $null
                                        "preAuthorizedApplications" = ""
                                        "oauth2PermissionScopes" = $null
                                        "acceptMappedClaims" = $null
                                    }
                            "appRoles" = $null
                            "description" = $null
                            "signInAudience" = "AzureADMyOrg"
                            "appId" = "aaaaaaaa-3333-1111-1111-cccccccccccc"
                        }
    }

    Mock -CommandName Invoke-MgGraphRequest -MockWith { $response } -ModuleName Microsoft.Graph.Entra
}
Describe "New-EntraApplicationFromApplicationTemplateFromApplicationTemplate tests"{
    It "Should return created Application with service principal"{
        $result = New-EntraApplicationFromApplicationTemplate -Id "aaaaaaaa-1111-1111-1111-cccccccccccc" -DisplayName "test app"
        $result | Should -Not -BeNullOrEmpty
        $result.application.applicationTemplateId | Should -Be "aaaaaaaa-1111-1111-1111-cccccccccccc"
        $result.servicePrincipal.applicationTemplateId | Should -Be "aaaaaaaa-1111-1111-1111-cccccccccccc"
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Graph.Entra -Times 1
    }
    It "Should fail when Id is empty" {
        { New-EntraApplicationFromApplicationTemplate -Id "" } | Should -Throw "Cannot bind argument to parameter 'Id'*"
    }
    It "Should fail when Id is null" {
        { New-EntraApplicationFromApplicationTemplate -Id  } | Should -Throw "Missing an argument for parameter 'Id'.*"
    }
    It "Should fail when DisplayName is empty" {
        { New-EntraApplicationFromApplicationTemplate -DisplayName "" } | Should -Throw "Cannot bind argument to parameter 'DisplayName'*"
    }
    It "Should fail when DisplayName is null" {
        { New-EntraApplicationFromApplicationTemplate -DisplayName  } | Should -Throw "Missing an argument for parameter 'DisplayName'.*"
    }
    It "Should fail when invalid parameter is passed" {
        { New-EntraApplicationFromApplicationTemplate -xyz } | Should -Throw "A parameter cannot be found that matches parameter name 'xyz'*"
    }
}