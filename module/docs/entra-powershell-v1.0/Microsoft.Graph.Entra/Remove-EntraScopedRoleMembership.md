---
<<<<<<< HEAD
title: Remove-EntraScopedRoleMembership 
description: This article provides details on the Remove-EntraScopedRoleMembership command.
ms.service: entra
ms.topic: reference
ms.date: 06/11/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
=======
title: Remove-EntraScopedRoleMembership.
description: This article provides details on the Remove-EntraScopedRoleMembership command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
>>>>>>> c0ab64e29dd87ffc3f0e378434425e5b4a399eaa
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Remove-EntraScopedRoleMembership

<<<<<<< HEAD
## SYNOPSIS

Removes a scoped role membership.

## SYNTAX

```powershell
Remove-EntraScopedRoleMembership 
 -ObjectId <String> 
 -ScopedRoleMembershipId <String>
 [<CommonParameters>]
```

## DESCRIPTION

The Remove-EntraScopedRoleMembership cmdlet removes a scoped role membership from Microsoft Entra ID.

## EXAMPLES
=======
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
>>>>>>> c0ab64e29dd87ffc3f0e378434425e5b4a399eaa

### Example 1: Removes a scoped role membership

```powershell
<<<<<<< HEAD
Remove-EntraScopedRoleMembership -ObjectId 'aaaaaaaa-2222-bbbb-aaaa-cccccccccccc' -ScopedRoleMembershipId 'aaaaaaaa-bbbb-1111-aaaa-ddddddddddd'
```

This example removes scoped membership.

## PARAMETERS

### -ObjectId
=======
Connect-Entra -Scopes 'RoleManagement.ReadWrite.Directory'
Remove-EntraScopedRoleMembership -Id 'bbbbbbbb-1111-2222-3333-cccccccccccc' -ScopedRoleMembershipId '3d3d3d3d-4444-eeee-5555-6f6f6f6f6f6f'
```

Removes scoped membership.

## Parameters

### -Id
>>>>>>> c0ab64e29dd87ffc3f0e378434425e5b4a399eaa

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

<<<<<<< HEAD
## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
=======
## Inputs

## Outputs

## Notes

## Related Links
>>>>>>> c0ab64e29dd87ffc3f0e378434425e5b4a399eaa

[Add-EntraScopedRoleMembership](Add-EntraScopedRoleMembership.md)

[Get-EntraScopedRoleMembership](Get-EntraScopedRoleMembership.md)
<<<<<<< HEAD
=======

>>>>>>> c0ab64e29dd87ffc3f0e378434425e5b4a399eaa
