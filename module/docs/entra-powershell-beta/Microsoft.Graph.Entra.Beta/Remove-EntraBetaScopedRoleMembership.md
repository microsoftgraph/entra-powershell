---
title: Remove-EntraBetaScopedRoleMembership
description: This article provides details on the Remove-EntraBetaScopedRoleMembership command.


ms.topic: reference
ms.date: 07/06/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Remove-EntraBetaScopedRoleMembership

schema: 2.0.0
---

# Remove-EntraBetaScopedRoleMembership

## Synopsis

Removes a scoped role membership.

## Syntax

```powershell
Remove-EntraBetaScopedRoleMembership
 -AdministrativeUnitId <String>
 -ScopedRoleMembershipId <String>
 [<CommonParameters>]
```

## Description

The `Remove-EntraBetaScopedRoleMembership` cmdlet removes a scoped role membership from Microsoft Entra ID. Specify `AdministrativeUnitId` and `ScopedRoleMembershipId` parameter to remove a scoped role membership.

## Examples

### Example 1: Remove a scoped role membership

```powershell
Connect-Entra -Scopes 'RoleManagement.Read.Directory'
$AdministrativeUnit = Get-EntraBetaAdministrativeUnit -Filter "DisplayName eq '<administrativeunit-display-name>'"
$params = @{
    AdministrativeUnitId = $AdministrativeUnit.ObjectId
    ScopedRoleMembershipId = 'dddddddddddd-bbbb-aaaa-bbbb-cccccccccccc'
}
Remove-EntraBetaScopedRoleMembership @params
```

This cmdlet removes a specific scoped role membership from Microsoft Entra ID. You can use the command `Get-EntraBetaAdministrativeUnit` to get administrative unit Id.

- `-AdministrativeUnitId` parameter specifies the ID of an administrative unit.
- `-ScopedRoleMembershipId` parameter specifies the ID of the scoped role membership to remove. To obtain the details of a scoped role membership, you can use the `Get-EntraBetaScopedRoleMembership` command.

## Parameters

### -AdministrativeUnitId

Specifies the ID of an administrative unit object.

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

Specifies the ID of the scoped role membership to remove.

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

[Add-EntraBetaScopedRoleMembership](Add-EntraBetaScopedRoleMembership.md)

[Get-EntraBetaScopedRoleMembership](Get-EntraBetaScopedRoleMembership.md)
