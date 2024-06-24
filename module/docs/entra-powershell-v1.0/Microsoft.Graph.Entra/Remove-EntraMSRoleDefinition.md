---
title: Remove-EntraMSRoleDefinition
description: This article provides details on the Remove-EntraMSRoleDefinition command.

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

# Remove-EntraMSRoleDefinition

## SYNOPSIS

Delete a Microsoft Entra ID roleDefinition by ObjectId.

## SYNTAX

```powershell
Remove-EntraMSRoleDefinition 
 -Id <String> 
 [<CommonParameters>]
```

## DESCRIPTION

Delete a Microsoft Entra ID roleDefinition object by ID.

You can't delete built-in roles. This feature requires a Microsoft Entra ID P1 or P2 license.

## EXAMPLES

### Example 1: Remove a specified role definition

```powershell
 Connect-Entra -Scopes 'RoleManagement.ReadWrite.Directory'
 Remove-EntraMSRoleDefinition -Id a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1
```

This example demonstrates how to remove the specified role definition from Microsoft Entra ID.

## PARAMETERS

### -Id

The unique identifier of an object in Microsoft Entra ID.

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

### string

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraMSRoleDefinition](Get-EntraMSRoleDefinition.md)

[New-EntraMSRoleDefinition](New-EntraMSRoleDefinition.md)

[Set-EntraMSRoleDefinition](Set-EntraMSRoleDefinition.md)
