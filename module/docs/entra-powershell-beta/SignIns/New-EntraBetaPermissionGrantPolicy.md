---
title: New-EntraBetaPermissionGrantPolicy
description: This article provides details on the New-EntraBetaPermissionGrantPolicy command.


ms.topic: reference
ms.date: 08/01/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Entra.Beta.SignIns-Help.xml
Module Name: Microsoft.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/New-EntraBetaPermissionGrantPolicy

schema: 2.0.0
---

# New-EntraBetaPermissionGrantPolicy

## Synopsis

Creates a permission grant policy.

## Syntax

```powershell
New-EntraBetaPermissionGrantPolicy
 [-Description <String>]
 [-DisplayName <String>]
 [-Id <String>]
 [<CommonParameters>]
```

## Description

The `New-EntraBetaPermissionGrantPolicy` cmdlet creates a Microsoft Entra ID permission grant policy.

## Examples

### Example 1: Create a permission grant policy

```powershell
Connect-Entra -Scopes 'Policy.ReadWrite.PermissionGrant'
$params = @{
    Id = 'my_new_permission_grant_policy_id'
    DisplayName = 'MyNewPermissionGrantPolicy'
    Description = 'My new permission grant policy'
}

New-EntraBetaPermissionGrantPolicy @params
```

```Output
DeletedDateTime Description                    DisplayName                Id
--------------- -----------                    -----------                --
                My new permission grant policy MyNewPermissionGrantPolicy my_new_permission_grant_policy_id
```

This example creates new permission grant policy in Microsoft Entra ID.

- `-Id` parameter specifies the unique identifier of the permission grant policy.
- `-DisplayName` parameter specifies the display name for the permission grant policy.
- `-Description` parameter specifies the description for the permission grant policy.

## Parameters

### -Description

Specifies the description for the permission grant policy.

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

### -DisplayName

Specifies the display name for the permission grant policy.

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

Specifies the unique identifier of the permission grant policy.

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

[Get-EntraBetaPermissionGrantPolicy](Get-EntraBetaPermissionGrantPolicy.md)

[Set-EntraBetaPermissionGrantPolicy](Set-EntraBetaPermissionGrantPolicy.md)

[Remove-EntraBetaPermissionGrantPolicy](Remove-EntraBetaPermissionGrantPolicy.md)
