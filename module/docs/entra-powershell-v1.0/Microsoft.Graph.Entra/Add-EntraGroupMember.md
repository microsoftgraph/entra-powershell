---
title: Add-EntraGroupMember
description: This article explains the Add-EntraGroupMember command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Add-EntraGroupMember

schema: 2.0.0
---

# Add-EntraGroupMember

## Synopsis

Adds a member to a group.

## Syntax

```powershell
Add-EntraGroupMember
 -GroupId <String>
 -RefObjectId <String>
 [<CommonParameters>]
```

## Description

The Add-EntraGroupMember cmdlet adds a member to a group.

In delegated scenarios, the signed-in user needs a supported Microsoft Entra role or a custom role with the `microsoft.directory/groups/members/update` permission. The minimum roles required for this operation, excluding role-assignable groups, are:

- Group owners
- Directory Writers
- Groups Administrator
- User Administrator

## Examples

### Example 1: Add a member to a group

```powershell
Connect-Entra -Scopes 'GroupMember.ReadWrite.All'
$group = Get-EntraGroup -Filter "DisplayName eq 'Contoso Marketing Group'"
$user = Get-EntraUser -UserId 'SawyerM@contoso.com'
Add-EntraGroupMember -GroupId $group.Id -RefObjectId $user.Id
```

This example demonstrates how to add a member to a group.

- `-GroupId` - Specifies the unique identifier (Object ID) of the group to which you want to add a member.
- `-RefObjectId` - Specifies the unique identifier (Object ID) of the member to be added to the group.

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

## Related links

[Get-EntraGroupMember](Get-EntraGroupMember.md)

[Remove-EntraGroupMember](Remove-EntraGroupMember.md)
