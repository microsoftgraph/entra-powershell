---
title: Remove-EntraBetaGroupAppRoleAssignment
description: This article provides details on the Remove-EntraBetaGroupAppRoleAssignment command.

ms.topic: reference
ms.date: 07/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Remove-EntraBetaGroupAppRoleAssignment

schema: 2.0.0
---

# Remove-EntraBetaGroupAppRoleAssignment

## Synopsis

Delete a group application role assignment.

## Syntax

```powershell
Remove-EntraBetaGroupAppRoleAssignment
 -GroupId <String>
 -AppRoleAssignmentId <String>
 [<CommonParameters>]
```

## Description

The `Remove-EntraBetaGroupAppRoleAssignment` cmdlet removes a group application role assignment from Microsoft Entra ID.

## Examples

### Example 1: Remove group app role assignment

```powershell
Connect-Entra -Scopes 'Directory.ReadWrite.All'
$group = Get-EntraBetaGroup -Filter "displayName eq 'Contoso Marketing'"
$appRoleAssignment = Get-EntraBetaGroupAppRoleAssignment -GroupId $group.Id | Where-Object {$_.ResourceDisplayName -eq 'Box'}
Remove-EntraBetaGroupAppRoleAssignment -GroupId $group -AppRoleAssignmentId $appRoleAssignment.Id
```

This example demonstrates how to remove the specified group application role assignment.

- `-GroupId` parameter specifies the object ID of a group.
- `-AppRoleAssignmentId` parameter specifies the object ID of a group application role assignment.

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

## Related Links

[Get-EntraBetaGroupAppRoleAssignment](Get-EntraBetaGroupAppRoleAssignment.md)

[New-EntraBetaGroupAppRoleAssignment](New-EntraBetaGroupAppRoleAssignment.md)
