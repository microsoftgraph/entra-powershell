---
Title: Remove-EntraScopedRoleMembership.
Description: This article provides details on the Remove-EntraScopedRoleMembership command.

Ms.service: entra
Ms.topic: reference
Ms.date: 06/26/2024
Ms.author: eunicewaweru
Ms.reviewer: stevemutungi
Manager: CelesteDG
Author: msewaweru
External help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
Online version:
Schema: 2.0.0
---

# Remove-EntraScopedRoleMembership

## Synopsis

Removes a scoped role membership.

## Syntax

```powershell
Remove-EntraScopedRoleMembership 
 -ScopedRoleMembershipId <String> 
 -Id <String> [<CommonParameters>]
```

## Description
The Remove-EntraScopedRoleMembership cmdlet removes a scoped role membership from Microsoft Entra ID.

## Examples

### Example 1: Removes a scoped role membership

```powershell
Connect-Entra -Scopes 'RoleManagement.ReadWrite.Directory'
Remove-EntraScopedRoleMembership -Id 'bbbbbbbb-1111-2222-3333-cccccccccccc' -ScopedRoleMembershipId '3d3d3d3d-4444-eeee-5555-6f6f6f6f6f6f'
```

Removes scoped membership.

## Parameters

### -Id

Specifies an object ID.

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

Specifies the ID of the scoped role membership to remove.

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

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related Links

[Add-EntraScopedRoleMembership](Add-EntraScopedRoleMembership.md)

[Get-EntraScopedRoleMembership](Get-EntraScopedRoleMembership.md)

