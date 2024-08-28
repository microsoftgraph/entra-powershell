---
title: Remove-EntraGroupMember
description: This article provides details on the Remove-EntraGroupMember command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Remove-EntraGroupMember

schema: 2.0.0
---

# Remove-EntraGroupMember

## Synopsis

Removes a member from a group.

## Syntax

```powershell
Remove-EntraGroupMember 
 -ObjectId <String> 
 -MemberId <String> 
 [<CommonParameters>]
```

## Description

The Remove-EntraGroupMember cmdlet removes a member from a group in Microsoft Entra ID.

## Examples

### Example 1: Remove a member

This example demonstrates how to remove a member from a group in Microsoft Entra ID.

```powershell
Connect-Entra -Scopes 'GroupMember.ReadWrite.All'
Remove-EntraGroupMember -ObjectId 'hhhhhhhh-3333-5555-3333-qqqqqqqqqqqq' -MemberId 'zzzzzzzz-6666-8888-9999-pppppppppppp'
```

This command removes the specified member from the specified group.  

ObjectId - Specifies the object ID of a group in Microsoft Entra ID.

MemberId - Specifies the ID of the member to remove.

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

### -ObjectId

Specifies the object ID of a group in Microsoft Entra ID.

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

[Add-EntraGroupMember](Add-EntraGroupMember.md)

[Get-EntraGroupMember](Get-EntraGroupMember.md)
