---
title: Remove-EntraMSScopedRoleMembership.
description: This article provides details on the Remove-EntraMSScopedRoleMembership command.

ms.service: entra
ms.topic: reference
ms.date: 03/15/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Remove-EntraMSScopedRoleMembership

## SYNOPSIS

Removes a scoped role membership.

## SYNTAX

```powershell
Remove-EntraMSScopedRoleMembership 
 -ScopedRoleMembershipId <String> 
 -Id <String> [<CommonParameters>]
```

## DESCRIPTION

The `Remove-EntraMSScopedRoleMembership` cmdlet removes a scoped role membership from Microsoft Entra ID.

## EXAMPLES

### Example 1: Removes a scoped role membership

```powershell
Connect-Entra -Scopes 'RoleManagement.ReadWrite.Directory'
Remove-EntraMSScopedRoleMembership -Id 'bbbbbbbb-1111-2222-3333-cccccccccccc' -ScopedRoleMembershipId '3d3d3d3d-4444-eeee-5555-6f6f6f6f6f6f'
```

Removes scoped membership.

## PARAMETERS

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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Add-EntraMSScopedRoleMembership](Add-EntraMSScopedRoleMembership.md)

[Get-EntraMSScopedRoleMembership](Get-EntraMSScopedRoleMembership.md)
