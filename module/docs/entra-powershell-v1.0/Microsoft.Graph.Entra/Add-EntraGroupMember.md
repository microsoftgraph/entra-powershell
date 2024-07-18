---
title: Add-EntraGroupMember.
description: This article explains the Add-EntraGroupMember command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Add-EntraGroupMember

## Synopsis

Adds a member to a group.

## Syntax

```powershell
Add-EntraGroupMember 
 -ObjectId <String> 
 -RefObjectId <String> 
 [<CommonParameters>]
```

## Description

The Add-EntraGroupMember cmdlet adds a member to a group.

## Examples

### Example 1: Add a member to a group

```powershell
Connect-Entra -Scopes 'GroupMember.ReadWrite.All'
Add-EntraGroupMember -ObjectId 'dddddddd-2222-3333-5555-rrrrrrrrrrrr' -RefObjectId 'bbbbbbbb-1111-2222-3333-cccccccccccc'
```

This command is used to add a member to a group. The `-ObjectId` parameter specifies the ID of the group to which the member should be added. The `-RefObjectId` parameter specifies the ID of the member to be added to the group.

## Parameters

### -ObjectId

Specifies the ID of a group in Microsoft Entra ID.

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

### -RefObjectId

Specifies the ID of the Microsoft Entra ID object that assign as owner/manager/member.

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

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related Links

[Get-EntraGroupMember](Get-EntraGroupMember.md)

[Remove-EntraGroupMember](Remove-EntraGroupMember.md)