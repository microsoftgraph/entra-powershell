---
author: msewaweru
description: This article provides details on the Remove-EntraBetaScopedRoleMembership command.
external help file: Microsoft.Entra.Beta.DirectoryManagement-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 07/06/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Remove-EntraBetaScopedRoleMembership
schema: 2.0.0
title: Remove-EntraBetaScopedRoleMembership
---

# Remove-EntraBetaScopedRoleMembership

## SYNOPSIS

Removes a scoped role membership.

## SYNTAX

```powershell
Remove-EntraBetaScopedRoleMembership
 -AdministrativeUnitId <String>
 -ScopedRoleMembershipId <String>
 [<CommonParameters>]
```

## DESCRIPTION

The `Remove-EntraBetaScopedRoleMembership` cmdlet removes a scoped role membership from Microsoft Entra ID. Specify `AdministrativeUnitId` and `ScopedRoleMembershipId` parameter to remove a scoped role membership.

## EXAMPLES

### Example 1: Remove a scoped role membership

```powershell
Connect-Entra -Scopes 'RoleManagement.Read.Directory'
$role = Get-EntraBetaDirectoryRole -Filter "DisplayName eq 'Helpdesk Administrator'" 
$administrativeUnit = Get-EntraBetaAdministrativeUnit -Filter "DisplayName eq 'Pacific Administrative Unit'"
$roleMembership = Get-EntraBetaScopedRoleMembership -AdministrativeUnitId $administrativeUnit.Id | Where-Object {$_.RoleId -eq $role.Id}
Remove-EntraBetaScopedRoleMembership -AdministrativeUnitId $administrativeUnit.Id -ScopedRoleMembershipId $roleMembership.Id
```

This cmdlet removes a specific scoped role membership from Microsoft Entra ID. You can use the command `Get-EntraBetaAdministrativeUnit` to get administrative unit Id.

- `-AdministrativeUnitId` parameter specifies the ID of an administrative unit.
- `-ScopedRoleMembershipId` parameter specifies the ID of the scoped role membership to remove. To obtain the details of a scoped role membership, you can use the `Get-EntraBetaScopedRoleMembership` command.

## PARAMETERS

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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Add-EntraBetaScopedRoleMembership](Add-EntraBetaScopedRoleMembership.md)

[Get-EntraBetaScopedRoleMembership](Get-EntraBetaScopedRoleMembership.md)
