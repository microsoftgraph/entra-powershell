---
title: Set-EntraApplication
description: This article provides details on the Set-EntraApplication command.

ms.service: active-directory
ms.topic: reference
ms.date: 03/13/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Set-EntraApplication

## SYNOPSIS
Updates an application.

## SYNTAX

```powershell
Set-EntraApplication 
    -ObjectId <String> 
    [-PublisherDomain <String>] 
    [-OptionalClaims <OptionalClaims>]
    [-ErrorUrl <String>] 
    [-AppRoles <System.Collections.Generic.List`1[Microsoft.Open.AzureAD.Model.AppRole]>]
    [-Homepage <String>] 
    [-IsDisabled <Boolean>] 
    [-AvailableToOtherTenants <Boolean>]
    [-Oauth2AllowImplicitFlow <Boolean>] 
    [-InformationalUrls <InformationalUrl>] 
    [-SamlMetadataUrl <String>]
    [-PublicClient <Boolean>] 
    [-LogoutUrl <String>]
    [-RequiredResourceAccess <System.Collections.Generic.List`1[Microsoft.Open.AzureAD.Model.RequiredResourceAccess]>]
    [-Oauth2Permissions <System.Collections.Generic.List`1[Microsoft.Open.AzureAD.Model.OAuth2Permission]>]
    [-ReplyUrls <System.Collections.Generic.List`1[System.String]>] 
    [-GroupMembershipClaims <String>]
    [-IdentifierUris <System.Collections.Generic.List`1[System.String]>] 
    [-IsDeviceOnlyAuthSupported <Boolean>]
    [-AppLogoUrl <String>] 
    [-WwwHomepage <String>]
    [-OrgRestrictions <System.Collections.Generic.List`1[System.String]>]
    [-PasswordCredentials <System.Collections.Generic.List`1[Microsoft.Open.AzureAD.Model.PasswordCredential]>]
    [-Oauth2AllowUrlPathMatching <Boolean>]
    [-PreAuthorizedApplications <System.Collections.Generic.List`1[Microsoft.Open.AzureAD.Model.PreAuthorizedApplication]>]
    [-ParentalControlSettings <ParentalControlSettings>] 
    [-DisplayName <String>]
    [-Oauth2RequirePostResponse <Boolean>] 
    [-AllowGuestsSignIn <Boolean>]
    [-KeyCredentials <System.Collections.Generic.List`1[Microsoft.Open.AzureAD.Model.KeyCredential]>]
    [-SignInAudience <String>] 
    [-AddIns <System.Collections.Generic.List`1[Microsoft.Open.AzureAD.Model.AddIn]>]
    [-KnownClientApplications <System.Collections.Generic.List`1[System.String]>]
    [-RecordConsentConditions <String>] 
    [-AllowPassthroughUsers <Boolean>] 
    [<CommonParameters>]
```

## DESCRIPTION

## EXAMPLES

### Example 1: Update display name of an application
```powershell
PS C:\>Set-EntraApplication -ObjectId "3ddd22e7-a150-4bb3-b100-e410dea1cb84" -DisplayName "New Name"
```

This command updates the display name of the specified application.  

### Example 2: Update saml metadata url of an application
```powershell
PS C:\>Set-EntraApplication -ObjectId "3ddd22e7-a150-4bb3-b100-e410dea1cb84" -SamlMetadataUrl 'https://contoso.com'
```

This command updates the saml metadata url of the specified application.  

### Example 3: Update log out url of an application
```powershell
PS C:\>Set-EntraApplication -ObjectId "3ddd22e7-a150-4bb3-b100-e410dea1cb84" -LogoutUrl 'https://contoso.com/Security/ADFS.aspx/logout'
```

This command updates the log out url of the specified application.  

### Example 4: Update group membership claims of an application
```powershell
PS C:\>Set-EntraApplication -ObjectId "3ddd22e7-a150-4bb3-b100-e410dea1cb84" -GroupMembershipClaims '2'
```

This command updates the group membership claims of the specified application.  

### Example 5: Update identifier uris of an application
```powershell
PS C:\>Set-EntraApplication -ObjectId "3ddd22e7-a150-4bb3-b100-e410dea1cb84" -IdentifierUris "https://demomail.contoso.com"
```

This command updates the identifier uris of the specified application.  

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
Type: Boolean
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
Type: String
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
Type: String
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
Setting the bitmask to 7 gets all of the security groups, distribution groups, and Microsoft Entra ID directory roles that the signed-in user is a member of.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Homepage
Specifies the home page.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IdentifierUris
Specifies identifier URIs.

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
Type: String
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
Type: Boolean
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
Type: Boolean
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
Type: String
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
Type: Boolean
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
Type: String
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
Specifies resources that this application requires access to and the set of OAuth permission scopes and application roles that it needs under each of those resources. This pre-configuration of required resource access drives the consent experience.

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
Specifies URL to the SAML metadata for the application.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Oauth2RequirePostResponse
Specifies whether, as part of OAuth 2.0 token requests, Microsoft Entra ID allows POST requests, as opposed to GET requests.  
The default is false, which specifies that only GET requests is allowed.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AllowGuestsSignIn
Indicate if the application accepts other IDPs or not or partially accepts.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AllowPassthroughUsers
Indicates that the application supports pass through users who have no presence in the resource tenant.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AppLogoUrl
Specifies the url for the application logo image stored in a CDN.

```yaml
Type: String
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
Type: InformationalUrl
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IsDeviceOnlyAuthSupported
Specifies whether this application supports device authentication without a user.  
The default is false.

```yaml
Type: Boolean
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
Type: Boolean
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
Type: OptionalClaims
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -OrgRestrictions
Specifies a list of tenants allowed to access application.

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
Type: ParentalControlSettings
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
Type: String
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
Type: String
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
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraApplication](Get-EntraApplication.md)

[New-EntraApplication](New-EntraApplication.md)

[Remove-EntraApplication](Remove-EntraApplication.md)

