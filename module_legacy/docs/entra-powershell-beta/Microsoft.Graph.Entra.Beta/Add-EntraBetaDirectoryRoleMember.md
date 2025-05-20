---
title: Add-EntraBetaDirectoryRoleMember
description: This article provides details on the Add-EntraBetaDirectoryRoleMember command.

ms.topic: reference
ms.date: 07/19/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Add-EntraBetaDirectoryRoleMember

schema: 2.0.0
---

# Add-EntraBetaDirectoryRoleMember

## Synopsis

Adds a member to a directory role.

## Syntax

```powershell
Add-EntraBetaDirectoryRoleMember
 -DirectoryRoleId <String>
 -RefObjectId <String>
 [<CommonParameters>]
```

## Description

The `Add-EntraBetaDirectoryRoleMember` cmdlet adds a member to a Microsoft Entra ID role.

## Examples

### Example 1: Add a member to a Microsoft Entra ID role

```powershell
Connect-Entra -Scopes 'RoleManagement.ReadWrite.Directory'
$params = @{
    DirectoryRoleId = '019ea7a2-1613-47c9-81cb-20ba35b1ae48'
    RefObjectId = 'bbbbbbbb-1111-2222-3333-cccccccccccc'
}
Add-EntraBetaDirectoryRoleMember @params
```

This example adds a member to a directory role.

- `DirectoryRoleId` parameter specifies the ID of the directory role to which the member will be added. Use the  `Get-EntraBetaDirectoryRole` command to retrieve the details of the directory role.
- `RefObjectId` parameter specifies the ID of Microsoft Entra ID object to assign as owner/manager/member.

## Parameters

### -DirectoryRoleId

Specifies the ID of a directory role in Microsoft Entra ID.

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

### -RefObjectId

Specifies the ID of the Microsoft Entra ID object to assign as owner/manager/member.

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

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related links

[Get-EntraBetaDirectoryRoleMember](Get-EntraBetaDirectoryRoleMember.md)

[Remove-EntraBetaDirectoryRoleMember](Remove-EntraBetaDirectoryRoleMember.md)
