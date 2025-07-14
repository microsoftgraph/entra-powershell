---
author: msewaweru
description: This article provides details on the Remove-EntraPermissionGrantConditionSet command.
external help file: Microsoft.Entra.SignIns-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra
ms.author: eunicewaweru
ms.date: 06/26/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Remove-EntraPermissionGrantConditionSet
schema: 2.0.0
title: Remove-EntraPermissionGrantConditionSet
---

# Remove-EntraPermissionGrantConditionSet

## SYNOPSIS

Delete a Microsoft Entra ID permission grant condition set by ID.

## SYNTAX

```powershell
Remove-EntraPermissionGrantConditionSet
 -ConditionSetType <String>
 -Id <String>
 -PolicyId <String>
 [<CommonParameters>]
```

## DESCRIPTION

Delete a Microsoft Entra ID permission grant condition set object by ID.

## EXAMPLES

### Example 1: Delete a permission grant condition set from a policy

```powershell
Connect-Entra -Scopes 'Policy.ReadWrite.PermissionGrant'
$permissionGrantPolicy = Get-EntraPermissionGrantPolicy | Where-Object { $_.Id -eq 'my-custom-consent-policy' }
$conditionSet = Get-EntraPermissionGrantConditionSet -PolicyId $permissionGrantPolicy.Id -ConditionSetType 'includes' | Where-Object { $_.PermissionType -eq 'delegated' }
Remove-EntraPermissionGrantConditionSet -PolicyId $permissionGrantPolicy.Id -ConditionSetType 'includes' -Id $conditionSet.Id
```

This example demonstrates how to remove the Microsoft Entra ID permission grant condition set by ID.

- `-PolicyId` parameter specifies the unique identifier of a permission grant policy.
- `-ConditionSetType` parameter indicates whether the condition sets are included in the policy or excluded.
- `-Id` parameter specifies the unique identifier of a permission grant condition set object.

## PARAMETERS

### -PolicyId

The unique identifier of a Microsoft Entra ID permission grant policy object.

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

### -ConditionSetType

The value indicates whether the condition sets are included in the policy or excluded.

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

### -Id

The unique identifier of a Microsoft Entra ID permission grant condition set object.

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

### String

## OUTPUTS

## NOTES

## RELATED LINKS

[New-EntraPermissionGrantConditionSet](New-EntraPermissionGrantConditionSet.md)

[Get-EntraPermissionGrantConditionSet](Get-EntraPermissionGrantConditionSet.md)

[Set-EntraPermissionGrantConditionSet](Set-EntraPermissionGrantConditionSet.md)
