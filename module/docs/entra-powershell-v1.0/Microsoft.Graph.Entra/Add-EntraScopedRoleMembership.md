---
title: Add-EntraScopedRoleMembership.
description: This article provides details on the Add-EntraScopedRoleMembership command.

ms.service: active-directory
ms.topic: reference
ms.date: 06/05/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Add-EntraScopedRoleMembership

## SYNOPSIS

Adds a scoped role membership to an administrative unit.

## SYNTAX

```powershell
Add-EntraScopedRoleMembership
 -ObjectId <String> 
 [-AdministrativeUnitObjectId <String>]
 [-RoleObjectId <String>] 
 [-RoleMemberInfo <RoleMemberInfo>] 
 [<CommonParameters>]
```

## DESCRIPTION

The Add-EntraScopedRoleMembership cmdlet adds a scoped role membership to an administrative unit.

## EXAMPLES

### Example 1: Adds a scoped role membership to an administrative unit

```powershell
$User = Get-EntraUser -SearchString "The user that will be an admin on this unit"
$Role = Get-EntraDirectoryRole | Where-Object -Property DisplayName -EQ -Value "User Account Administrator"
$Unit = Get-EntraAdministrativeUnit | Where-Object -Property DisplayName -Eq -Value "<Display name of unit"
$RoleMember = New-Object -TypeName Microsoft.Open.AzureAD.Model.RoleMemberInfo
$RoleMember.ObjectId = $User.ObjectID
Add-EntraScopedRoleMembership -ObjectId $unit.ObjectId -RoleObjectId $Role.ObjectId -RoleMemberInfo $RoleMember
```

```output
@odata.context             : https://graph.microsoft.com/v1.0/$metadata#scopedRoleMemberships/$entity
administrativeUnitId       : aaaaaaaa-bbbb-cccc-aaaa-aaaaaaaa
roleMemberInfo             : @{id= aaaaaaaa-bbbb-cccc-aaaa-aaaaaaaa; userPrincipalName=DemoTests1ac196c1-3343-4419-8c3b-6f95c02a83e2@M365x99297270.OnMicrosoft.com;
                             displayName=DemoTests1ac196c1-3343-4419-8c3b-6f95c02a83e2}
id                         : zTVcE8KFQ0W4bI9tvt6kz5G_C9Qom7tCpCzyrakzL7YfYhUwtb_KQJI9hDn_fbKGU
roleId                     : dddddddd-bbbb-cccc-aaaa-aaaaaaaa
AdministrativeUnitObjectId : aaaaaaaa-bbbb-cccc-aaaa-aaaaaaaa
RoleObjectId               : ffffffff-bbbb-cccc-aaaa-aaaaaaaa
ObjectId                   : aaaaaaaaaaaaaaaaaaaaaa_bbbbbbbbbbbbbbbbbbbbbbbbbb_cccccccc_aaaaa
```

This example adds a scoped role membership to an administrative unit.

## PARAMETERS

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

[Get-EntraScopedRoleMembership](Get-EntraScopedRoleMembership.md)

[Remove-EntraScopedRoleMembership](Remove-EntraScopedRoleMembership.md)
