---
title: New-EntraIdentityProvider
description: This article provides details on the New-EntraIdentityProvider command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Entra.SignIns-Help.xml
Module Name: Microsoft.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/New-EntraIdentityProvider

schema: 2.0.0
---

# New-EntraIdentityProvider

## Synopsis

Configure a new identity provider in the directory.

## Syntax

```powershell
New-EntraIdentityProvider
 -Type <String>
 -ClientSecret <String>
 -ClientId <String>
 [-Name <String>]
 [<CommonParameters>]
```

## Description

The `New-EntraIdentityProvider` cmdlet is used to configure an identity provider in the directory.

Adding an identity provider will allow users to sign up for or sign into applications secured by Microsoft Entra ID B2C using the identity provider.

Configuring an identity provider in your Microsoft Entra ID tenant also enables future B2B guest scenarios.

For example, an organization has resources in Office 365 that needs to be shared with a Gmail user. The Gmail user will use their Google account credentials to authenticate and access the documents.

The current set of identity providers can be:

- Microsoft
- Google
- Facebook
- Amazon
- LinkedIn

In delegated scenarios using work or school accounts, the signed-in user must have a Microsoft Entra role or custom role with the necessary permissions. The following least privileged roles support this operation:

- External Identity Provider Administrator

## Examples

### Example 1: Add LinkedIn identity provider

```powershell
Connect-Entra -Scopes 'IdentityProvider.ReadWrite.All'
New-EntraIdentityProvider -Type 'LinkedIn' -Name 'LinkedInName' -ClientId 'LinkedInAppClientId' -ClientSecret 'LinkedInAppClientSecret'
```

```Output
Id             DisplayName
--             -----------
LinkedIn-OAUTH LinkedInName
```

This example adds a LinkedIn identity provider.

- `-Type` parameter specifies the identity provider type. It must be one of the following values: Microsoft, Google, Facebook, Amazon, or LinkedIn.
- `-Name` parameter specifies the display name of the identity provider.
- `-ClientId` parameter specifies the client identifier for the application, obtained during the application's registration with the identity provider.
- `-ClientSecret` parameter specifies the client secret for the application, obtained during registration with the identity provider.

## Parameters

### -ClientId

The client identifier for the application, obtained during the application's registration with the identity provider.

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

### -ClientSecret

The client secret for the application, obtained during registration with the identity provider, is write-only. A read operation returns `****`.

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

### -Name

The display name of the identity provider.

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

### -Type

The identity provider type. It must be one of the following values: Microsoft, Google, Facebook, Amazon, or LinkedIn.

For a B2B scenario, possible values: Google, Facebook. For a B2C scenario, possible values: Microsoft, Google, Amazon, LinkedIn, Facebook, GitHub, Twitter, Weibo, QQ, WeChat.

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

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

### None

## Outputs

### System.Object

## Notes

## Related links

[Remove-EntraIdentityProvider](Remove-EntraIdentityProvider.md)
