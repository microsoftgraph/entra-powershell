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

## Synopsis
Removes a scoped role membership.

## Syntax

```powershell
Remove-EntraMSScopedRoleMembership 
 -ScopedRoleMembershipId <String> 
 -Id <String> [<CommonParameters>]
```

## Description
The Remove-EntraMSScopedRoleMembership cmdlet removes a scoped role membership from Microsoft Entra ID.

## Examples

### Example 1: Removes a scoped role membership
```powershell
PS C:\> Remove-EntraMSScopedRoleMembership -Id "1026185e-25df-4522-a380-7ab697a7241c" -ScopedRoleMembershipId "3028185e-25df-4522-a380-7ab697a7241c"
```

Removes scoped membership.

## Parameters

### -Id
Specifies an object ID.

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

### -ScopedRoleMembershipId
Specifies the ID of the scoped role membership to remove.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related LINKS

[Add-EntraMSScopedRoleMembership](Add-EntraMSScopedRoleMembership.md)

[Get-EntraMSScopedRoleMembership](Get-EntraMSScopedRoleMembership.md)

