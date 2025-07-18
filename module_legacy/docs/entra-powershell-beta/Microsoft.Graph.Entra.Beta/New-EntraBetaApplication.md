---
title: New-EntraBetaApplication
description: This article provides details on the New-EntraBetaApplication command.


ms.topic: reference
ms.date: 06/19/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: mwongerapk
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/New-EntraBetaApplication

schema: 2.0.0
---

# New-EntraBetaApplication

## Synopsis

Creates (registers) a new application object.

## Syntax

```powershell
New-EntraBetaApplication
 -DisplayName <String>
 [-Api <ApiApplication>]
 [-OptionalClaims <OptionalClaims>]
 [-PreAuthorizedApplications <System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.PreAuthorizedApplication]>]
 [-Web <WebApplication>]
 [-IsFallbackPublicClient <Boolean>]
 [-RequiredResourceAccess <System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.RequiredResourceAccess]>]
 [-PublicClient <PublicClientApplication>]
 [-IsDeviceOnlyAuthSupported <Boolean>]
 [-OrgRestrictions <System.Collections.Generic.List`1[System.String]>]
 [-KeyCredentials <System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.KeyCredential]>]
 [-TokenEncryptionKeyId <String>]
 [-IdentifierUris <System.Collections.Generic.List`1[System.String]>]
 [-ParentalControlSettings <ParentalControlSettings>]
 [-GroupMembershipClaims <String>]
 [-AddIns <System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.AddIn]>]
 [-Tags <System.Collections.Generic.List`1[System.String]>]
 [-AppRoles <System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.AppRole]>]
 [-PasswordCredentials <System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.PasswordCredential]>]
 [-SignInAudience <String>]
 [-InformationalUrl <InformationalUrl>]
 [<CommonParameters>]
```

## Description

Creates (registers) a new application object. Specify the `DisplayName` parameter to create a new application.

## Examples

### Example 1: Create an application

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All','Application.ReadWrite.OwnedBy'
New-EntraBetaApplication -DisplayName 'My new application'
```

```Output
DisplayName        Id                                   AppId                                SignInAudience PublisherDomain
-----------        --                                   -----                                -------------- ---------------
My new application aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb 00001111-aaaa-2222-bbbb-3333cccc4444 AzureADMyOrg   domain.mail.contoso.com
```

This command creates an application in Microsoft Entra ID.

### Example 2: Create an application using IdentifierUris parameter

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All','Application.ReadWrite.OwnedBy'
New-EntraBetaApplication -DisplayName 'My new application' -IdentifierUris 'https://mynewapp.contoso.com'
```

```Output
DisplayName        Id                                   AppId                                SignInAudience PublisherDomain
-----------        --                                   -----                                -------------- ---------------
My new application aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb 00001111-aaaa-2222-bbbb-3333cccc4444 AzureADMyOrg   domain.mail.contoso.com
```

This command creates an application in Microsoft Entra ID.

### Example 3: Create an application using Api parameter

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All'
$api = @{ RequestedAccessTokenVersion = 2 }
New-EntraBetaApplication -DisplayName 'My new application' -Api $api
```

```Output
DisplayName        Id                                   AppId                                SignInAudience PublisherDomain
-----------        --                                   -----                                -------------- ---------------
My new application aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb 00001111-aaaa-2222-bbbb-3333cccc4444 AzureADMyOrg   domain.mail.contoso.com
```

This command creates an application in Microsoft Entra ID.

### Example 4: Create an application using AppRoles parameter

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All','Application.ReadWrite.OwnedBy'
$types = @()
$types += 'User'
$approle = New-Object Microsoft.Open.MSGraph.Model.AppRole
$approle.AllowedMemberTypes =  $types
$approle.Description          = 'msiam_access'
$approle.DisplayName = 'msiam_access'
$approle.Id = '643985ce-3eaf-4a67-9550-ecca25cb6814'
$approle.Value = 'Application'
$approle.IsEnabled = $true
New-EntraBetaApplication -DisplayName 'My new application' -AppRoles $approle
```

```Output
DisplayName        Id                                   AppId                                SignInAudience PublisherDomain
-----------        --                                   -----                                -------------- ---------------
My new application aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb 00001111-aaaa-2222-bbbb-3333cccc4444 AzureADMyOrg   domain.mail.contoso.com
```

This command creates an application in Microsoft Entra ID.

### Example 5: Create an application using OptionalClaims parameter

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All'
$optionalClaims = @{ IdToken = [PSCustomObject]@{ Name = "claimName"; Source = "claimSource" } }
New-EntraBetaApplication -DisplayName 'My new application' -OptionalClaims $optionalClaims
```

```Output
DisplayName        Id                                   AppId                                SignInAudience PublisherDomain
-----------        --                                   -----                                -------------- ---------------
My new application aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb 00001111-aaaa-2222-bbbb-3333cccc4444 AzureADMyOrg   domain.mail.contoso.com
```

This command creates an application in Microsoft Entra ID.

## Parameters

### -AddIns

Defines custom behavior that a consuming service can use to call an app in specific contexts.

For example, applications that can render file streams may set the addIns property for its "FileHandler" functionality.

This will let services like Office 365 call the application in the context of a document the user is working on.

```yaml
Type: System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.AddIn]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Api

Specifies settings for an application that implements a web API.

```yaml
Type: ApiApplication
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
Type: System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.AppRole]
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

### -GroupMembershipClaims

Configures the groups claim issued in a user or OAuth 2.0 access token that the application expects.

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

User-defined URI(s) that uniquely identify a Web application within its Microsoft Entra ID tenant, or within a verified custom domain (see "Domains" tab in the Azure classic portal) if the application is multi-tenant.

The first element is populated from the Web application's "APP ID URI" field if updated via the Azure classic portal (or respective Microsoft Entra ID PowerShell cmdlet parameter).

Extra URIs can be added via the application manifest; see Understanding the Microsoft Entra ID Application Manifest for details.
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

### -InformationalUrl

Basic profile information of the application such as app's marketing, support, terms of service and privacy statement URLs.

The terms of service and privacy statement are surfaced to users through the user consent experience.

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

### -IsFallbackPublicClient

Specifies the fallback application type as public client, such as an installed application running on a mobile device.

The default value is false that means the fallback application type is confidential client such as web app.

There are certain scenarios where Microsoft Entra ID can't determine the client application type (for example, ROPC flow where it's configured without specifying a redirect URI).

In those cases Microsoft Entra ID interprets the application type based on the value of this property.

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

### -KeyCredentials

The collection of key credentials associated with the application.

```yaml
Type: System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.KeyCredential]
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

Reserved for future use.

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

### -PasswordCredentials

The collection of password credentials associated with the application.

```yaml
Type: System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.PasswordCredential]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PreAuthorizedApplications

Lists applications and requested permissions for implicit consent.
Requires an admin to have provided consent to the application.

preAuthorizedApplications don't require the user to consent to the requested permissions.
Permissions listed in preAuthorizedApplications don't require user consent.

However, any additional requested permissions not listed in preAuthorizedApplications require user consent.

```yaml
Type: System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.PreAuthorizedApplication]
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
Type: PublicClientApplication
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

This pre-configuration of required resource access drives the consent experience.

```yaml
Type: System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.RequiredResourceAccess]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SignInAudience

Specifies what Microsoft accounts are supported for the current application.

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

### -Tags

Custom strings that can be used to categorize and identify the application.

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

### -TokenEncryptionKeyId

Specifies the keyId of a public key from the keyCredentials collection.

When configured, Microsoft Entra ID encrypts all the tokens it emits by using the key this property points to.

The application code that receives the encrypted token must use the matching private key to decrypt the token before it can be used for the signed-in user.

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

### -Web

Specifies settings for a web application.

```yaml
Type: WebApplication
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

## Inputs

### Boolean

### Microsoft.Open.MSGraph.Model.ApiApplication

### Microsoft.Open.MSGraph.Model.InformationalUrl

### Microsoft.Open.MSGraph.Model.OptionalClaims

### Microsoft.Open.MSGraph.Model.ParentalControlSettings

### Microsoft.Open.MSGraph.Model.PublicClientApplication

### Microsoft.Open.MSGraph.Model.WebApplication

### String

### System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.AddIn]

### System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.AppRole]

### System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.KeyCredential]

### System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.PasswordCredential]

### System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.PreAuthorizedApplication]

### System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.RequiredResourceAccess]

### System.Collections.Generic.List`1[System.String]

### System.Nullable`one[System.Boolean]

## Outputs

### Microsoft.Open.MSGraph.Model.MsApplication

## Notes

## Related Links

[Get-EntraBetaApplication](Get-EntraBetaApplication.md)

[Remove-EntraBetaApplication](Remove-EntraBetaApplication.md)

[Set-EntraBetaApplication](Set-EntraBetaApplication.md)
