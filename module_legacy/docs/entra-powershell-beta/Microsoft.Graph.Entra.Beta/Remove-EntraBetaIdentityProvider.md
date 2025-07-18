---
title: Remove-EntraBetaIdentityProvider
description: This article provides details on the Remove-EntraBetaIdentityProvider command.


ms.topic: reference
ms.date: 08/07/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: mwongerapk
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Remove-EntraBetaIdentityProvider

schema: 2.0.0
---

# Remove-EntraBetaIdentityProvider

## Synopsis

This cmdlet is used to delete an identity provider in the directory.

## Syntax

```powershell
Remove-EntraBetaIdentityProvider
 -IdentityProviderBaseId <String>
 [<CommonParameters>]
```

## Description

This cmdlet is used to delete an identity provider that has been configured in the directory.

The identity provider is permanently deleted.

The work or school account needs to belong to at least the External Identity Provider Administrator Microsoft Entra role.

## Examples

### Example 1: Remove the identity provider in the directory

```powershell
Connect-Entra -Scopes 'IdentityProvider.ReadWrite.All'
Remove-EntraBetaIdentityProvider -IdentityProviderBaseId 'LinkedIn-OAUTH'
```

This command demonstrates how to remove the specified identity provider.

- `-IdentityProviderBaseId` parameter specifies the unique identifier of the identity provider.

## Parameters

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

## Inputs

### System.String

## Outputs

### System.Object

## Notes

## Related Links

[New-EntraBetaIdentityProvider](New-EntraBetaIdentityProvider.md)

[Set-EntraBetaIdentityProvider](Set-EntraBetaIdentityProvider.md)
