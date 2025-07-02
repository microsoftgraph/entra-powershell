---
author: msewaweru
description: This article provides details on the Remove-EntraPermissionGrantPolicy command.
external help file: Microsoft.Entra.SignIns-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra
ms.author: eunicewaweru
ms.date: 06/26/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Remove-EntraPermissionGrantPolicy
schema: 2.0.0
title: Remove-EntraPermissionGrantPolicy
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

## Related links

[New-EntraPermissionGrantPolicy](New-EntraPermissionGrantPolicy.md)

[Get-EntraPermissionGrantPolicy](Get-EntraPermissionGrantPolicy.md)

[Set-EntraPermissionGrantPolicy](Set-EntraPermissionGrantPolicy.md)
