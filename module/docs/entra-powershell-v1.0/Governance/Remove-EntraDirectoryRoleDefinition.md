---
author: msewaweru
description: This article provides details on the Remove-EntraDirectoryRoleDefinition command.
external help file: Microsoft.Entra.Governance-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra
ms.author: eunicewaweru
ms.date: 06/26/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Remove-EntraDirectoryRoleDefinition
schema: 2.0.0
title: Remove-EntraDirectoryRoleDefinition
---

# Remove-EntraDirectoryRoleDefinition

## SYNOPSIS

Delete a Microsoft Entra ID Directory roleDefinition object.

## SYNTAX

```powershell
Remove-EntraDirectoryRoleDefinition
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
$role = Get-EntraDirectoryRoleDefinition -Filter "DisplayName eq 'Contoso Custom Role Definition'"
Remove-EntraDirectoryRoleDefinition -UnifiedRoleDefinitionId $role.Id
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

`Remove-EntraRoleDefinition` is an alias for `Remove-EntraDirectoryRoleDefintion`.

## RELATED LINKS

[Get-EntraDirectoryRoleDefinition](Get-EntraDirectoryRoleDefinition.md)

[New-EntraDirectoryRoleDefinition](New-EntraDirectoryRoleDefinition.md)

[Set-EntraDirectoryRoleDefinition](Set-EntraDirectoryRoleDefinition.md)
