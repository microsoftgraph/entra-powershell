---
title: Remove-EntraBetaGroup
description: This article provides details on the Remove-EntraBetaGroup command.


ms.topic: reference
ms.date: 06/17/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Entra.Beta.Groups-Help.xml
Module Name: Microsoft.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Remove-EntraBetaGroup

schema: 2.0.0
---

# Remove-EntraBetaGroup

## Synopsis

Removes a group.

## Syntax

```powershell
Remove-EntraBetaGroup
 -GroupId <String>
 [<CommonParameters>]
```

## Description

The `Remove-EntraBetaGroup` cmdlet removes a group from Microsoft Entra ID. Specify the `GroupId` parameter removes a group.

Unified Group can be restored withing 30 days after deletion using the `Restore-EntraBetaDeletedDirectoryObject` cmdlet. Security groups can't be restored after deletion.

**Notes on permissions:**

The following conditions apply for apps to delete role-assignable groups:

- For delegated scenarios, the app must be assigned the `RoleManagement.ReadWrite.Directory` delegated permission, and the calling user must be the creator of the group or be assigned at least the Privileged Role Administrator Microsoft Entra role.
- For app-only scenarios, the calling app must be the owner of the group or be assigned the `RoleManagement.ReadWrite.Directory` application permission or be assigned at least the Privileged Role Administrator Microsoft Entra role.

## Examples

### Example 1: Remove a group

```powershell
Connect-Entra -Scopes 'Group.ReadWrite.All'
$group = Get-EntraBetaGroup -Filter "DisplayName eq 'HelpDesk Team Leaders'"
Remove-EntraBetaGroup -GroupId $group.Id
```

This example demonstrates how to remove a group in Microsoft Entra ID.

- `GroupId` parameter specifies the group ID .

### Example 2: Remove a group using pipelining

```powershell
Connect-Entra -Scopes 'Group.ReadWrite.All'
Get-EntraBetaGroup -Filter "DisplayName eq 'HelpDesk Team Leaders'" | Remove-EntraBetaGroup
```

This example demonstrates how to remove a group in Microsoft Entra ID.

## Parameters

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

[Get-EntraBetaGroup](Get-EntraBetaGroup.md)

[New-EntraBetaGroup](New-EntraBetaGroup.md)

[Set-EntraBetaGroup](Set-EntraBetaGroup.md)
