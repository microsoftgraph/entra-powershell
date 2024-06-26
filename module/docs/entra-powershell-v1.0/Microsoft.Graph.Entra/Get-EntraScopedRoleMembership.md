---
Title: Get-EntraScopedRoleMembership
Description: This article provides details on the Get-EntraScopedRoleMembership command.

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

# Get-EntraScopedRoleMembership

## Synopsis

Gets a scoped role membership from an administrative unit.

## Syntax

```powershell
Get-EntraScopedRoleMembership 
 -Id <String> 
 [-ScopedRoleMembershipId <String>] 
 [<CommonParameters>]
```

## Description
The Get-EntraScopedRoleMembership cmdlet gets a scoped role membership from an administrative unit in Microsoft Entra ID.

## Examples

### Example 1: Get Scoped Role Administrator

```powershell
Connect-Entra -Scopes 'RoleManagement.Read.Directory'
Get-EntraScopedRoleMembership -Id 'bbbbbbbb-1111-2222-3333-cccccccccccc' -ScopedRoleMembershipId '3d3d3d3d-4444-eeee-5555-6f6f6f6f6f6f'
```

```Output
AdministrativeUnitId                 Id                                                                RoleId
--------------------                 --                                                                ------
Bbbbbbbb-1111-2222-3333-cccccccccccc 1b1b1b1b-2222-cccc-3333-4d4d4d4d4d4d 356b7173-5a6e-49dc-88ec-b...
```

This command gets the scoped role membership from a specified administrative unit with specified scoped role membership ID.

### Example 2: List scoped administrators for administrative unit

```powershell
Connect-Entra -Scopes 'RoleManagement.Read.Directory'
Get-EntraScopedRoleMembership -Id 'bbbbbbbb-1111-2222-3333-cccccccccccc'
```

```Output
AdministrativeUnitId                 Id                                                                RoleId
--------------------                 --                                                                ------
Bbbbbbbb-1111-2222-3333-cccccccccccc 1b1b1b1b-2222-cccc-3333-4d4d4d4d4d4d 8a20c604-291f-4cc3-b6d0-2...
Bbbbbbbb-1111-2222-3333-cccccccccccc 3d3d3d3d-4444-eeee-5555-6f6f6f6f6f6f 8a20c604-291f-4cc3-b6d0-2...
```

This command gets the list of scoped role membership from a specified administrative unit.

## Parameters

### -Id

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

## Inputs

## Outputs

## Notes

## Related Links

[Add-EntraScopedRoleMembership](Add-EntraScopedRoleMembership.md)

[Remove-EntraScopedRoleMembership](Remove-EntraScopedRoleMembership.md)

