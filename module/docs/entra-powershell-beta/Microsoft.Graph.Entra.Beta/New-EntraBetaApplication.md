---
title: New-EntraBetaApplication
description: This article provides details on the New-EntraBetaApplication command.

ms.service: active-directory
ms.topic: reference
ms.date: 17/06/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# New-EntraBetaApplication

## SYNOPSIS

Creates an application.

## SYNTAX

```powershell
New-EntraBetaApplication 
 -DisplayName <String> 
 [-AddIns <System.Collections.Generic.List`1[Microsoft.Open.AzureAD.Model.AddIn]>]
 [-SignInAudience <String>] 
 [-Oauth2AllowImplicitFlow <Boolean>]
 [-ReplyUrls <System.Collections.Generic.List`1[System.String]>] 
 [-WwwHomepage <String>] 
 [-IsDisabled <Boolean>] 
 [-AllowGuestsSignIn <Boolean>] 
 [-PublisherDomain <String>]
 [-OrgRestrictions <System.Collections.Generic.List`1[System.String]>] 
 [-OptionalClaims <OptionalClaims>]
 [-ParentalControlSettings <ParentalControlSettings>] 
 [-Oauth2AllowUrlPathMatching <Boolean>]
 [-KeyCredentials <System.Collections.Generic.List`1[Microsoft.Open.AzureAD.Model.KeyCredential]>]
 [-IdentifierUris <System.Collections.Generic.List`1[System.String]>] 
 [-GroupMembershipClaims <String>]
 [-Oauth2Permissions <System.Collections.Generic.List`1[Microsoft.Open.AzureAD.Model.OAuth2Permission]>]
 [-LogoutUrl <String>] 
 [-ErrorUrl <String>] 
 [-SamlMetadataUrl <String>] 
 [-IsDeviceOnlyAuthSupported <Boolean>]
 [-PreAuthorizedApplications <System.Collections.Generic.List`1[Microsoft.Open.AzureAD.Model.PreAuthorizedApplication]>]
 [-AvailableToOtherTenants <Boolean>]
 [-KnownClientApplications <System.Collections.Generic.List`1[System.String]>]
 [-AllowPassthroughUsers <Boolean>]
 [-RequiredResourceAccess <System.Collections.Generic.List`1[Microsoft.Open.AzureAD.Model.RequiredResourceAccess]>]
 [-PublicClient <Boolean>] 
 [-RecordConsentConditions <String>] 
 [-Oauth2RequirePostResponse <Boolean>]
 [-AppLogoUrl <String>]
 [-PasswordCredentials <System.Collections.Generic.List`1[Microsoft.Open.AzureAD.Model.PasswordCredential]>]
 [-Homepage <String>] 
 [-AppRoles <System.Collections.Generic.List`1[Microsoft.Open.AzureAD.Model.AppRole]>]
 [-InformationalUrls <InformationalUrl>] 
 [<CommonParameters>]
```

## DESCRIPTION

The `New-EntraBetaApplication` cmdlet creates an application in Microsoft Entra ID. Specify the `DisplayName` parameter to create new application.

## EXAMPLES

### Example 1: Create an application

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All'
New-EntraBetaApplication -DisplayName 'My new application'
```

```output
ObjectId                             AppId                                DisplayName 
--------                             -----                                ----------- 
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb bbbbbbbb-1111-2222-3333-cccccccccccc
 My new application
```

This command creates an application in Microsoft Entra ID.

### Example 2: Create an application with '-IdentifierUris' parameter

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All'
New-EntraBetaApplication -DisplayName 'My new application' -IdentifierUris 'https://mynewapp.contoso.com'
```

```output
ObjectId                             AppId                                DisplayName 
--------                             -----                                ----------- 
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb bbbbbbbb-1111-2222-3333-cccccccccccc
 My new application
```

This example shows how to create an application having `-IdentifierUris` parameter.  

This command creates an application in Microsoft Entra ID.  

### Example 3: Create an application with '-HomePage' parameter

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All'
New-EntraBetaApplication -DisplayName 'My new application' -HomePage 'https://mynewapp.home.com'
```

```output
ObjectId                             AppId                                DisplayName 
--------                             -----                                ----------- 
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb bbbbbbbb-1111-2222-3333-cccccccccccc
 My new application
```

This example shows how to create an application having `-HomePage` parameter.  

This command creates an application in Microsoft Entra ID.  

### Example 4: Create an application with '-LogoutUrl' parameter

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All'
New-EntraBetaApplication -DisplayName 'My new application' -LogoutUrl 'https://mynewapp.com/logout.aspx'
```

```output
ObjectId                             AppId                                DisplayName 
--------                             -----                                ----------- 
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb bbbbbbbb-1111-2222-3333-cccccccccccc
 My new application
```

This example shows how to create an application having `-LogoutUrl` parameter.  

This command creates an application in Microsoft Entra ID.  

### Example 5: Create an application with '-IsDeviceOnlyAuthSupported' parameter

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All'
New-EntraBetaApplication -DisplayName 'My new application' -IsDeviceOnlyAuthSupported $false
```

```output
ObjectId                             AppId                                DisplayName 
--------                             -----                                ----------- 
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb bbbbbbbb-1111-2222-3333-cccccccccccc
 My new application
```

This example shows how to create an application having `-IsDeviceOnlyAuthSupported` parameter.  

This command creates an application in Microsoft Entra ID.  

## PARAMETERS

### -AddIns

Defines custom behavior that a consuming service can use to call an app in specific contexts.
For example, applications that can render file streams might set the addIns property for its "FileHandler" functionality.
This lets services like Office 365 call the application in the context of a document the user is working on.

```yaml
Type: System.Collections.Generic.List`1[Microsoft.Open.AzureAD.Model.AddIn]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AppRoles

The collection of application roles that an application might declare.
These roles can be assigned to users, groups, or service principals.

```yaml
Type: System.Collections.Generic.List`1[Microsoft.Open.AzureAD.Model.AppRole]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AvailableToOtherTenants

Indicates whether this application is available in other tenants.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DisplayName

Specifies the display name of the application.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ErrorUrl

The Error URL of this application.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -GroupMembershipClaims

A bitmask that configures the "groups" claim issued in a user or OAuth 2.0 access token that the application expects.
The bitmask values are: 0: None, 1: Security groups and Microsoft Entra ID roles, 2: Reserved, and 4: Reserved.
Setting the bitmask to 7 gets all of the security groups, distribution groups, and Microsoft Entra ID roles that the signed-in user is a member of.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Homepage

The URL to the application's homepage.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IdentifierUris

User-defined URIs that uniquely identify a Web application within its Microsoft Entra ID tenant, or within a verified custom domain (see "Domains" tab in the Azure classic portal) if the application is multitenant.

The first element is populated from the Web application's "APP ID URI" field if updated via the Azure classic portal (or respective Microsoft Entra ID PowerShell cmdlet parameter).
More URIs can be added via the application manifest; see Understanding the Microsoft Entra ID Application Manifest for details.
This collection is also used to populate the Web application's servicePrincipalNames collection.

```yaml
Type: System.Collections.Generic.List`1[System.String]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -KeyCredentials

The collection of key credentials associated with the application.

```yaml
Type: System.Collections.Generic.List`1[Microsoft.Open.AzureAD.Model.KeyCredential]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -KnownClientApplications

Client applications that are tied to this resource application.
Consent to any of the known client applications result in implicit consent to the resource application through a combined consent dialog (showing the OAuth permission scopes required by the client and the resource).

```yaml
Type: System.Collections.Generic.List`1[System.String]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -LogoutUrl

The logout url for this application.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Oauth2AllowImplicitFlow

Specifies whether this web application can request OAuth2.0 implicit flow tokens.
The default is false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Oauth2AllowUrlPathMatching

Specifies whether, as part of OAuth 2.0 token requests, Microsoft Entra ID allows path matching of the redirect URI against the application's replyUrls.
The default is false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Oauth2Permissions

The collection of OAuth 2.0 permission scopes that the web API (resource) application exposes to client applications.
These permission scopes might be granted to client applications during consent.

```yaml
Type: System.Collections.Generic.List`1[Microsoft.Open.AzureAD.Model.OAuth2Permission]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PasswordCredentials

The collection of password credentials associated with the application.

```yaml
Type: System.Collections.Generic.List`1[Microsoft.Open.AzureAD.Model.PasswordCredential]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PublicClient

Specifies whether this application is a public client (such as an installed application running on a mobile device).
Default is false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RecordConsentConditions

Don't use.
Might be removed in future versions.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ReplyUrls

Specifies the URLs that user tokens are sent to for sign in, or the redirect URIs that OAuth 2.0 authorization codes and access tokens are sent to.

```yaml
Type: System.Collections.Generic.List`1[System.String]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RequiredResourceAccess

Specifies resources that this application requires access to and the set of OAuth permission scopes and application roles that it needs under each of those resources.
This preconfiguration of required resource access drives the consent experience.

```yaml
Type: System.Collections.Generic.List`1[Microsoft.Open.AzureAD.Model.RequiredResourceAccess]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SamlMetadataUrl

The URL to the SAML metadata for the application.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Oauth2RequirePostResponse

Set this variable to true if an Oauth2 post response is required.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AllowGuestsSignIn

Sets a property on the application to indicate if the application accepts other IDPs or not or partially accepts.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AllowPassthroughUsers

Sets indicate that the application supports pass through users who have no presence in the resource tenant.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AppLogoUrl

Sets the url for the application logo image stored in a CDN.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InformationalUrls

Basic profile information of the application such as app's marketing, support, terms of service and privacy statement URLs. The terms of service and privacy statement are surfaced to users through the user consent experience.

```yaml
Type: System.InformationalUrl
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IsDeviceOnlyAuthSupported

Specifies if the application supports authentication using a device token.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IsDisabled

Enables or disables the application.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -OptionalClaims

Application developers can configure optional claims in their Microsoft Entra ID apps to specify which claims they want in tokens sent to their application by the Microsoft security token service.

```yaml
Type: System.OptionalClaims
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -OrgRestrictions

Sets a list of tenants allowed to access application.

```yaml
Type: System.Collections.Generic.List`1[System.String]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ParentalControlSettings

Specifies parental control settings for an application.

```yaml
Type: System.ParentalControlSettings
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PreAuthorizedApplications

Sets list of pre-authorized applications.

```yaml
Type: System.Collections.Generic.List`1[Microsoft.Open.AzureAD.Model.PreAuthorizedApplication]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PublisherDomain

Sets reliable domain, which can be used to identify an application.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SignInAudience

Sets audience for signing in to the application.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WwwHomepage

Sets the primary Web page.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraBetaApplication](Get-EntraBetaApplication.md)

[Remove-EntraBetaApplication](Remove-EntraBetaApplication.md)

[Set-EntraBetaApplication](Set-EntraBetaApplication.md)
