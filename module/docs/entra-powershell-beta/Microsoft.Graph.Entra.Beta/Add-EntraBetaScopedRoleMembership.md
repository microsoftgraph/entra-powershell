---
title: Add-EntraBetaScopedRoleMembership.
description: This article provides details on the Add-EntraBetaScopedRoleMembership command.

ms.service: entra
ms.topic: reference
ms.date: 07/05/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Add-EntraBetaScopedRoleMembership

## Synopsis

Assign a Microsoft Entra role with an administrative unit scope.

## Syntax

```powershell
Add-EntraBetaScopedRoleMembership 
 -ObjectId <String> 
 [-RoleMemberInfo <RoleMemberInfo>]
 [-AdministrativeUnitObjectId <String>] 
 [-RoleObjectId <String>] 
 [<CommonParameters>]
```

## Description

The `Add-EntraBetaScopedRoleMembership` cmdlet adds a scoped role membership to an administrative unit. Specify `ObjectId` parameter to add a scoped role membership.

For delegated scenarios, the calling user needs at least the Privileged Role Administrator Microsoft Entra role.

## Examples

### Example 1: Adds a scoped role membership to an administrative unit

```powershell
Connect-Entra -Scopes 'RoleManagement.ReadWrite.Directory'
$User = Get-EntraBetaUser -SearchString 'Conf Room Adams'
$Role = Get-EntraBetaDirectoryRole | Where-Object -Property DisplayName -EQ -Value 'User Administrator'
$Unit = Get-EntraBetaAdministrativeUnit | Where-Object -Property DisplayName -Eq -Value 'NewUnit'
$RoleMember = New-Object -TypeName Microsoft.Open.AzureAD.Model.RoleMemberInfo
$RoleMember.ObjectId = $User.ObjectID
$params = @{
    ObjectId = $unit.ObjectId
    RoleObjectId = $Role.ObjectId
    RoleMemberInfo = $RoleMember
}
Add-EntraBetaScopedRoleMembership @params
```

```Output
Id                                                                AdministrativeUnitId                 RoleId
--                                                                --------------------                 ------
dddddddddddd-bbbb-aaaa-bbbb-cccccccccccc aaaaaaaa-bbbb-aaaa-bbbb-cccccccccccc bbbbbbbb-1111-2222-3333-cccccccccccc
```

This example adds a scoped role membership to an administrative unit.

## Parameters

### -AdministrativeUnitObjectId

Specifies the ID of an admininstrative unit.

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

## Inputs

## Outputs

## Notes

## Related Links

[Get-EntraBetaScopedRoleMembership](Get-EntraBetaScopedRoleMembership.md)

[Remove-EntraBetaScopedRoleMembership](Remove-EntraBetaScopedRoleMembership.md)
