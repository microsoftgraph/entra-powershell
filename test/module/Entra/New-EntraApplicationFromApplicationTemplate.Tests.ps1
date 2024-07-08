BeforeAll{

    $response = @{
        "@odata.context"   =  'https://graph.microsoft.com/v1.0/$metadata#microsoft.graph.applicationServicePrincipal'
        "servicePrincipal" =  @{
                                 "oauth2PermissionScopes" = $null
                                 "servicePrincipalType" = "Application"
                                 "displayName" = "teesttt1"
                                 "passwordCredentials" = $null
                                 "deletedDateTime" = $null
                                 "alternativeNames" = $null
                                 "homepage" = "https://*.e-days.com/SSO/SAML2/SP/AssertionConsumer.aspx?metadata=e-days|ISV9.2|primary|z"
                                 "applicationTemplateId" = "2b80826f-df72-4e85-8808-117254f20c24"
                                 "appRoleAssignmentRequired" = $true
                                 "servicePrincipalNames" = $null
                                 "keyCredentials" = $null
                                 "appOwnerOrganizationId" = "d5aec55f-2d12-4442-8d2f-ccca95d4390e"
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
                                 "appDisplayName" = "teesttt1"
                                 "id" = "8495716b-6923-4a2e-9d6c-ed2281b289ae"
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
                                 "appId" = "36ff55d1-4705-4a9e-9b5a-88bc08de40a5"
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
                            "displayName" = "teesttt1"
                            "applicationTemplateId" = "2b80826f-df72-4e85-8808-117254f20c24"
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
                            "id" = "c20f5b07-ad61-456e-b478-280c78f0a7e9"
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
                            "appId" = "36ff55d1-4705-4a9e-9b5a-88bc08de40a5"
                        }
    }
}