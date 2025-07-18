---
title: Remove-EntraBetaPermissionGrantPolicy
description: This article provides details on the Remove-EntraBetaPermissionGrantPolicy command.


ms.topic: reference
ms.date: 08/01/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: mwongerapk
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Remove-EntraBetaPermissionGrantPolicy

schema: 2.0.0
---

# Remove-EntraBetaPermissionGrantPolicy

## Synopsis

Removes a permission grant policy.

## Syntax

```powershell
Remove-EntraBetaPermissionGrantPolicy
 -Id <String>
 [<CommonParameters>]
```

## Description

The `Remove-EntraBetaPermissionGrantPolicy` cmdlet removes a Microsoft Entra ID permission grant policy.

## Examples

### Example 1: Remove a permission grant policy

```powershell
Connect-Entra -Scopes 'Policy.ReadWrite.PermissionGrant'
Remove-EntraBetaPermissionGrantPolicy -Id 'my_permission_grant_policy_id'
```

This command removes the specified permission grant policy in Microsoft Entra ID.

- `-Id` parameter specifies the unique identifier of the permission grant policy.

## Parameters

### -Id

The unique identifier of the permission grant policy.

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

[New-EntraBetaPermissionGrantPolicy](New-EntraBetaPermissionGrantPolicy.md)

[Set-EntraBetaPermissionGrantPolicy](Set-EntraBetaPermissionGrantPolicy.md)

[Get-EntraBetaPermissionGrantPolicy](Get-EntraBetaPermissionGrantPolicy.md)
