---
author: msewaweru
description: This article provides details on the Remove-EntraBetaIdentityProvider command.
external help file: Microsoft.Entra.Beta.SignIns-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 08/07/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Remove-EntraBetaIdentityProvider
schema: 2.0.0
title: Remove-EntraBetaIdentityProvider
---

# Remove-EntraBetaIdentityProvider

## SYNOPSIS

This cmdlet is used to delete an identity provider in the directory.

## SYNTAX

```powershell
Remove-EntraBetaIdentityProvider
 -IdentityProviderBaseId <String>
 [<CommonParameters>]
```

## DESCRIPTION

This cmdlet is used to delete an identity provider that has been configured in the directory.

The identity provider is permanently deleted.

In delegated scenarios using work or school accounts, the signed-in user must have a Microsoft Entra role or custom role with the necessary permissions. The following least privileged roles support this operation:

- External Identity Provider Administrator

## EXAMPLES

### Example 1: Remove the identity provider in the directory

```powershell
Connect-Entra -Scopes 'IdentityProvider.ReadWrite.All'
Remove-EntraBetaIdentityProvider -IdentityProviderBaseId 'LinkedIn-OAUTH'
```

This command demonstrates how to remove the specified identity provider.

- `-IdentityProviderBaseId` parameter specifies the unique identifier of the identity provider.

## PARAMETERS

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

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS

[New-EntraBetaIdentityProvider](New-EntraBetaIdentityProvider.md)

[Set-EntraBetaIdentityProvider](Set-EntraBetaIdentityProvider.md)
