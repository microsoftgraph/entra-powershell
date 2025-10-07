---
author: msewaweru
description: This article provides details on the Remove-EntraBetaGroupOwner command.
external help file: Microsoft.Entra.Beta.Groups-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.Beta.Groups
ms.author: eunicewaweru
ms.date: 06/18/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta.Groups/Remove-EntraBetaGroupOwner
schema: 2.0.0
title: Remove-EntraBetaGroupOwner
---

# Remove-EntraBetaGroupOwner

## SYNOPSIS

Removes an owner from a group.

## SYNTAX

```powershell
Remove-EntraBetaGroupOwner
 -OwnerId <String>
 -GroupId <String>
 [<CommonParameters>]
```

## DESCRIPTION

The `Remove-EntraBetaGroupOwner` cmdlet removes an owner from a group in Microsoft Entra ID. Specify the `GroupId` and `OwnerId` parameters to remove an owner from a group.

## EXAMPLES

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

## PARAMETERS

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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Add-EntraBetaGroupOwner](Add-EntraBetaGroupOwner.md)

[Get-EntraBetaGroupOwner](Get-EntraBetaGroupOwner.md)
