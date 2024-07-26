---
title: Add-EntraScopedRoleMembership
description: This article provides details on the Add-EntraScopedRoleMembership command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Add-EntraScopedRoleMembership

schema: 2.0.0
---

# Add-EntraScopedRoleMembership

## Synopsis

Adds a scoped role membership to an administrative unit.

## Syntax

```powershell
Add-EntraScopedRoleMembership
 -ObjectId <String> 
 [-AdministrativeUnitObjectId <String>]
 [-RoleObjectId <String>] 
 [-RoleMemberInfo <RoleMemberInfo>] 
 [<CommonParameters>]
```

## Description

The `Add-EntraScopedRoleMembership` cmdlet adds a scoped role membership to an administrative unit.

## Examples

### Example 1: Add a scoped role membership to an administrative unit

```powershell
Connect-Entra -Scopes 'RoleManagement.ReadWrite.Directory'
$User = Get-EntraUser -SearchString 'MarkWood'
$Role = Get-EntraDirectoryRole -Filter "DisplayName eq 'User Administrator'"
$Unit = Get-EntraAdministrativeUnit -Filter "DisplayName eq 'New MSAdmin unit'"
$RoleMember = New-Object -TypeName Microsoft.Open.MSGraph.Model.MsRolememberinfo
$RoleMember.Id = $User.ObjectID
Add-EntraScopedRoleMembership -ObjectId $Unit.Id -RoleObjectId $Role.ObjectId -RoleMemberInfo $RoleMember
```

```output
@odata.context             : https://graph.microsoft.com/v1.0/$metadata#scopedRoleMemberships/$entity
administrativeUnitId       : aaaaaaaa-bbbb-cccc-aaaa-aaaaaaaa
roleMemberInfo             : @{id= aaaaaaaa-bbbb-cccc-aaaa-aaaaaaaa;     userPrincipalName=DemoTests1ac196c1-3343-4419-8c3b-6f95c02a83e2@M365x99297270.OnMicrosoft.com;
                             displayName=DemoTests1ac196c1-3343-4419-8c3b-6f95c02a83e2}
id                         : zTVcE8KFQ0W4bI9tvt6kz5G_C9Qom7tCpCzyrakzL7YfYhUwtb_KQJI9hDn_fbKGU
roleId                     : dddddddd-bbbb-cccc-aaaa-aaaaaaaa
AdministrativeUnitObjectId : aaaaaaaa-bbbb-cccc-aaaa-aaaaaaaa
RoleObjectId               : ffffffff-bbbb-cccc-aaaa-aaaaaaaa
ObjectId                   : aaaaaaaaaaaaaaaaaaaaaa_bbbbbbbbbbbbbbbbbbbbbbbbbb_cccccccc_aaaaa
```

The example shows how to add a user to the specified role within the specified administrative unit.

## Parameters

### -AdministrativeUnitObjectId

Specifies the ID of an administrative unit.

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

### -ObjectId

Specifies the ID of an administrative unit.

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

### -RoleMemberInfo

Specifies a RoleMemberInfo object.

```yaml
Type: System.MsRoleMemberInfo
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
