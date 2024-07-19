---
title: Get-EntraBetaDirectoryRoleMember
description: This article provides details on the Get-EntraBetaDirectoryRoleMember command.


ms.topic: reference
ms.date: 07/19/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Get-EntraBetaDirectoryRoleMember

## Synopsis

Gets members of a directory role.

## Syntax

```powershell
Get-EntraBetaDirectoryRoleMember 
 -ObjectId <String> 
 [<CommonParameters>]
```

## Description

The `Get-EntraBetaDirectoryRoleMember` cmdlet gets the members of a directory role in Microsoft Entra ID. Specify `ObjectId` to get members of directory role.

## Examples

### Example 1: Get members by role ID

```powershell
Connect-Entra -Scopes 'RoleManagement.Read.Directory'
Get-EntraBetaDirectoryRoleMember -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
```

```Output
Id                                   DeletedDateTime
--                                   ---------------
bbbbbbbb-7777-8888-9999-cccccccccccc
```

This example retrieves the members of the specified role.

- `ObjectId` parameter specifies directory role ID.

## Parameters

### -ObjectId

Specifies the ID of a directory role in Microsoft Entra ID.

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

## Related Links

[Add-EntraBetaDirectoryRoleMember](Add-EntraBetaDirectoryRoleMember.md)

[Remove-EntraBetaDirectoryRoleMember](Remove-EntraBetaDirectoryRoleMember.md)
