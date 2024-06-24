---
title: Remove-EntraMSGroup
description: This article provides details on the Remove-EntraMSGroup command.

ms.service: entra
ms.topic: reference
ms.date: 03/16/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Remove-EntraMSGroup

## SYNOPSIS

Removes a Microsoft Entra ID group.

## SYNTAX

```powershell
Remove-EntraMSGroup 
 -Id <String> 
 [<CommonParameters>]
```

## DESCRIPTION

The Remove-EntraMSGroup cmdlet removes a Microsoft Entra ID group.

## EXAMPLES

### Example 1: Remove a group

```powershell
 Connect-Entra -Scopes 'Group.ReadWrite.All'
 Remove-EntraMSGroup -Id 'tttttttt-0000-3333-9999-mmmmmmmmmmmm'
```

This example demonstrates how to remove the group with specified ID.

## PARAMETERS

### -Id

Specifies the ID of the group that this cmdlet removes.

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

### System.String

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS

[Get-EntraMSGroup](Get-EntraMSGroup.md)

[New-EntraMSGroup](New-EntraMSGroup.md)

[Set-EntraMSGroup](Set-EntraMSGroup.md)

[Using attributes to create advanced rules](https://azure.microsoft.com/documentation/articles/active-directory-accessmanagement-groups-with-advanced-rules/)
