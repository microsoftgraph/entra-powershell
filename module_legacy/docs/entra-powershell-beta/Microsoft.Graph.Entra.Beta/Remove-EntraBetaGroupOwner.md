---
title: Remove-EntraBetaGroupOwner
description: This article provides details on the Remove-EntraBetaGroupOwner command.


ms.topic: reference
ms.date: 06/18/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Remove-EntraBetaGroupOwner

schema: 2.0.0
---

# Remove-EntraBetaGroupOwner

## Synopsis

Removes an owner from a group.

## Syntax

```powershell
Remove-EntraBetaGroupOwner
 -OwnerId <String>
 -GroupId <String>
 [<CommonParameters>]
```

## Description

The `Remove-EntraBetaGroupOwner` cmdlet removes an owner from a group in Microsoft Entra ID. Specify the `GroupId` and `OwnerId` parameters to remove an owner from a group.

## Examples

### Example 1: Remove an owner

```powershell
Connect-Entra -Scopes 'Group.ReadWrite.All'
$group = Get-EntraBetaGroup -Filter "DisplayName eq 'HelpDesk Team Leaders'"
$groupOwner = Get-EntraBetaGroup -GroupId $group.Id | Get-EntraBetaGroupOwner | Where-Object {$_.displayName -eq 'Adele Vance'}
Remove-EntraBetaGroupOwner -GroupId $group.Id -OwnerId $groupOwner.Id
```

This example demonstrates how to remove an owner from a group in Microsoft Entra ID.

- `GroupId` specifies the ID of a group in Microsoft Entra ID.  

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

## Related Links

[Add-EntraBetaGroupOwner](Add-EntraBetaGroupOwner.md)

[Get-EntraBetaGroupOwner](Get-EntraBetaGroupOwner.md)
