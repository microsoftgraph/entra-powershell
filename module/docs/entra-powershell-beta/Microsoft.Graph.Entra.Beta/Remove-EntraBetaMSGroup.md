---
title: Remove-EntraBetaMSGroup
description: This article provides details on the Remove-EntraBetaMSGroup command.

ms.service: entra
ms.topic: reference
ms.date: 06/18/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Remove-EntraBetaMSGroup

## SYNOPSIS

Removes a Microsoft Entra ID group.

## SYNTAX

```powershell
Remove-EntraBetaMSGroup 
 -Id <String> 
 [<CommonParameters>]
```

## DESCRIPTION

The `Remove-EntraBetaMSGroup` cmdlet removes a Microsoft Entra ID group. Specify the `Id` parameter to remove a Microsoft Entra ID group.

## EXAMPLES

### Example 1: Remove a group

```powershell
Connect-Entra -Scopes 'Group.ReadWrite.All'
Remove-EntraBetaMSGroup -Id 'tttttttt-0000-3333-9999-mmmmmmmmmmmm'
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

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

## OUTPUTS

### System.Object

## NOTES

This cmdlet is currently in Public Preview.
While a cmdlet is in Public Preview, we may make changes to the cmdlet, which could have unexpected effects.
We recommend that you don't use this cmdlet in a production environment.

## RELATED LINKS

[Get-EntraBetaMSGroup](Get-EntraBetaMSGroup.md)

[New-EntraBetaMSGroup](New-EntraBetaMSGroup.md)

[Set-EntraBetaMSGroup](Set-EntraBetaMSGroup.md)

[Using attributes to create advanced rules](https://azure.microsoft.com/en-us/documentation/articles/active-directory-accessmanagement-groups-with-advanced-rules/)