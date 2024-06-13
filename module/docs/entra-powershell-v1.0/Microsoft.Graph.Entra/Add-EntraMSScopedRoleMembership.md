---
title: Add-EntraMSScopedRoleMembership
description: This article provides details on the Add-EntraMSScopedRoleMembership command.

ms.service: entra
ms.topic: reference
ms.date: 03/04/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Add-EntraMSScopedRoleMembership

## Synopsis
Adds a scoped role membership to an administrative unit.

## Syntax

```powershell
Add-EntraMSScopedRoleMembership 
 -Id <String>
 [-RoleMemberInfo <MsRoleMemberInfo>] 
 [-AdministrativeUnitId <String>] 
 [-RoleId <String>] 
 [<CommonParameters>]
```

## Description
The Add-EntraMSScopedRoleMembership cmdlet adds a scoped role membership to an administrative unit.

## Examples

### Example 1: Add a scoped role membership to an administrative unit
```powershell
PS C:\> $User = Get-EntraUser -SearchString "The user that will be an admin on this unit"
PS C:\> $Role = Get-EntraDirectoryRole | Where-Object -Property DisplayName -EQ -Value "User Account Administrator"
PS C:\> $Unit = Get-EntraMSAdministrativeUnit | Where-Object -Property DisplayName -Eq -Value "<The display name of the unit>"
PS C:\> $RoleMember = New-Object -TypeName Microsoft.Open.MSGraph.Model.MsRolememberinfo.RoleMemberInfo
PS C:\> $RoleMember.Id = $User.ObjectID
PS C:\> Add-EntraMSScopedRoleMembership -Id $Unit.Id -RoleId $Role.ObjectId -RoleMemberInfo $RoleMember
```

```output
AdministrativeUnitId					RoleId 	
--------------------------           	------------ 	
c9ab56cc-e349-4237-856e-cab03157a91e 	526b7173-5a6e-49dc-88ec-b677a9093709
```

The first command gets a user by using the [Get-EntraUser](./Get-EntraUser.md) cmdlet, and then stores it in the $User variable.  

The second command gets a directory role by using [Get-EntraDirectoryRole](./Get-EntraDirectoryRole.md) cmdlet, and then stores it in the $Role variable.  

The third command gets an administrative unit by using [Get-EntraMSAdministrativeUnit](./Get-EntraMSAdministrativeUnit.md) cmdlet, and then stores it in the $Unit variable.  

The fourth command creates a RoleMemberInfo type, and then stores it in the $RoleMember variable.  

The fifth command set the Id property of $RoleMember to the same value as the ObjectId property of $User.  

The final command assigns the role member in $RoleMember and role in $Role to the administrative unit in $Unit.  

This cmdlet returns the Scope role membership object.

## Parameters

### -AdministrativeUnitId
Specifies the ID of an administrative unit.

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

### -Id
Specifies the ID of an administrative unit.

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related LINKS

[Get-EntraMSScopedRoleMembership](Get-EntraMSScopedRoleMembership.md)

[Remove-EntraMSScopedRoleMembership](Remove-EntraMSScopedRoleMembership.md)

