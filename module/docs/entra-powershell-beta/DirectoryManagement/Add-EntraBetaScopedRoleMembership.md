---
author: msewaweru
description: This article provides details on the Add-EntraBetaScopedRoleMembership command.
external help file: Microsoft.Entra.Beta.DirectoryManagement-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 08/06/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Add-EntraBetaScopedRoleMembership
schema: 2.0.0
title: Add-EntraBetaScopedRoleMembership
---

# Add-EntraBetaScopedRoleMembership

## SYNOPSIS

Assign a Microsoft Entra role with an administrative unit scope.

## SYNTAX

```powershell
Add-EntraBetaScopedRoleMembership
 -AdministrativeUnitId <String>
 [-RoleMemberInfo <RoleMemberInfo>]
 [-RoleObjectId <String>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Add-EntraBetaScopedRoleMembership` cmdlet adds a scoped role membership to an administrative unit. Specify `AdministrativeUnitId` parameter to add a scoped role membership.

For delegated scenarios, the calling user needs at least the Privileged Role Administrator Microsoft Entra role.

## EXAMPLES

### Example 1: Add a scoped role membership to an administrative unit

```powershell
Connect-Entra -Scopes 'RoleManagement.ReadWrite.Directory'
$user = Get-EntraBetaUser -UserId 'SawyerM@contoso.com'
$role = Get-EntraBetaDirectoryRole -Filter "DisplayName eq 'Helpdesk Administrator'" 
$administrativeUnit = Get-EntraBetaAdministrativeUnit -Filter "DisplayName eq 'Pacific Administrative Unit'"
$roleMember = New-Object -TypeName Microsoft.Open.MSGraph.Model.MsRoleMemberInfo
$roleMember.Id = $user.Id
Add-EntraBetaScopedRoleMembership -AdministrativeUnitId $administrativeUnit.Id -RoleObjectId $role.Id -RoleMemberInfo $roleMember
```

```Output
Id                                                                AdministrativeUnitId                 RoleId
--                                                                --------------------                 ------
dddddddddddd-bbbb-aaaa-bbbb-cccccccccccc aaaaaaaa-bbbb-aaaa-bbbb-cccccccccccc bbbbbbbb-1111-2222-3333-cccccccccccc
```

The example shows how to add a user to the specified role within the specified administrative unit.

- `-AdministrativeUnitId` Parameter specifies the ID of an administrative unit.
- `-RoleObjectId` Parameter specifies the ID of a directory role.
- `-RoleMemberInfo` Parameter specifies a RoleMemberInfo object.

## PARAMETERS

### -AdministrativeUnitId

Specifies the ID of an administrative unit.

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

### -RoleMemberInfo

Specifies a RoleMemberInfo object.

```yaml
Type: System.RoleMemberInfo
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RoleObjectId

Specifies DirectoryRole ID.

```yaml
Type: System.String
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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraBetaScopedRoleMembership](Get-EntraBetaScopedRoleMembership.md)

[Remove-EntraBetaScopedRoleMembership](Remove-EntraBetaScopedRoleMembership.md)
