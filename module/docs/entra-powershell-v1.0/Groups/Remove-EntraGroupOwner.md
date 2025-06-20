---
description: This article provides details on the Remove-EntraGroupOwner command.
external help file: Microsoft.Entra.Groups-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra
ms.author: eunicewaweru
ms.date: 06/26/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Remove-EntraGroupOwner
schema: 2.0.0
title: Remove-EntraGroupOwner
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
$groupOwner = Get-EntraGroup -GroupId $group.Id | Get-EntraGroupOwner | Where-Object {$_.displayName -eq 'Adele Vance'}
Remove-EntraGroupOwner -GroupId $group.Id -OwnerId $groupOwner.Id
```

This example demonstrates how to remove an owner from a group in Microsoft Entra ID.

- `GroupId` - Specifies the ID of a group in Microsoft Entra ID.  

- `OwnerId` - Specifies the ID of an owner.

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
