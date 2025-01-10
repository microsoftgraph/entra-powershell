---
title: Remove-EntraBetaPermissionGrantConditionSet
description: This article provides details on the Remove-EntraBetaPermissionGrantConditionSet command.


ms.topic: reference
ms.date: 08/08/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Entra.Beta.SignIns-Help.xml
Module Name: Microsoft.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Remove-EntraBetaPermissionGrantConditionSet

schema: 2.0.0
---

# Remove-EntraBetaPermissionGrantConditionSet

## Synopsis

Delete a Microsoft Entra ID permission grant condition set by ID.

## Syntax

```powershell
Remove-EntraBetaPermissionGrantConditionSet
 -Id <String>
 -ConditionSetType <String>
 -PolicyId <String>
 [<CommonParameters>]
```

## Description

Delete a Microsoft Entra ID permission grant condition set object by ID.

## Examples

### Example 1: Delete a permission grant condition set from a policy

```powershell
Connect-Entra -Scopes 'Policy.ReadWrite.PermissionGrant'
$permissionGrantPolicyId = 'policy1'
$PermissionGrantConditionSetId = '2bbbbbb2-3cc3-4dd4-5ee5-6ffffffffff6'
$params = @{
    PolicyId = $permissionGrantPolicyId
    ConditionSetType = 'excludes'
    Id = $PermissionGrantConditionSetId
}
Remove-EntraBetaPermissionGrantConditionSet @params
```

This example demonstrates how to remove the Microsoft Entra ID permission grant condition set by ID.

- `-PolicyId` parameter specifies the unique identifier of a permission grant policy.
- `-ConditionSetType` parameter indicates whether the condition sets are included in the policy or excluded.
- `-Id` parameter specifies the unique identifier of a permission grant condition set object.

## Parameters

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

## Inputs

### String

## Outputs

## Notes

## Related Links

[New-EntraBetaPermissionGrantConditionSet](New-EntraBetaPermissionGrantConditionSet.md)

[Get-EntraBetaPermissionGrantConditionSet](Get-EntraBetaPermissionGrantConditionSet.md)

[Set-EntraBetaPermissionGrantConditionSet](Set-EntraBetaPermissionGrantConditionSet.md)
