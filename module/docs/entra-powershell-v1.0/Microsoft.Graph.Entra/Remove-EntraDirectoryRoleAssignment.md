---
title: Remove-EntraDirectoryRoleAssignment
description: This article provides details on the Remove-EntraDirectoryRoleAssignment command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Remove-EntraDirectoryRoleAssignment

schema: 2.0.0
---

# Remove-EntraDirectoryRoleAssignment

## Synopsis

Delete a Microsoft Entra ID roleAssignment.

## Syntax

```powershell
Remove-EntraDirectoryRoleAssignment
 -UnifiedRoleAssignmentId <String>
 [<CommonParameters>]
```

## Description

The `Remove-EntraDirectoryRoleAssignment` cmdlet removes a role assignment from Microsoft Entra ID.

In delegated scenarios, the signed-in user must have either a supported Microsoft Entra role or a custom role with the necessary permissions. The minimum roles required for this operation are:

- Privileged Role Administrator

## Examples

### Example 1: Remove a role assignment

```powershell
Connect-Entra -Scopes 'RoleManagement.ReadWrite.Directory','EntitlementManagement.ReadWrite.All'
$user = Get-EntraUser -UserId 'SawyerM@contoso.com'
$role = Get-EntraDirectoryRoleDefinition -Filter "DisplayName eq 'Helpdesk Administrator'"
$assignment = Get-EntraDirectoryRoleAssignment -All | Where-Object {$_.principalId -eq $user.Id -AND $_.RoleDefinitionId -eq $role.Id}
Remove-EntraDirectoryRoleAssignment -UnifiedRoleAssignmentId $assignment.Id
```

This example removes the specified role assignment from Microsoft Entra ID.

- `-Id` parameter specifies the role assignment ID.

## Parameters

### -UnifiedRoleAssignmentId

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

`Remove-EntraRoleAssignment` is an alias for `Remove-EntraDirectoryRoleAssignment`.

## Related links

[Get-EntraDirectoryRoleAssignment](Get-EntraDirectoryRoleAssignment.md)

[New-EntraDirectoryRoleAssignment](New-EntraDirectoryRoleAssignment.md)
