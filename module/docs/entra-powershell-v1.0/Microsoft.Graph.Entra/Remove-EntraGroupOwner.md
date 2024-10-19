---
title: Remove-EntraGroupOwner
description: This article provides details on the Remove-EntraGroupOwner command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Remove-EntraGroupOwner

schema: 2.0.0
---

# Remove-EntraGroupOwner

## Synopsis

Removes an owner from a group.

## Syntax

```powershell
Remove-EntraGroupOwner
 -OwnerId <String>
 -GroupId <String>
 [<CommonParameters>]
```

## Description

The `Remove-EntraGroupOwner` cmdlet removes an owner from a group in Microsoft Entra ID. Specify the `GroupId` and `OwnerId` parameters to remove an owner from a group.

## Examples

### Example 1: Remove an owner

```powershell
Connect-Entra -Scopes 'Group.ReadWrite.All'
$group = Get-EntraGroup -Filter "DisplayName eq 'HelpDesk Team Leaders'"
Remove-EntraGroupOwner -GroupId $group.Id -OwnerId 'xxxxxxxx-8888-5555-9999-bbbbbbbbbbbb'
```

This example demonstrates how to remove an owner from a group in Microsoft Entra ID.

GroupId - Specifies the ID of a group in Microsoft Entra ID.  

- `OwnerId` specifies the ID of an owner.

## Parameters

### -GroupId

Specifies the ID of a group in Microsoft Entra ID.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: ObjectId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -OwnerId

Specifies the ID of an owner.

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

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related links

[Add-EntraGroupOwner](Add-EntraGroupOwner.md)

[Get-EntraGroupOwner](Get-EntraGroupOwner.md)
