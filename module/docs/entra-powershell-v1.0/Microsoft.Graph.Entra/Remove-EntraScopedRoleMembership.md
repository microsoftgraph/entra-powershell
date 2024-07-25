---
title: Remove-EntraScopedRoleMembership.
description: This article provides details on the Remove-EntraScopedRoleMembership command.

ms.topic: reference
ms.date: 07/19/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Remove-EntraScopedRoleMembership

schema: 2.0.0
---

# Remove-EntraScopedRoleMembership

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

The `Remove-EntraScopedRoleMembership` cmdlet removes a scoped role membership from Microsoft Entra ID. Specify `ObjectId` and `ScopedRoleMembershipId` parameter to remove a scoped role membership.

## EXAMPLES

### Example 1: Removes a scoped role membership

```powershell
Connect-Entra -Scopes 'RoleManagement.Read.Directory'
$params = @{
    ObjectId = 'aaaaaaaa-bbbb-aaaa-bbbb-cccccccccccc'
    ScopedRoleMembershipId = 'dddddddddddd-bbbb-aaaa-bbbb-cccccccccccc'
}
Remove-EntraScopedRoleMembership @params
```

This cmdlet removes a specific scoped role membership from Microsoft Entra ID.

- `ObjectId` - specifies the object (ID) which you want to remove. In this example, `aaaaaaaa-2222-bbbb-aaaa-cccccccccccc` represents the ID of the Administrative Unit.

- `-ScopedRoleMembershipId` - specifies the unique identifier (ID) of the scoped role membership, which you want to remove. In this example, `aaaaaaaa-bbbb-1111-aaaa-ddddddddddd` represent the ID of the ScopedRoleMembership.

## PARAMETERS

### -ObjectId

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

[Add-EntraScopedRoleMembership](Add-EntraScopedRoleMembership.md)

[Get-EntraScopedRoleMembership](Get-EntraScopedRoleMembership.md)
