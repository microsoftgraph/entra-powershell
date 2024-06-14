---
title: Remove-EntraGroupOwner
description: This article provides details on the Remove-EntraGroupOwner command.

ms.service: entra
ms.topic: reference
ms.date: 03/06/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Remove-EntraGroupOwner

## SYNOPSIS

Removes an owner from a group.

## SYNTAX

```powershell
Remove-EntraGroupOwner 
 -OwnerId <String> 
 -ObjectId <String> 
 [<CommonParameters>]
```

## DESCRIPTION

The Remove-EntraGroupOwner cmdlet removes an owner from a group in Microsoft Entra ID.

## EXAMPLES

### Example 1: Remove an owner

```powershell
Connect-Entra -Scopes 'Group.ReadWrite.All'
Remove-EntraGroupOwner -ObjectId 'qqqqqqqq-5555-0000-1111-hhhhhhhhhhhh' -OwnerId 'xxxxxxxx-8888-5555-9999-bbbbbbbbbbbb'
```

This example demonstrates how to remove an owner from a group in Microsoft Entra ID.

ObjectID - Specifies the ID of a group in Microsoft Entra ID.  

OwnerId  - Specifies the ID of an owner.

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

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Add-EntraGroupOwner](Add-EntraGroupOwner.md)

[Get-EntraGroupOwner](Get-EntraGroupOwner.md)