---
title: Remove-EntraScopedRoleMembership.
description: This article provides details on the Remove-EntraScopedRoleMembership command.

ms.service: active-directory
ms.topic: reference
ms.date: 06/006/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
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

The Remove-EntraScopedRoleMembership cmdlet removes a scoped role membership from Microsoft Entra ID.

## EXAMPLES

### Example 1: Removes a scoped role membership

```powershell
Remove-EntraScopedRoleMembership -ObjectId '00000000-1111-1111-1111-000000000000' -ScopedRoleMembershipId '44444444-1111-1111-1111-000000000000'
```

This example demonstrates how to Removes a scoped role membership.

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
