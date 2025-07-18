---
description: This article provides details on the Remove-EntraGroupAppRoleAssignment command.
external help file: Microsoft.Entra.Groups-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra
ms.author: eunicewaweru
ms.date: 06/26/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Remove-EntraGroupAppRoleAssignment
schema: 2.0.0
title: Remove-EntraGroupAppRoleAssignment
---

# Remove-EntraGroupAppRoleAssignment

## SYNOPSIS

Delete a group application role assignment.

## SYNTAX

```powershell
Remove-EntraGroupAppRoleAssignment
 -AppRoleAssignmentId <String>
 -GroupId <String>
[<CommonParameters>]
```

## DESCRIPTION

The `Remove-EntraGroupAppRoleAssignment` cmdlet removes a group application role assignment from Microsoft Entra ID.

## EXAMPLES

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

## PARAMETERS

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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraGroupAppRoleAssignment](Get-EntraGroupAppRoleAssignment.md)

[New-EntraGroupAppRoleAssignment](New-EntraGroupAppRoleAssignment.md)
