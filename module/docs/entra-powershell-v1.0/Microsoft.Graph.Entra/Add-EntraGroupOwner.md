---
title: Add-EntraGroupOwner
description: This article explains the Add-EntraGroupOwner command.

ms.service: entra
ms.topic: reference
ms.date: 03/05/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Add-EntraGroupOwner

## SYNOPSIS

Adds an owner to a group.

## SYNTAX

```powershell
Add-EntraGroupOwner 
 -ObjectId <String> 
 -RefObjectId <String> 
 [<CommonParameters>]
```

## DESCRIPTION

The Add-EntraGroupOwner cmdlet adds an owner to a Microsoft Entra ID group.

## EXAMPLES

### Example 1: Add an owner to a group

```powershell
Connect-Entra -Scopes 'Group.ReadWrite.All'
Add-EntraGroupOwner -ObjectId 'hhhhhhhh-3333-5555-3333-qqqqqqqqqqqq' -RefObjectId 'bbbbbbbb-1111-2222-3333-cccccccccccc'
```

This command is used to add an owner to a group. The `-ObjectId` parameter specifies the ID of the group to which the owner should be added. The `-RefObjectId` parameter specifies the ID of the owner to be added to the group.

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

Specifies the ID of the Microsoft Entra ID object that will be assigned as owner/manager/member.

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

[Get-EntraGroupOwner](Get-EntraGroupOwner.md)

[Remove-EntraGroupOwner](Remove-EntraGroupOwner.md)
