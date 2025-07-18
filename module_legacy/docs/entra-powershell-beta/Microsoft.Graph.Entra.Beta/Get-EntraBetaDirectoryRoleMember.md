---
title: Get-EntraBetaDirectoryRoleMember
description: This article provides details on the Get-EntraBetaDirectoryRoleMember command.


ms.topic: reference
ms.date: 07/19/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: mwongerapk
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Get-EntraBetaDirectoryRoleMember

schema: 2.0.0
---

# Get-EntraBetaDirectoryRoleMember

## Synopsis

Gets members of a directory role.

## Syntax

```powershell
Get-EntraBetaDirectoryRoleMember
 -DirectoryRoleId <String>
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

The `Get-EntraBetaDirectoryRoleMember` cmdlet retrieves the members of a directory role in Microsoft Entra ID. To obtain the members of a specific directory role, specify the `DirectoryRoleId`. Use the `Get-EntraBetaDirectoryRole` cmdlet to get the `DirectoryRoleId` value.

## Examples

### Example 1: Get members by role ID

```powershell
Connect-Entra -Scopes 'RoleManagement.Read.Directory'
Get-EntraBetaDirectoryRoleMember -DirectoryRoleId '1708c380-4b8a-4977-a46e-6031676f6b41'
```

```Output
Id                                   DeletedDateTime
--                                   ---------------
bbbbbbbb-7777-8888-9999-cccccccccccc
```

This example retrieves the members of the specified role.

- `-DirectoryRoleId` parameter specifies directory role ID.

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

### -Property

Specifies properties to be returned.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related Links

[Add-EntraBetaDirectoryRoleMember](Add-EntraBetaDirectoryRoleMember.md)

[Remove-EntraBetaDirectoryRoleMember](Remove-EntraBetaDirectoryRoleMember.md)
