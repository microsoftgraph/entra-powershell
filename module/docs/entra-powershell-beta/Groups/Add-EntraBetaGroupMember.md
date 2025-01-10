---
title: Add-EntraBetaGroupMember
description: This article provides details on the Add-EntraBetaGroupMember command.

ms.topic: reference
ms.date: 06/17/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Entra.Beta.Groups-Help.xml
Module Name: Microsoft.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Add-EntraBetaGroupMember

schema: 2.0.0
---

# Add-EntraBetaGroupMember

## Synopsis

Add a member to a group.

## Syntax

```powershell
Add-EntraBetaGroupMember
 -GroupId <String>
 -RefObjectId <String>
 [<CommonParameters>]
```

## Description

The `Add-EntraBetaGroupMember` cmdlet adds a member to a group. Specify the `GroupId` and `RefObjectId` parameters to add a member to a group.

`-GroupId` - specifies the unique identifier (Object ID) of the group to which you want to add a member.

`-RefObjectId` - specifies the unique identifier (Object ID) of the member to be added to the group.

## Examples

### Example 1: Add a member to a group

```powershell
Connect-Entra -Scopes 'GroupMember.ReadWrite.All'
$params = @{
    GroupId = 'dddddddd-2222-3333-5555-rrrrrrrrrrrr'
    RefObjectId = 'bbbbbbbb-1111-2222-3333-cccccccccccc'
}

Add-EntraBetaGroupMember @params
```

This example demonstrates how to add a member to a group.

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

### -RefObjectId

Specifies the ID of the Microsoft Entra ID object that is assigned as an owner, manager, or member.

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

[Get-EntraBetaGroupMember](Get-EntraBetaGroupMember.md)

[Remove-EntraBetaGroupMember](Remove-EntraBetaGroupMember.md)
