---
title: Remove-EntraBetaDirectoryRoleMember
description: This article provides details on the Remove-EntraBetaDirectoryRoleMember command.

ms.topic: reference
ms.date: 07/19/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: mwongerapk
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Remove-EntraBetaDirectoryRoleMember

schema: 2.0.0
---

# Remove-EntraBetaDirectoryRoleMember

## Synopsis

Removes a member of a directory role.

## Syntax

```powershell
Remove-EntraBetaDirectoryRoleMember
 -DirectoryRoleId <String>
 -MemberId <String>
 [<CommonParameters>]
```

## Description

The `Remove-EntraBetaDirectoryRoleMember` cmdlet removes a member from a directory role in Microsoft Entra ID.

## Examples

### Example 1: Remove a member from a directory role

```powershell
Connect-Entra -Scopes 'RoleManagement.ReadWrite.Directory'
$params = @{
    DirectoryRoleId = 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'
    MemberId = 'bbbbbbbb-1111-2222-3333-cccccccccccc'
}
Remove-EntraBetaDirectoryRoleMember @params
```

This example removes the specified member from the specified role.

- `-DirectoryRoleId` parameter specifies the object ID of the directory role.
- `-MemberId` parameter specifies the object ID of the role member to removed.

## Parameters

### -MemberId

Specifies the object ID of a role member.

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

### -DirectoryRoleId

Specifies the object ID of a directory role in Microsoft Entra ID.

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

[Add-EntraBetaDirectoryRoleMember](Add-EntraBetaDirectoryRoleMember.md)

[Get-EntraBetaDirectoryRoleMember](Get-EntraBetaDirectoryRoleMember.md)
