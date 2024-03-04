---
title: Add-EntraBetaMSScopedRoleMembership
description: This article provides details on the Add-EntraBetaMSScopedRoleMembership command.

ms.service: active-directory
ms.topic: reference
ms.date: 03/04/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Add-EntraBetaMSScopedRoleMembership

## SYNOPSIS
Adds a scoped role membership to an administrative unit.

## SYNTAX

```
Add-EntraBetaMSScopedRoleMembership [-AdministrativeUnitId <String>] -Id <String>
 [-RoleMemberInfo <MsRoleMemberInfo>] [-RoleId <String>] [<CommonParameters>]
```

## DESCRIPTION
The Add-EntraBetaMSScopedRoleMembership cmdlet adds a scoped role membership to an administrative unit.

## EXAMPLES

### Example 1
```
$User = Get-EntraBetaUser -SearchString "The user that will be an admin on this unit"
$Role = Get-EntraBetaDirectoryRole | Where-Object -Property DisplayName -Eq -Value "User Account Administrator"
$Unit = Get-EntraBetaMSAdministrativeUnit | Where-Object -Property DisplayName -Eq -Value "The display name of the unit"
$RoleMember = New-Object -TypeName Microsoft.Open.MSGraph.Model.MsRolememberinfo.RoleMemberInfo
$RoleMember.Id = $User.ObjectID
Add-EntraBetaMSScopedRoleMembership -Id $Unit.Id -RoleId $Role.ObjectId -RoleMemberInfo $RoleMember

AdministrativeUnitId					RoleId 	
--------------------------           	------------ 	
c9ab56cc-e349-4237-856e-cab03157a91e 	526b7173-5a6e-49dc-88ec-b677a9093709
```

This cmdlet returns the Scoped role membership object.

## PARAMETERS

### -Id
Specifies the ID of an admininstrative unit.

```yaml
Type: String
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
Type: MsRoleMemberInfo
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AdministrativeUnitId
Specifies the ID of an admininstrative unit.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RoleId
Specifies the ID of a directory role.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraBetaMSScopedRoleMembership]()

[Remove-EntraBetaMSScopedRoleMembership]()

