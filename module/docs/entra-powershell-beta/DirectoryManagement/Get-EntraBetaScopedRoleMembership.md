---
author: msewaweru
description: This article provides details on the Get-EntraBetaScopedRoleMembership command.
external help file: Microsoft.Entra.Beta.DirectoryManagement-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.Beta.DirectoryManagement
ms.author: eunicewaweru
ms.date: 07/05/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta.DirectoryManagement/Get-EntraBetaScopedRoleMembership
schema: 2.0.0
title: Get-EntraBetaScopedRoleMembership
---

# Get-EntraBetaScopedRoleMembership

## SYNOPSIS

List Microsoft Entra role assignments with administrative unit scope.

## SYNTAX

```powershell
Get-EntraBetaScopedRoleMembership
 -AdministrativeUnitId <String>
 [-ScopedRoleMembershipId <String>]
 [-Property <String[]>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Get-EntraBetaScopedRoleMembership` cmdlet lists Microsoft Entra role assignments with an administrative unit scope. Use the `AdministrativeUnitId` parameter to retrieve a specific scoped role membership.

## EXAMPLES

### Example 1: Get Scoped Role Administrator

```powershell
Connect-Entra -Scopes 'RoleManagement.Read.Directory'
$role = Get-EntraBetaDirectoryRole -Filter "DisplayName eq 'Helpdesk Administrator'" 
$administrativeUnit = Get-EntraBetaAdministrativeUnit -Filter "DisplayName eq 'Pacific Administrative Unit'"
$roleMembership = Get-EntraBetaScopedRoleMembership -AdministrativeUnitId $administrativeUnit.Id | Where-Object {$_.RoleId -eq $role.Id}
Get-EntraBetaScopedRoleMembership -AdministrativeUnitId $administrativeUnit.Id -ScopedRoleMembershipId $roleMembership.Id
```

```Output
Id                                                                AdministrativeUnitId                 RoleId
--                                                                --------------------                 ------
dddddddddddd-bbbb-aaaa-bbbb-cccccccccccc aaaaaaaa-bbbb-aaaa-bbbb-cccccccccccc bbbbbbbb-1111-2222-3333-cccccccccccc
```

This example gets scoped role administrator. You cane use the command `Get-EntraBetaAdministrativeUnit` to get administrative unit Id.

- `-AdministrativeUnitId` parameter specifies the ID of an administrative unit.
- `-ScopedRoleMembershipId` parameter specifies the scoped role membership Id.

### Example 2: List scoped administrators for administrative unit by AdministrativeUnitId

```powershell
Connect-Entra -Scopes 'RoleManagement.Read.Directory'
$administrativeUnit = Get-EntraBetaAdministrativeUnit -Filter "DisplayName eq 'Pacific Administrative Unit'"
Get-EntraBetaScopedRoleMembership -AdministrativeUnitId $administrativeUnit.Id
```

```Output
Id                                                                AdministrativeUnitId                 RoleId
--                                                                --------------------                 ------
dddddddddddd-bbbb-aaaa-bbbb-cccccccccccc aaaaaaaa-bbbb-aaaa-bbbb-cccccccccccc bbbbbbbb-1111-2222-3333-cccccccccccc
```

This example list scoped administrators with AdministrativeUnitId.

- `-AdministrativeUnitId` parameter specifies the ID of an administrative unit.

## PARAMETERS

### -AdministrativeUnitId

Specifies the ID of an administrative unit object.

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
Aliases: Select

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Add-EntraBetaScopedRoleMembership](Add-EntraBetaScopedRoleMembership.md)

[Remove-EntraBetaScopedRoleMembership](Remove-EntraBetaScopedRoleMembership.md)
