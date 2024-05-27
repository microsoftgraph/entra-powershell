---
title: Add-EntraGroupMember.
description: This article explains the Add-EntraGroupMember command.

ms.service: active-directory
ms.topic: reference
ms.date: 11/10/2023
ms.author: eunicewaweru
ms.reviewer: stevemutungi254
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Add-EntraGroupMember

## SYNOPSIS

Adds a member to a group.

## SYNTAX

```powershell
Add-EntraGroupMember 
 -ObjectId <String> 
 -RefObjectId <String> 
 [<CommonParameters>]
```

## DESCRIPTION

The Add-EntraGroupMember cmdlet adds a member to a group.

## EXAMPLES

### Example 1: Add a member to a group

```powershell
Connect-Entra -Scopes 'GroupMember.ReadWrite.All'
Add-EntraGroupMember -ObjectId '11111111-1111-1111-1111-111111111111' -RefObjectId 'bbbbbbbb-1111-2222-3333-cccccccccccc'
```

This command is used to add a member to a group. The `-ObjectId` parameter specifies the ID of the group to which the member should be added. The `-RefObjectId` parameter specifies the ID of the member to be added to the group.

## PARAMETERS

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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraGroupMember](Get-EntraGroupMember.md)

[Remove-EntraGroupMember](Remove-EntraGroupMember.md)