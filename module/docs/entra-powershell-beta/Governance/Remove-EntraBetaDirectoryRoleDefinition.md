---
description: This article provides details on the Remove-EntraBetaDirectoryRoleDefinition command.
external help file: Microsoft.Entra.Beta.Governance-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 07/22/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Remove-EntraBetaDirectoryRoleDefinition
schema: 2.0.0
title: Remove-EntraBetaDirectoryRoleDefinition
---

# Remove-EntraBetaDirectoryRoleDefinition

## SYNOPSIS

Delete a Microsoft Entra ID Directory roleDefinition object.

## SYNTAX

```powershell
Remove-EntraBetaDirectoryRoleDefinition
 -UnifiedRoleDefinitionId <String>
 [<CommonParameters>]
```

## DESCRIPTION

Delete a Microsoft Entra ID Directory roleDefinition object by ID.

You can't delete built-in roles. This feature requires a Microsoft Entra ID P1 or P2 license.

In delegated scenarios, the signed-in user must have either a supported Microsoft Entra role or a custom role with the necessary permissions. The minimum roles required for this operation are:

- Privileged Role Administrator

## EXAMPLES

### Example 1: Remove a specified role definition

```powershell
Connect-Entra -Scopes 'RoleManagement.ReadWrite.Directory'
$role = Get-EntraBetaDirectoryRoleDefinition -Filter "DisplayName eq 'Contoso Custom Role Definition'"
Remove-EntraBetaDirectoryRoleDefinition -UnifiedRoleDefinitionId $role.Id
```

This example demonstrates how to remove the specified role definition from Microsoft Entra ID.

- `-UnifiedRoleDefinitionId` parameter specifies the roleDefinition object ID.

## PARAMETERS

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

## INPUTS

### System.String

## OUTPUTS

### System.Object

## NOTES

`Remove-EntraBetaRoleDefinition` is an alias for `Remove-EntraBetaDirectoryRoleDefinition`.

## RELATED LINKS

[New-EntraBetaDirectoryRoleDefinition](New-EntraBetaDirectoryRoleDefinition.md)

[Set-EntraBetaDirectoryRoleDefinition](Set-EntraBetaDirectoryRoleDefinition.md)

[Get-EntraBetaDirectoryRoleDefinition](Get-EntraBetaDirectoryRoleDefinition.md)
