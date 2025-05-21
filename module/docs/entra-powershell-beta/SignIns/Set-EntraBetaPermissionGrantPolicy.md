---
title: Set-EntraBetaPermissionGrantPolicy
description: This article provides details on the Set-EntraBetaPermissionGrantPolicy command.

ms.topic: reference
ms.date: 08/01/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Entra.Beta.SignIns-Help.xml
Module Name: Microsoft.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Set-EntraBetaPermissionGrantPolicy

schema: 2.0.0
---

# Set-EntraBetaPermissionGrantPolicy

## Synopsis

Updates a permission grant policy.

## Syntax

```powershell
Set-EntraBetaPermissionGrantPolicy
 -Id <String>
 [-Description <String>]
 [-DisplayName <String>]
 [<CommonParameters>]
```

## Description

The `Set-EntraBetaPermissionGrantPolicy` command updates a Microsoft Entra ID permission grant policy.

## Examples

### Example 1: Update description of permission grant policy

```powershell
Connect-Entra -Scopes 'Policy.ReadWrite.PermissionGrant'
$policy = Get-EntraBetaPermissionGrantPolicy | Where-Object { $_.DisplayName -eq 'Microsoft User Default Recommended Policy' }
Set-EntraBetaPermissionGrantPolicy -Id $policy.Id -Description 'Updated description'
```

This command updates the description of the specified permission grant policy.

- `-Id` parameter specifies the unique identifier of the permission grant policy.
- `-Description` parameter specifies the description for the permission grant policy.

### Example 2: Update display name of permission grant policy

```powershell
Connect-Entra -Scopes 'Policy.ReadWrite.PermissionGrant'
$policy = Get-EntraBetaPermissionGrantPolicy | Where-Object { $_.DisplayName -eq 'Microsoft User Default Recommended Policy' }
Set-EntraBetaPermissionGrantPolicy -Id $policy.Id -DisplayName 'Updated DisplayName'
```

This command updates the display name of the specified permission grant policy.

- `-Id` parameter specifies the unique identifier of the permission grant policy.
- `-DisplayName` parameter specifies the display name for the permission grant policy.

## Parameters

### -Description

Specifies the description of the permission grant policy.

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

Specifies the display name of the permission grant policy.

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

[New-EntraBetaPermissionGrantPolicy](New-EntraBetaPermissionGrantPolicy.md)

[Get-EntraBetaPermissionGrantPolicy](Get-EntraBetaPermissionGrantPolicy.md)

[Remove-EntraBetaPermissionGrantPolicy](Remove-EntraBetaPermissionGrantPolicy.md)
