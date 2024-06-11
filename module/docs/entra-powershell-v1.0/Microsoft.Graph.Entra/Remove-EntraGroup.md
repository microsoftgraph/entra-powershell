---
title: Remove-EntraGroup
description: This article provides details on the Remove-EntraGroup command.

ms.service: entra
ms.topic: reference
ms.date: 03/05/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Remove-EntraGroup

## SYNOPSIS

Removes a group.

## SYNTAX

```powershell
Remove-EntraGroup 
 -ObjectId <String> 
 [<CommonParameters>]
```

## DESCRIPTION

The Remove-EntraGroup cmdlet removes a group from Microsoft Entra ID.
Note that a Unified Group can be restored withing 30 days after deletion using the Restore-EntraMSDeletedDirectoryObject cmdlet.
Security groups can't be restored after deletion.

**Notes on permissions:**

The following conditions apply for apps to delete role-assignable groups:

- For delegated scenarios, the app must be assigned the `RoleManagement.ReadWrite.Directory` delegated permission, and the calling user must be the creator of the group or be assigned at least the Privileged Role Administrator Microsoft Entra role.
- For app-only scenarios, the calling app must be the owner of the group or be assigned the `RoleManagement.ReadWrite.Directory` application permission or be assigned at least the Privileged Role Administrator Microsoft Entra role.

## EXAMPLES

### Example 1: Remove a group

```powershell
Connect-Entra -Scopes 'Group.ReadWrite.All'
Remove-EntraGroup -ObjectId 'hhhhhhhh-3333-5555-3333-qqqqqqqqqqqq'
```

This command is used to remove a group. The `-ObjectId` parameter specifies the ID of the group to be removed.

## PARAMETERS

### -ObjectId

Specifies the object ID of a group in Microsoft Entra ID.

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

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraGroup](Get-EntraGroup.md)

[New-EntraGroup](New-EntraGroup.md)

[Set-EntraGroup](Set-EntraGroup.md)
