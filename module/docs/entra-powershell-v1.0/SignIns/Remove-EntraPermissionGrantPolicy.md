---
title: Remove-EntraPermissionGrantPolicy
description: This article provides details on the Remove-EntraPermissionGrantPolicy command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Remove-EntraPermissionGrantPolicy

schema: 2.0.0
---

# Remove-EntraPermissionGrantPolicy

## Synopsis

Removes a permission grant policy.

## Syntax

```powershell
Remove-EntraPermissionGrantPolicy
 -Id <String>
 [<CommonParameters>]
```

## Description

The `Remove-EntraPermissionGrantPolicy` cmdlet removes a Microsoft Entra ID permission grant policy.

## Examples

### Example 1: Remove a permission grant policy

```powershell
Connect-Entra -Scopes 'Policy.ReadWrite.PermissionGrant'
Remove-EntraPermissionGrantPolicy -Id 'my_permission_grant_policy_id'
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

[New-EntraPermissionGrantPolicy](New-EntraPermissionGrantPolicy.md)

[Get-EntraPermissionGrantPolicy](Get-EntraPermissionGrantPolicy.md)

[Set-EntraPermissionGrantPolicy](Set-EntraPermissionGrantPolicy.md)
