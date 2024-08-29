---
title: Get-EntraScopedRoleMembership.
description: This article provides details on the Get-EntraScopedRoleMembership command.

ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Get-EntraScopedRoleMembership

schema: 2.0.0
---

# Get-EntraScopedRoleMembership

## Synopsis

Gets a scoped role membership from an administrative unit.

## Syntax

```powershell
Get-EntraScopedRoleMembership 
 -ObjectId <String>
 [-ScopedRoleMembershipId <String>]
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

The `Get-EntraScopedRoleMembership` cmdlet gets a scoped role membership from an administrative unit in Microsoft Entra ID.

## Examples

### Example 1: Get Scoped Role Administrator

```powershell
Connect-Entra -Scopes 'RoleManagement.Read.Directory'
$params = @{
    ObjectId = 'aaaaaaaa-bbbb-aaaa-bbbb-cccccccccccc'
    ScopedRoleMembershipId = 'dddddddddddd-bbbb-aaaa-bbbb-cccccccccccc'
}
Get-EntraScopedRoleMembership @params
```

```Output
Id                                   AdministrativeUnitId                 RoleId
--                                   --------------------                 ------
aaaaaaaa-bbbb-aaaa-bbbb-cccccccccccc bbbbbbbb-1111-2222-3333-cccccccccccc 00000000-0000-0000-0000-000000000000

```

This command gets the scoped role membership from a specified administrative unit with specified scoped role membership ID.

- `-ObjectId` Specifies the ID of an administrative unit.
- `-ScopedRoleMembershipId` Specifies a description, which you want to update.

### Example 2: List scoped administrators for administrative unit

```powershell
Connect-Entra -Scopes 'RoleManagement.Read.Directory'
Get-EntraScopedRoleMembership -ObjectId 'bbbbbbbb-1111-2222-3333-cccccccccccc'
```

```Output
Id                                   AdministrativeUnitId                 RoleId
--                                   --------------------                 ------
aaaaaaaa-bbbb-aaaa-bbbb-cccccccccccc bbbbbbbb-1111-2222-3333-cccccccccccc 00000000-0000-0000-0000-000000000000
```

This command gets the list of scoped role membership from a specified administrative unit.

- `-ObjectId` Specifies the ID of an administrative unit.

## Parameters

### -ObjectId

Specifies the ID of an object.

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

### -ScopedRoleMembershipId

Specifies the ID of a scoped role membership.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
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

[Add-EntraScopedRoleMembership](Add-EntraScopedRoleMembership.md)

[Remove-EntraScopedRoleMembership](Remove-EntraScopedRoleMembership.md)
