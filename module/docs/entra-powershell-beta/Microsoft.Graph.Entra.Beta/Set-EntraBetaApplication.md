---
title: Set-EntraBetaApplication
description: This article provides details on the Set-EntraBetaApplication command.

ms.service: entra
ms.topic: reference
ms.date: 06/17/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Set-EntraBetaApplication

## SYNOPSIS

Updates an application.

## SYNTAX

```powershell
Set-EntraBetaApplication 
 -ObjectId <String> 
 [-AddIns <System.Collections.Generic.List`1[Microsoft.Open.AzureAD.Model.AddIn]>]
 [-SignInAudience <String>] 
 [-Oauth2AllowImplicitFlow <Boolean>]
 [-ReplyUrls <System.Collections.Generic.List`1[System.String]>] 
 [-WwwHomepage <String>]
 [-DisplayName <String>] 
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

Updates an application. Specify the `ObjectId` parameter to update a  specific application.

## EXAMPLES

### Example 1: Update '-DisplayName' of an application

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All'
Set-EntraBetaApplication -ObjectId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb' -DisplayName 'New Name'
```

This command updates the `-DisplayName` of the specified application.  

### Example 2: Update '-SamlMetadataUrl' of an application

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All'
Set-EntraBetaApplication -ObjectId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb' -SamlMetadataUrl 'https://contoso.com'
```

This command updates the `-SamlMetadataUrl` of the specified application.  

### Example 3: Update '-LogoutUrl' of an application

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All'
Set-EntraBetaApplication -ObjectId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb' -LogoutUrl 'https://contoso.com/Security/ADFS.aspx/logout'
```

This command updates the `-LogoutUrl` of the specified application.  

### Example 4: Update '-GroupMembershipClaims' of an application

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All'
Set-EntraBetaApplication -ObjectId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb' -GroupMembershipClaims '2'
```

This command updates the `-GroupMembershipClaims` of the specified application.  

### Example 5: Update '-IdentifierUris' of an application

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All'
Set-EntraBetaApplication -ObjectId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb' -IdentifierUris 'https://demomail.contoso.com'
```

This command updates the `-IdentifierUris` of the specified application.  

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

True if the application is shared with other tenants; otherwise, false.

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

Specifies the display name.

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

### -ErrorUrl

Specifies an error URL.

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

Specifies identifier Uniform Resource Identifiers (UIRs).

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

Specifies key credentials.

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

Specifies known client applications.

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

Specifies the logout URL.

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

### -ObjectId

Specifies the ID of an application in Microsoft Entra ID.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -PasswordCredentials

Specifies password credentials.

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
May be removed in future versions

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

The URL to the Security Assertion Markup Language (SAML) metadata for the application.

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

Sets list of preauthorized applications.

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

[New-EntraBetaApplication](New-EntraBetaApplication.md)

[Remove-EntraBetaApplication](Remove-EntraBetaApplication.md)
