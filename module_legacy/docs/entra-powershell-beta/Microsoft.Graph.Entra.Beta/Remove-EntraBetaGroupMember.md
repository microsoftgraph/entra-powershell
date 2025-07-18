---
title: Remove-EntraBetaGroupMember
description: This article provides details on the Remove-EntraBetaGroupMember command.


ms.topic: reference
ms.date: 06/18/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: mwongerapk
author: msewaweru
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Remove-EntraBetaGroupMember

schema: 2.0.0
---

# Remove-EntraBetaGroupMember

## Synopsis

Removes a member from a group.

## Syntax

```powershell
Remove-EntraBetaGroupMember
 -GroupId <String>
 -MemberId <String>
 [<CommonParameters>]
```

## Description

The `Remove-EntraBetaGroupMember` cmdlet removes a member from a group in Microsoft Entra ID. Specify the `GroupId` and `MemberId` parameters to remove a member from a group.

## Examples

### Example 1: Remove a member

```powershell
Connect-Entra -Scopes 'GroupMember.ReadWrite.All'
$group = Get-EntraBetaGroup -Filter "DisplayName eq 'HelpDesk Team Leaders'"
$groupMember = Get-EntraBetaGroup -GroupId $group.Id | Get-EntraBetaGroupMember | Where-Object {$_.displayName -eq 'Adele Vance'}
Remove-EntraBetaGroupMember -GroupId $group.Id -MemberId $groupMember.Id
```

This example demonstrates how to remove a member from a group in Microsoft Entra ID.

## Parameters

### -MemberId

Specifies the ID of the member to remove.

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

### -GroupId

Specifies the object ID of a group in Microsoft Entra ID.

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

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related Links

[Add-EntraBetaGroupMember](Add-EntraBetaGroupMember.md)

[Get-EntraBetaGroupMember](Get-EntraBetaGroupMember.md)
