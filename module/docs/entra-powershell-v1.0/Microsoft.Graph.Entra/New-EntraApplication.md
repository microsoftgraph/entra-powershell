---
title: New-EntraApplication
description: This article provides details on the New-EntraApplication command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/New-EntraApplication

schema: 2.0.0
---

# New-EntraApplication

## Synopsis

Creates (registers) a new application object.

## Syntax

```powershell
New-EntraApplication
 -DisplayName <String>
 [-AddIns <System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.AddIn]>]
 [-PasswordCredentials <System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.PasswordCredential]>]
 [-TokenEncryptionKeyId <String>]
 [-SignInAudience <String>]
 [-KeyCredentials <System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.KeyCredential]>]
 [-ParentalControlSettings <ParentalControlSettings>]
 [-IdentifierUris <System.Collections.Generic.List`1[System.String]>]
 [-AppRoles <System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.AppRole]>]
 [-PublicClient <PublicClientApplication>]
 [-InformationalUrl <InformationalUrl>]
 [-Tags <System.Collections.Generic.List`1[System.String]>]
 [-Api <ApiApplication>]
 [-OptionalClaims <OptionalClaims>]
 [-GroupMembershipClaims <String>]
 [-Web <WebApplication>]
 [-IsFallbackPublicClient <Boolean>]
 [-IsDeviceOnlyAuthSupported <Boolean>]
 [-RequiredResourceAccess <System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.RequiredResourceAccess]>]
 [<CommonParameters>]
```

## Description

Creates (registers) a new application object. Specify the `DisplayName` parameter to create a new application.

## Examples

### Example 1: Create an application

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All','Application.ReadWrite.OwnedBy'
New-EntraApplication -DisplayName 'My new application'
```

```Output
DisplayName Id                                   AppId                                SignInAudience PublisherDomain
----------- --                                   -----                                -------------- ---------------
My new application       dddd3333-ee44-5555-66ff-777777aaaaaa 22223333-cccc-4444-dddd-5555eeee6666 AzureADMyOrg   contoso.com
```

This command creates an application in Microsoft Entra ID.

### Example 2: Create an application using IdentifierUris parameter

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All','Application.ReadWrite.OwnedBy'
New-EntraApplication -DisplayName 'My new application' -IdentifierUris 'https://mynewapp.contoso.com'
```

```Output
DisplayName Id                                   AppId                                SignInAudience PublisherDomain
----------- --                                   -----                                -------------- ---------------
My new application       dddd3333-ee44-5555-66ff-777777aaaaaa 22223333-cccc-4444-dddd-5555eeee6666 AzureADMyOrg   contoso.com
```

This command creates an application in Microsoft Entra ID.

### Example 3: Create an application using AddIns parameter

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All','Application.ReadWrite.OwnedBy'
$addin = New-Object Microsoft.Open.MSGraph.Model.AddIn
$addin.Type = 'testtype'
$addinproperties = New-Object System.collections.Generic.List[Microsoft.Open.MSGraph.Model.KeyValue]
$addinproperties.Add([Microsoft.Open.MSGraph.Model.KeyValue]@{ Key = "key"; Value = "value" })
$addin.Properties = $addinproperties
New-EntraApplication -DisplayName 'My new application' -AddIns $addin
```

```Output
DisplayName Id                                   AppId                                SignInAudience PublisherDomain
----------- --                                   -----                                -------------- ---------------
My new application       dddd3333-ee44-5555-66ff-777777aaaaaa 22223333-cccc-4444-dddd-5555eeee6666 AzureADMyOrg   contoso.com
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

### System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.Add-in]

### System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.AppRole]

### System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.KeyCredential]

### System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.PasswordCredential]

### System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.RequiredResourceAccess]

### System.Collections.Generic.List`1[System.String]

### System. Nullable`1[System.Boolean]

## Outputs

### Microsoft.Open.MSGraph.Model.MsApplication

## Notes

- See more details - <https://learn.microsoft.com/graph/api/application-post-applications>

## Related Links

[Get-EntraApplication](Get-EntraApplication.md)

[Remove-EntraApplication](Remove-EntraApplication.md)

[Set-EntraApplication](Set-EntraApplication.md)
