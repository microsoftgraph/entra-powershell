---
title: Remove-EntraBetaDirectoryRoleDefinition
description: This article provides details on the Remove-EntraBetaDirectoryRoleDefinition command.


ms.topic: reference
ms.date: 07/22/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra.Beta-help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Remove-EntraBetaDirectoryRoleDefinition

schema: 2.0.0
---

# Remove-EntraBetaDirectoryRoleDefinition

## Synopsis

Delete a Microsoft Entra ID Directory roleDefinition object.

## Syntax

```powershell
Remove-EntraBetaDirectoryRoleDefinition
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
Remove-EntraBetaDirectoryRoleDefinition -UnifiedRoleDefinitionId 'a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1'
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

`Remove-EntraBetaRoleDefinition` is an alias for `Remove-EntraBetaDirectoryRoleDefinition`.

## Related Links

[New-EntraBetaDirectoryRoleDefinition](New-EntraBetaDirectoryRoleDefinition.md)

[Set-EntraBetaDirectoryRoleDefinition](Set-EntraBetaDirectoryRoleDefinition.md)

[Get-EntraBetaDirectoryRoleDefinition](Get-EntraBetaDirectoryRoleDefinition.md)
