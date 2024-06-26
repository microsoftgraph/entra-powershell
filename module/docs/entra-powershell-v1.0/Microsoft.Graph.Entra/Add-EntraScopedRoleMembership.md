---
Title: Add-EntraScopedRoleMembership
Description: This article provides details on the Add-EntraScopedRoleMembership command.

Ms.service: entra
Ms.topic: reference
Ms.date: 06/26/2024
Ms.author: eunicewaweru
Ms.reviewer: stevemutungi
Manager: CelesteDG

External help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
Online version:
Schema: 2.0.0
---

# Add-EntraScopedRoleMembership

## Synopsis

Adds a scoped role membership to an administrative unit.

## Syntax

```powershell
Add-EntraScopedRoleMembership 
 -Id <String>
 [-RoleMemberInfo <MsRoleMemberInfo>] 
 [-AdministrativeUnitId <String>] 
 [-RoleId <String>] 
 [<CommonParameters>]
```

## Description

The Add-EntraScopedRoleMembership cmdlet Adds a scoped role membership to an administrative unit.

## Examples

### Example 1: Add a scoped role membership to an administrative unit

```powershell
Connect-Entra -Scopes 'RoleManagement.ReadWrite.Directory'
$User = Get-EntraUser -SearchString 'MarkWood'
$Role = Get-EntraDirectoryRole -Filter "DisplayName eq 'User Administrator'"
$Unit = Get-EntraAdministrativeUnit -Filter "DisplayName eq 'New MSAdmin unit'"
$RoleMember = New-Object -TypeName Microsoft.Open.MSGraph.Model.MsRolememberinfo.RoleMemberInfo
$RoleMember.Id = $User.ObjectID
Add-EntraScopedRoleMembership -Id $Unit.Id -RoleId $Role.ObjectId -RoleMemberInfo $RoleMember
```

```Output
AdministrativeUnitId     RoleId  
--------------------------            ------------  
11bb11bb-cc22-dd33-ee44-55ff55ff55ff  22cc22cc-dd33-ee44-ff55-66aa66aa66aa
```

The example shows how to add a user to the specified role within the specified administrative unit.

## Parameters

### -AdministrativeUnitId

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

### -Id

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

### -RoleId

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
