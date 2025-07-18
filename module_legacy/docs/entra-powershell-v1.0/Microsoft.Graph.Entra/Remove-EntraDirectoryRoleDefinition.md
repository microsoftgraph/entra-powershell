---
title: Remove-EntraDirectoryRoleDefinition
description: This article provides details on the Remove-EntraDirectoryRoleDefinition command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: mwongerapk
author: msewaweru

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Remove-EntraDirectoryRoleDefinition

schema: 2.0.0
---

# Remove-EntraDirectoryRoleDefinition

## Synopsis

Delete a Microsoft Entra ID Directory roleDefinition object.

## Syntax

```powershell
Remove-EntraDirectoryRoleDefinition
 -UnifiedRoleDefinitionId <String>
 [<CommonParameters>]
```

## Description

Delete a Microsoft Entra ID Directory roleDefinition object by ID.

You can't delete built-in roles. This feature requires a Microsoft Entra ID P1 or P2 license.

## Examples

### Example 1: Remove a specified role definition

```powershell
Connect-Entra -Scopes 'RoleManagement.ReadWrite.Directory'
Remove-EntraDirectoryRoleDefinition -UnifiedRoleDefinitionId a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1
```

This example demonstrates how to remove the specified role definition from Microsoft Entra ID.

- `-UnifiedRoleDefinitionId` parameter specifies the roleDefinition object ID.

## Parameters

### -UnifiedRoleDefinitionId

The unique identifier of an object in Microsoft Entra ID.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: Id

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

### System.String

## Outputs

### System.Object

## Notes

`Remove-EntraRoleDefinition` is an alias for `Remove-EntraDirectoryRoleDefintion`.

## Related Links

[Get-EntraDirectoryRoleDefinition](Get-EntraDirectoryRoleDefinition.md)

[New-EntraDirectoryRoleDefinition](New-EntraDirectoryRoleDefinition.md)

[Set-EntraDirectoryRoleDefinition](Set-EntraDirectoryRoleDefinition.md)
