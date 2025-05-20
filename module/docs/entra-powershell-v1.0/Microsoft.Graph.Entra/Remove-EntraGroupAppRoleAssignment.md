---
title: Remove-EntraGroupAppRoleAssignment
description: This article provides details on the Remove-EntraGroupAppRoleAssignment command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Remove-EntraGroupAppRoleAssignment

schema: 2.0.0
---

# Remove-EntraGroupAppRoleAssignment

## Synopsis

Delete a group application role assignment.

## Syntax

```powershell
Remove-EntraGroupAppRoleAssignment
 -AppRoleAssignmentId <String>
 -GroupId <String>
[<CommonParameters>]
```

## Description

The `Remove-EntraGroupAppRoleAssignment` cmdlet removes a group application role assignment from Microsoft Entra ID.

## Examples

### Example 1: Remove group app role assignment

```powershell
Connect-Entra -Scopes 'Directory.ReadWrite.All'
$group = Get-EntraGroup -Filter "displayName eq 'Contoso Marketing'"
$appRoleAssignment = Get-EntraGroupAppRoleAssignment -GroupId $group.Id | Where-Object {$_.ResourceDisplayName -eq 'Box'}
Remove-EntraGroupAppRoleAssignment -GroupId $group -AppRoleAssignmentId $appRoleAssignment.Id
```

This example demonstrates how to remove the specified group application role assignment.
GroupId - Specifies the object ID of a group.
AppRoleAssignmentId - Specifies the object ID of the group application role assignment.

## Parameters

### -AppRoleAssignmentId

Specifies the object ID of the group application role assignment.

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

### -GroupId

Specifies the object ID of a group in Microsoft Entra ID.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: ObjectId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related links

[Get-EntraGroupAppRoleAssignment](Get-EntraGroupAppRoleAssignment.md)

[New-EntraGroupAppRoleAssignment](New-EntraGroupAppRoleAssignment.md)
