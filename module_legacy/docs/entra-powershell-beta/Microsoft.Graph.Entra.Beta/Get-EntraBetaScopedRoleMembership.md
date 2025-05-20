---
title: Get-EntraBetaScopedRoleMembership
description: This article provides details on the Get-EntraBetaScopedRoleMembership command.


ms.topic: reference
ms.date: 07/05/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Get-EntraBetaScopedRoleMembership

schema: 2.0.0
---

# Get-EntraBetaScopedRoleMembership

## Synopsis

List Microsoft Entra role assignments with administrative unit scope.

## Syntax

```powershell
Get-EntraBetaScopedRoleMembership
 -AdministrativeUnitId <String>
 [-ScopedRoleMembershipId <String>]
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

The `Get-EntraBetaScopedRoleMembership` cmdlet lists Microsoft Entra role assignments with an administrative unit scope. Use the `AdministrativeUnitId` parameter to retrieve a specific scoped role membership.

## Examples

### Example 1: Get Scoped Role Administrator

```powershell
Connect-Entra -Scopes 'RoleManagement.Read.Directory'
$AdministrativeUnit = Get-EntraBetaAdministrativeUnit -Filter "DisplayName eq '<administrativeunit-display-name>'"
$params = @{
    AdministrativeUnitId = $AdministrativeUnit.ObjectId
    ScopedRoleMembershipId = 'dddddddddddd-bbbb-aaaa-bbbb-cccccccccccc'
}
Get-EntraBetaScopedRoleMembership @params
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
$AdministrativeUnit = Get-EntraBetaAdministrativeUnit -Filter "DisplayName eq '<administrativeunit-display-name>'"
Get-EntraBetaScopedRoleMembership -AdministrativeUnitId $AdministrativeUnit.ObjectId
```

```Output
Id                                                                AdministrativeUnitId                 RoleId
--                                                                --------------------                 ------
dddddddddddd-bbbb-aaaa-bbbb-cccccccccccc aaaaaaaa-bbbb-aaaa-bbbb-cccccccccccc bbbbbbbb-1111-2222-3333-cccccccccccc
```

This example list scoped administrators with AdministrativeUnitId.

- `-AdministrativeUnitId` parameter specifies the ID of an administrative unit.

## Parameters

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

[Add-EntraBetaScopedRoleMembership](Add-EntraBetaScopedRoleMembership.md)

[Remove-EntraBetaScopedRoleMembership](Remove-EntraBetaScopedRoleMembership.md)
