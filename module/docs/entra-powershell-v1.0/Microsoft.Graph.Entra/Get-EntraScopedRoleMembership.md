---
title: Get-EntraScopedRoleMembership
description: This article provides details on the Get-EntraScopedRoleMembership command.
ms.service: entra
ms.topic: reference
ms.date: 06/10/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraScopedRoleMembership

## SYNOPSIS

Gets a scoped role membership from an administrative unit.

## SYNTAX

```powershell

Get-EntraScopedRoleMembership 
 -ObjectId <String> 
 [-ScopedRoleMembershipId <String>] 
 [<CommonParameters>]
```

## DESCRIPTION

The Get-EntraScopedRoleMembership cmdlet gets a scoped role membership from an administrative unit in Microsoft Entra ID.

## EXAMPLES

### Example 1: Get Scoped Role Administrator

```powershell
Get-EntraScopedRoleMembership -ObjectId 'aaaaaaaa-bbbb-aaaa-bbbb-cccccccccccc' -ScopedRoleMembershipId 'dddddddddddd-bbbb-aaaa-bbbb-cccccccccccc'
```

```output
@odata.context             : https://graph.microsoft.com/v1.0/$metadata#scopedRoleMemberships/$entity
administrativeUnitId       : aaaaaaaa-bbbb-aaaa-bbbb-cccccccccccc
roleMemberInfo             : @{id=aaaaaaaa-eeee-aaaa-bbbb-cccccccccccc; userPrincipalName=DemoTestse33f1405-fafc-479d-91d8-2bf695ef5c52@M365x99297270.OnMicrosoft.com;
                             displayName=DemoTestse33f1405-fafc-479d-91d8-2bf695ef5c52}
id                         : xxxxxxE8KFQ0nnnnI9tvt6kz5G_C9Qom7tCpkkkrakzL7bhrxVy03_eiiiiiiiiTc4HGU
roleId                     : aaaaaaaa-bbbb-aaaa-bbbb-cccccccccccc
AdministrativeUnitObjectId : gggggggg-bbbb-aaaa-bbbb-cccccccccccc
RoleObjectId               : eeeeeeee-bbbb-aaaa-bbbb-cccccccccccc
ObjectId                   : eeeeeeeeeeeeeeeeeeee_aaaaaaaaaaaaaaaaaaaaaaaaa_cccccccccccccc
```

This example gets Scoped Role Administrator.

### Example 2: List scoped administrators with objectId

```powershell
Get-EntraScopedRoleMembership -ObjectId 'aaaaaaaa-bbbb-aaaa-bbbb-cccccccccccc'
```

```output
@odata.context             : https://graph.microsoft.com/v1.0/$metadata#scopedRoleMemberships/$entity
administrativeUnitId       : aaaaaaaa-bbbb-aaaa-bbbb-cccccccccccc
roleMemberInfo             : @{id=aaaaaaaa-eeee-aaaa-bbbb-cccccccccccc; userPrincipalName=DemoTestse33f1405-fafc-479d-91d8-2bf695ef5c52@M365x99297270.OnMicrosoft.com;
                             displayName=DemoTestse33f1405-fafc-479d-91d8-2bf695ef5c52}
id                         : xxxxxxE8KFQ0nnnnI9tvt6kz5G_C9Qom7tCpkkkrakzL7bhrxVy03_eiiiiiiiiTc4HGU
roleId                     : aaaaaaaa-bbbb-aaaa-bbbb-cccccccccccc
AdministrativeUnitObjectId : gggggggg-bbbb-aaaa-bbbb-cccccccccccc
RoleObjectId               : eeeeeeee-bbbb-aaaa-bbbb-cccccccccccc
ObjectId                   : eeeeeeeeeeeeeeeeeeee_aaaaaaaaaaaaaaaaaaaaaaaaa_cccccccccccccc
```

This example list scoped administrators with objectId.

## PARAMETERS

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

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Add-EntraScopedRoleMembership](Add-EntraScopedRoleMembership.md)

[Remove-EntraScopedRoleMembership](Remove-EntraScopedRoleMembership.md)
