---
title: Set-EntraBetaIdentityProvider
description: This article provides details on the Set-EntraBetaIdentityProvider command.


ms.topic: reference
ms.date: 08/13/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Entra.Beta.SignIns-Help.xml
Module Name: Microsoft.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Set-EntraBetaIdentityProvider

schema: 2.0.0
---

# Set-EntraBetaIdentityProvider

## Synopsis

Update the properties of an existing identity provider configured in the directory.

## Syntax

```powershell
Set-EntraBetaIdentityProvider
 -IdentityProviderBaseId <String>
 [-Type <String>]
 [-Name <String>]
 [-ClientId <String>]
 [-ClientSecret <String>]
 [<CommonParameters>]
```

## Description

The `Set-EntraBetaIdentityProvider` cmdlet is used to update the properties of an existing identity provider.

The type of the identity provider can't be modified.

In delegated scenarios using work or school accounts, the signed-in user must have a Microsoft Entra role or custom role with the necessary permissions. The following least privileged roles support this operation:

- External Identity Provider Administrator

## Examples

### Example 1: Update client id of an identity provider

```powershell
Connect-Entra -Scopes 'IdentityProvider.ReadWrite.All'
Set-EntraBetaIdentityProvider -IdentityProviderBaseId 'Google-OAuth' -ClientId 'NewClientID'
```

This example updates the client ID for the specified identity provider.

- `-IdentityProviderBaseId` parameter specifies the unique identifier of the identity provider.
- `-ClientId` parameter specifies the client identifier for the application, obtained during the application's registration with the identity provider.

### Example 2: Update client secret of an identity provider

```powershell
Connect-Entra -Scopes 'IdentityProvider.ReadWrite.All'
Set-EntraBetaIdentityProvider -IdentityProviderBaseId 'Google-OAuth' -ClientSecret 'NewClientSecret'
```

This example updates the client secret for the specified identity provider.

- `-IdentityProviderBaseId` parameter specifies the unique identifier of the identity provider.
- `-ClientSecret` parameter specifies the client secret for the application, obtained during registration with the identity provider.

### Example 3: Update display name of an identity provider

```powershell
Connect-Entra -Scopes 'IdentityProvider.ReadWrite.All'
Set-EntraBetaIdentityProvider -IdentityProviderBaseId 'Google-OAuth' -Name 'NewGoogleName'
```

This example updates the display name for the specified identity provider.

- `-IdentityProviderBaseId` parameter specifies the unique identifier of the identity provider.
- `-Name` parameter specifies the display name of the identity provider.

## Parameters

### -ClientId

The client identifier for the application, obtained during the application's registration with the identity provider.

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

### -ClientSecret

The client secret for the application, obtained during registration with the identity provider, is write-only. A read operation returns `****`.

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

### -IdentityProviderBaseId

The unique identifier for an identity provider.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: Id

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
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

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

### System.String

## Outputs

### System.Object

## Notes

## Related links

[New-EntraBetaIdentityProvider](New-EntraBetaIdentityProvider.md)

[Remove-EntraBetaIdentityProvider](Remove-EntraBetaIdentityProvider.md)
