---
title: Add-EntraScopedRoleMembership
description: This article provides details on the Add-EntraScopedRoleMembership command.

ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Entra.DirectoryManagement-Help.xml
Module Name: Microsoft.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Add-EntraScopedRoleMembership

schema: 2.0.0
---

# Add-EntraScopedRoleMembership

## Synopsis

Assign a Microsoft Entra role with an administrative unit scope.

## Syntax

```powershell
Add-EntraScopedRoleMembership
 -AdministrativeUnitId <String>
 [-RoleObjectId <String>]
 [-RoleMemberInfo <RoleMemberInfo>]
 [<CommonParameters>]
```

## Description

The `Add-EntraScopedRoleMembership` cmdlet adds a scoped role membership to an administrative unit. Specify `AdministrativeUnitId` parameter to add a scoped role membership.

For delegated scenarios, the calling user needs at least the Privileged Role Administrator Microsoft Entra role.

## Examples

### Example 1: Add a scoped role membership to an administrative unit

```powershell
Connect-Entra -Scopes 'RoleManagement.ReadWrite.Directory'
$user = Get-EntraUser -UserId 'SawyerM@contoso.com'
$role = Get-EntraDirectoryRole -Filter "DisplayName eq 'Helpdesk Administrator'" 
$administrativeUnit = Get-EntraAdministrativeUnit -Filter "DisplayName eq 'Pacific Administrative Unit'"
$roleMember = New-Object -TypeName Microsoft.Open.MSGraph.Model.MsRoleMemberInfo
$roleMember.Id = $user.Id
Add-EntraScopedRoleMembership -AdministrativeUnitId $administrativeUnit.Id -RoleObjectId $role.Id -RoleMemberInfo $roleMember
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

## Parameters

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

Specifies the ID of a directory role.

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

## Inputs

## Outputs

## Notes

## Related Links

[Get-EntraScopedRoleMembership](Get-EntraScopedRoleMembership.md)

[Remove-EntraScopedRoleMembership](Remove-EntraScopedRoleMembership.md)
