---
title: Get-EntraBetaMSApplication
description: This article provides details on the Get-EntraBetaMSApplication command.

ms.service: entra
ms.subservice: powershell
ms.topic: reference
ms.date: 02/29/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Get-EntraBetaMSApplication

## SYNOPSIS
Retrieves the list of applications within the organization.

## SYNTAX

### GetQuery (Default)
```powershell
Get-EntraBetaMSApplication 
    [-Filter <String>] 
    [-All <Boolean>] 
    [-Top <Int32>] 
 [<CommonParameters>]
```

### GetVague
```powershell
Get-EntraBetaMSApplication 
    [-SearchString <String>] 
    [-All <Boolean>] 
 [<CommonParameters>]
```

### GetById
```powershell
Get-EntraBetaMSApplication 
    -ObjectId <String> 
    [-All <Boolean>] 
 [<CommonParameters>]
```

## DESCRIPTION
Retrieves the list of applications within the organization.
With an ObjectId argument, it can retrieve the properties of the application object associated with the ObjectId.

## EXAMPLES

### Example 1: Get an application by display name
```powershell
PS C:\>Get-EntraBetaMSApplication -Filter "DisplayName eq 'My App'"
```

```output
Id                        : ba4a97a7-3815-4752-bf4c-f1c0cccfff6a
OdataType                 :
Api                       : class ApiApplication {
                                AcceptMappedClaims:
                                KnownClientApplications:
                                PreAuthorizedApplications:
                                RequestedAccessTokenVersion: 2
                                Oauth2PermissionScopes:
                                System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.PermissionScope]
                            }

AppId                     : 807dd73f-8451-4cfa-b3bc-52ac3fd95330
AppRoles                  : {}
IsDeviceOnlyAuthSupported :
IsFallbackPublicClient    :
IdentifierUris            : {}
DeletedDateTime           :
DisplayName               : My App
Info                      : class InformationalUrl {
                                TermsOfServiceUrl:
                                MarketingUrl:
                                PrivacyStatementUrl:
                                SupportUrl:
                                LogoUrl:
                            }

KeyCredentials            : {}
OptionalClaims            :
ParentalControlSettings   : class ParentalControlSettings {
                                CountriesBlockedForMinors: System.Collections.Generic.List`1[System.String]
                                LegalAgeGroupRule: Allow
                            }

PasswordCredentials       : {}
PublicClientApplication   :
RequiredResourceAccess    : {}
SignInAudience            : AzureADandPersonalMicrosoftAccount
Tags                      : {}
TokenEncryptionKeyId      :
Web                       : class WebApplication {
                                LogoutUrl:
                                Oauth2AllowImplicitFlow:
                                RedirectUris: System.Collections.Generic.List`1[System.String]
                                ImplicitGrantSettings: class ImplicitGrantSettings {
                                    EnableIdTokenIssuance: False
                                    EnableAccessTokenIssuance: False
                                }
                            }
```

This command gets an application by its display name.

### Example 2: Get an application by ID
```powershell
PS C:\>Get-EntraBetaMSApplication -Filter "AppId eq '807dd73f-8451-4cfa-b3bc-52ac3fd95330'"
```

```output
Id                        : ba4a97a7-3815-4752-bf4c-f1c0cccfff6a
OdataType                 :
Api                       : class ApiApplication {
                                AcceptMappedClaims:
                                KnownClientApplications:
                                PreAuthorizedApplications:
                                RequestedAccessTokenVersion: 2
                                Oauth2PermissionScopes:
                                System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.PermissionScope]
                            }

AppId                     : 807dd73f-8451-4cfa-b3bc-52ac3fd95330
AppRoles                  : {}
IsDeviceOnlyAuthSupported :
IsFallbackPublicClient    :
IdentifierUris            : {}
DeletedDateTime           :
DisplayName               : My App
Info                      : class InformationalUrl {
                                TermsOfServiceUrl:
                                MarketingUrl:
                                PrivacyStatementUrl:
                                SupportUrl:
                                LogoUrl:
                            }

KeyCredentials            : {}
OptionalClaims            :
ParentalControlSettings   : class ParentalControlSettings {
                                CountriesBlockedForMinors: System.Collections.Generic.List`1[System.String]
                                LegalAgeGroupRule: Allow
                            }

PasswordCredentials       : {}
PublicClientApplication   :
RequiredResourceAccess    : {}
SignInAudience            : AzureADandPersonalMicrosoftAccount
Tags                      : {}
TokenEncryptionKeyId      :
Web                       : class WebApplication {
                                LogoutUrl:
                                Oauth2AllowImplicitFlow:
                                RedirectUris: System.Collections.Generic.List`1[System.String]
                                ImplicitGrantSettings: class ImplicitGrantSettings {
                                    EnableIdTokenIssuance: False
                                    EnableAccessTokenIssuance: False
                                }
                            }
```

This command gets an application by its ID.

### Example 3: Retrieve an application by identifierUris
```powershell
Get-EntraBetaMSApplication -Filter "identifierUris/any(uri:uri eq 'https://wingtips.wingtiptoysonline.com')"
```

```output
Id                        : ba4a97a7-3815-4752-bf4c-f1c0cccfff6a
OdataType                 :
Api                       : class ApiApplication {
                                AcceptMappedClaims:
                                KnownClientApplications:
                                PreAuthorizedApplications:
                                RequestedAccessTokenVersion: 2
                                Oauth2PermissionScopes:
                                System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.PermissionScope]
                            }

AppId                     : 807dd73f-8451-4cfa-b3bc-52ac3fd95330
AppRoles                  : {}
IsDeviceOnlyAuthSupported :
IsFallbackPublicClient    :
IdentifierUris            : {
                                https://wingtips.wingtiptoysonline.com
                            }
DeletedDateTime           :
DisplayName               : My App
Info                      : class InformationalUrl {
                                TermsOfServiceUrl:
                                MarketingUrl:
                                PrivacyStatementUrl:
                                SupportUrl:
                                LogoUrl:
                            }

KeyCredentials            : {}
OptionalClaims            :
ParentalControlSettings   : class ParentalControlSettings {
                                CountriesBlockedForMinors: System.Collections.Generic.List`1[System.String]
                                LegalAgeGroupRule: Allow
                            }

PasswordCredentials       : {}
PublicClientApplication   :
RequiredResourceAccess    : {}
SignInAudience            : AzureADandPersonalMicrosoftAccount
Tags                      : {}
TokenEncryptionKeyId      :
Web                       : class WebApplication {
                                LogoutUrl:
                                Oauth2AllowImplicitFlow:
                                RedirectUris: System.Collections.Generic.List`1[System.String]
                                ImplicitGrantSettings: class ImplicitGrantSettings {
                                    EnableIdTokenIssuance: False
                                    EnableAccessTokenIssuance: False
                                }
                            }
```

This command gets an application by its IdentifierUris.

### Example 4: Get an application by object ID
```powershell
PS C:\>Get-EntraBetaMSApplication -ObjectId ba4a97a7-3815-4752-bf4c-f1c0cccfff6a
```

```output
Id                        : ba4a97a7-3815-4752-bf4c-f1c0cccfff6a
OdataType                 :
Api                       : class ApiApplication {
                                AcceptMappedClaims:
                                KnownClientApplications:
                                PreAuthorizedApplications:
                                RequestedAccessTokenVersion: 2
                                Oauth2PermissionScopes:
                                System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.PermissionScope]
                            }

AppId                     : 807dd73f-8451-4cfa-b3bc-52ac3fd95330
AppRoles                  : {}
IsDeviceOnlyAuthSupported :
IsFallbackPublicClient    :
IdentifierUris            : {}
DeletedDateTime           :
DisplayName               : My App
Info                      : class InformationalUrl {
                                TermsOfServiceUrl:
                                MarketingUrl:
                                PrivacyStatementUrl:
                                SupportUrl:
                                LogoUrl:
                            }

KeyCredentials            : {}
OptionalClaims            :
ParentalControlSettings   : class ParentalControlSettings {
                                CountriesBlockedForMinors: System.Collections.Generic.List`1[System.String]
                                LegalAgeGroupRule: Allow
                            }

PasswordCredentials       : {}
PublicClientApplication   :
RequiredResourceAccess    : {}
SignInAudience            : AzureADandPersonalMicrosoftAccount
Tags                      : {}
TokenEncryptionKeyId      :
Web                       : class WebApplication {
                                LogoutUrl:
                                Oauth2AllowImplicitFlow:
                                RedirectUris: System.Collections.Generic.List`1[System.String]
                                ImplicitGrantSettings: class ImplicitGrantSettings {
                                    EnableIdTokenIssuance: False
                                    EnableAccessTokenIssuance: False
                                }
                            }
```

This command gets an application by its object ID.

### Example 5: Get the first two applications
```powershell
PS C:\>Get-EntraBetaMSApplication -Top 2
```

```output
Id                        : ba4a97a7-3815-4752-bf4c-f1c0cccfff6a
OdataType                 :
Api                       : class ApiApplication {
                                AcceptMappedClaims:
                                KnownClientApplications:
                                PreAuthorizedApplications:
                                RequestedAccessTokenVersion: 2
                                Oauth2PermissionScopes:
                                System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.PermissionScope]
                            }

AppId                     : 807dd73f-8451-4cfa-b3bc-52ac3fd95330
AppRoles                  : {}
IsDeviceOnlyAuthSupported :
IsFallbackPublicClient    :
IdentifierUris            : {}
DeletedDateTime           :
DisplayName               : My App
Info                      : class InformationalUrl {
                                TermsOfServiceUrl:
                                MarketingUrl:
                                PrivacyStatementUrl:
                                SupportUrl:
                                LogoUrl:
                            }

KeyCredentials            : {}
OptionalClaims            :
ParentalControlSettings   : class ParentalControlSettings {
                                CountriesBlockedForMinors: System.Collections.Generic.List`1[System.String]
                                LegalAgeGroupRule: Allow
                            }

PasswordCredentials       : {}
PublicClientApplication   :
RequiredResourceAccess    : {}
SignInAudience            : AzureADandPersonalMicrosoftAccount
Tags                      : {}
TokenEncryptionKeyId      :
Web                       : class WebApplication {
                                LogoutUrl:
                                Oauth2AllowImplicitFlow:
                                RedirectUris: System.Collections.Generic.List`1[System.String]
                                ImplicitGrantSettings: class ImplicitGrantSettings {
                                    EnableIdTokenIssuance: False
                                    EnableAccessTokenIssuance: False
                                }
                            }

Id                        : d27bb37d-e1c0-4298-8308-ee5c239c0e3f
OdataType                 :
Api                       : class ApiApplication {
                                AcceptMappedClaims:
                                KnownClientApplications:
                                PreAuthorizedApplications:
                                RequestedAccessTokenVersion: 2
                                Oauth2PermissionScopes:
                                System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.PermissionScope]
                            }

AppId                     : d9d4567d-6b71-4c58-b1ac-decbeb28c3b8
AppRoles                  : {}
IsDeviceOnlyAuthSupported :
IsFallbackPublicClient    :
IdentifierUris            : {}
DeletedDateTime           :
DisplayName               : My App
Info                      : class InformationalUrl {
                                TermsOfServiceUrl:
                                MarketingUrl:
                                PrivacyStatementUrl:
                                SupportUrl:
                                LogoUrl:
                            }

KeyCredentials            : {}
OptionalClaims            :
ParentalControlSettings   : class ParentalControlSettings {
                                CountriesBlockedForMinors: System.Collections.Generic.List`1[System.String]
                                LegalAgeGroupRule: Allow
                            }

PasswordCredentials       : {}
PublicClientApplication   :
RequiredResourceAccess    : {}
SignInAudience            : AzureADandPersonalMicrosoftAccount
Tags                      : {}
TokenEncryptionKeyId      :
Web                       : class WebApplication {
                                LogoutUrl:
                                Oauth2AllowImplicitFlow:
                                RedirectUris: System.Collections.Generic.List`1[System.String]
                                ImplicitGrantSettings: class ImplicitGrantSettings {
                                    EnableIdTokenIssuance: False
                                    EnableAccessTokenIssuance: False
                                }
                            }                            
```

This command gets the first two applications.

### Example 6: Retrieve a list of all applications
```powershell
PS C:\>Get-EntraBetaMSApplication -All $true
```

```output
Id                        : ba4a97a7-3815-4752-bf4c-f1c0cccfff6a
OdataType                 :
Api                       : class ApiApplication {
                                AcceptMappedClaims:
                                KnownClientApplications:
                                PreAuthorizedApplications:
                                RequestedAccessTokenVersion: 2
                                Oauth2PermissionScopes:
                                System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.PermissionScope]
                            }

AppId                     : 807dd73f-8451-4cfa-b3bc-52ac3fd95330
AppRoles                  : {}
IsDeviceOnlyAuthSupported :
IsFallbackPublicClient    :
IdentifierUris            : {}
DeletedDateTime           :
DisplayName               : My App
Info                      : class InformationalUrl {
                                TermsOfServiceUrl:
                                MarketingUrl:
                                PrivacyStatementUrl:
                                SupportUrl:
                                LogoUrl:
                            }

KeyCredentials            : {}
OptionalClaims            :
ParentalControlSettings   : class ParentalControlSettings {
                                CountriesBlockedForMinors: System.Collections.Generic.List`1[System.String]
                                LegalAgeGroupRule: Allow
                            }

PasswordCredentials       : {}
PublicClientApplication   :
RequiredResourceAccess    : {}
SignInAudience            : AzureADandPersonalMicrosoftAccount
Tags                      : {}
TokenEncryptionKeyId      :
Web                       : class WebApplication {
                                LogoutUrl:
                                Oauth2AllowImplicitFlow:
                                RedirectUris: System.Collections.Generic.List`1[System.String]
                                ImplicitGrantSettings: class ImplicitGrantSettings {
                                    EnableIdTokenIssuance: False
                                    EnableAccessTokenIssuance: False
                                }
                            }

Id                        : d27bb37d-e1c0-4298-8308-ee5c239c0e3f
OdataType                 :
Api                       : class ApiApplication {
                                AcceptMappedClaims:
                                KnownClientApplications:
                                PreAuthorizedApplications:
                                RequestedAccessTokenVersion: 2
                                Oauth2PermissionScopes:
                                System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.PermissionScope]
                            }

AppId                     : d9d4567d-6b71-4c58-b1ac-decbeb28c3b8
AppRoles                  : {}
IsDeviceOnlyAuthSupported :
IsFallbackPublicClient    :
IdentifierUris            : {}
DeletedDateTime           :
DisplayName               : My App
Info                      : class InformationalUrl {
                                TermsOfServiceUrl:
                                MarketingUrl:
                                PrivacyStatementUrl:
                                SupportUrl:
                                LogoUrl:
                            }

KeyCredentials            : {}
OptionalClaims            :
ParentalControlSettings   : class ParentalControlSettings {
                                CountriesBlockedForMinors: System.Collections.Generic.List`1[System.String]
                                LegalAgeGroupRule: Allow
                            }

PasswordCredentials       : {}
PublicClientApplication   :
RequiredResourceAccess    : {}
SignInAudience            : AzureADandPersonalMicrosoftAccount
Tags                      : {}
TokenEncryptionKeyId      :
Web                       : class WebApplication {
                                LogoutUrl:
                                Oauth2AllowImplicitFlow:
                                RedirectUris: System.Collections.Generic.List`1[System.String]
                                ImplicitGrantSettings: class ImplicitGrantSettings {
                                    EnableIdTokenIssuance: False
                                    EnableAccessTokenIssuance: False
                                }
                            }                            
```

This command gets all the applications.

### Example 7: Retrieve a list of all applications, which have a display name that contains "asdfl"
```powershell
PS C:\>Get-EntraBetaMSApplication -SearchString asdfl
```

```output
Id                        : d27bb37d-e1c0-4298-8308-ee5c239c0e3f
OdataType                 :
Api                       : class ApiApplication {
                                AcceptMappedClaims:
                                KnownClientApplications:
                                PreAuthorizedApplications:
                                RequestedAccessTokenVersion: 2
                                Oauth2PermissionScopes:
                                System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.PermissionScope]
                            }

AppId                     : d9d4567d-6b71-4c58-b1ac-decbeb28c3b8
AppRoles                  : {}
IsDeviceOnlyAuthSupported :
IsFallbackPublicClient    :
IdentifierUris            : {}
DeletedDateTime           :
DisplayName               : asdflfgh
Info                      : class InformationalUrl {
                                TermsOfServiceUrl:
                                MarketingUrl:
                                PrivacyStatementUrl:
                                SupportUrl:
                                LogoUrl:
                            }

KeyCredentials            : {}
OptionalClaims            :
ParentalControlSettings   : class ParentalControlSettings {
                                CountriesBlockedForMinors: System.Collections.Generic.List`1[System.String]
                                LegalAgeGroupRule: Allow
                            }

PasswordCredentials       : {}
PublicClientApplication   :
RequiredResourceAccess    : {}
SignInAudience            : AzureADandPersonalMicrosoftAccount
Tags                      : {}
TokenEncryptionKeyId      :
Web                       : class WebApplication {
                                LogoutUrl:
                                Oauth2AllowImplicitFlow:
                                RedirectUris: System.Collections.Generic.List`1[System.String]
                                ImplicitGrantSettings: class ImplicitGrantSettings {
                                    EnableIdTokenIssuance: False
                                    EnableAccessTokenIssuance: False
                                }
                            } 
```

This command gets a list of applications, which have the specified display name.

## PARAMETERS

### -ObjectId
Specifies the ID of an application in Microsoft Entra ID

```yaml
Type: String
Parameter Sets: GetById
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -All
If true, return all applications.
If false, return the number of objects specified by the Top parameter.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Top
Specifies the maximum number of records to return.

```yaml
Type: Int32
Parameter Sets: GetQuery
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Filter
Specifies an oData v3.0 filter statement.
This parameter controls which objects are returned.

```yaml
Type: String
Parameter Sets: GetQuery
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -SearchString
Retrieve only those applications that satisfy the -SearchString value.

```yaml
Type: String
Parameter Sets: GetVague
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### Bool?
### Int?
### String
## OUTPUTS

### Microsoft.Open.MSGraph.Model.MsApplication
## NOTES

## RELATED LINKS

[New-EntraMSApplication](New-EntraMSApplication.md)

[Remove-EntraMSApplication](Remove-EntraMSApplication.md)

[Set-EntraMSApplication](Set-EntraMSApplication.md)

