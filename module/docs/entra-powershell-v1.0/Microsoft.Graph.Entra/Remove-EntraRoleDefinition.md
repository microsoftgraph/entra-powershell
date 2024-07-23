---
title: Remove-EntraRoleDefinition
description: This article provides details on the Remove-EntraRoleDefinition command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/en-us/powershell/module/Microsoft.Graph.Entra/Remove-EntraRoleDefinition

schema: 2.0.0
---

# Remove-EntraRoleDefinition

## Synopsis

Delete a Microsoft Entra ID roleDefinition by ObjectId.

## Syntax

```powershell
Remove-EntraRoleDefinition 
 -Id <String> 
 [<CommonParameters>]
```

## Description

Delete a Microsoft Entra ID roleDefinition object by ID.

You can't delete built-in roles. This feature requires a Microsoft Entra ID P1 or P2 license.

## Examples

### Example 1: Remove a specified role definition

```powershell
 Connect-Entra -Scopes 'RoleManagement.ReadWrite.Directory'
 Remove-EntraRoleDefinition -Id a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1
```

This example demonstrates how to remove the specified role definition from Microsoft Entra ID.

## Parameters

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

## Inputs

### string

## Outputs

## Notes

## Related Links

[Get-EntraRoleDefinition](Get-EntraRoleDefinition.md)

[New-EntraRoleDefinition](New-EntraRoleDefinition.md)

[Set-EntraRoleDefinition](Set-EntraRoleDefinition.md)
