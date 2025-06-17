---
title: Get-EntraBetaPermissionGrantConditionSet
description: This article provides details on the Get-EntraBetaPermissionGrantConditionSet command.


ms.topic: reference
ms.date: 08/07/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Entra.Beta.SignIns-Help.xml
Module Name: Microsoft.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Get-EntraBetaPermissionGrantConditionSet

schema: 2.0.0
---

# Get-EntraBetaPermissionGrantConditionSet

## Synopsis

Get a Microsoft Entra ID permission grant condition set by ID.

## Syntax

### GetQuery (Default)

```powershell
Get-EntraBetaPermissionGrantConditionSet
 -ConditionSetType <String>
 -PolicyId <String>
 [-Property <String[]>]
 [<CommonParameters>]
```

### GetById

```powershell
Get-EntraBetaPermissionGrantConditionSet
 -Id <String>
 -ConditionSetType <String>
 -PolicyId <String>
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

Get a Microsoft Entra ID permission grant condition set object by ID.

## Examples

### Example 1: Get all permission grant condition sets that are included in the permission grant policy

```powershell
Connect-Entra -Scopes 'Policy.Read.PermissionGrant'
$permissionGrantPolicy = Get-EntraBetaPermissionGrantPolicy | Where-Object {$_.Id -eq 'my-custom-consent-policy'}
Get-EntraBetaPermissionGrantConditionSet -PolicyId $permissionGrantPolicy.Id -ConditionSetType 'includes'
```

```Output
Id                                   CertifiedClientApplicationsOnly ClientApplicationIds                                                         ClientApplicationPublisherIds          ClientApplicationTenantIds
--                                   ------------------------------- --------------------                                                         -----------------------------          --------------------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb False                           {33334444-dddd-5555-eeee-6666ffff7777} {d5aec55f-2d12-4442-8d2f-ccca95d4390e} {aaaabbbb-0000-cccc-1111-dddd2222eeee}
```

This command gets all permission grant condition sets that are included in the policy.

- `-PolicyId` parameter specifies the unique identifier of a permission grant policy.
- `-ConditionSetType` parameter indicates whether the condition sets are included in the policy or excluded.

### Example 2: Get all permission grant condition sets that are excluded in the permission grant policy

```powershell
Connect-Entra -Scopes 'Policy.Read.PermissionGrant'
$permissionGrantPolicy = Get-EntraBetaPermissionGrantPolicy | Where-Object {$_.Id -eq 'my-custom-consent-policy'}
Get-EntraBetaPermissionGrantConditionSet -PolicyId $permissionGrantPolicy.Id -ConditionSetType 'excludes'
```

```Output
Id                                   CertifiedClientApplicationsOnly ClientApplicationIds                                                         ClientApplicationPublisherIds          ClientApplicationTenantIds
--                                   ------------------------------- --------------------                                                         -----------------------------          --------------------
bbbbbbbb-1111-2222-3333-cccccccccccc False                           {33334444-dddd-5555-eeee-6666ffff7777} {d5aec55f-2d12-4442-8d2f-ccca95d4390e} {aaaabbbb-0000-cccc-1111-dddd2222eeee}
cccccccc-2222-3333-4444-dddddddddddd False                           {44445555-eeee-6666-ffff-7777gggg8888} {d5aec55f-2d12-4442-8d2f-ccca95d4390e} {aaaabbbb-0000-cccc-1111-dddd2222eeee}
```

This command gets all permission grant condition sets that are excluded in the policy.

- `-PolicyId` parameter specifies the unique identifier of a permission grant policy.
- `-ConditionSetType` parameter indicates whether the condition sets are included in the policy or excluded.

### Example 3: Get a permission grant condition set

```powershell
Connect-Entra -Scopes 'Policy.Read.PermissionGrant'
$permissionGrantPolicy = Get-EntraBetaPermissionGrantPolicy | Where-Object {$_.Id -eq 'my-custom-consent-policy'}
$conditionSet = Get-EntraBetaPermissionGrantConditionSet -PolicyId $permissionGrantPolicy.Id -ConditionSetType 'includes' | Where-Object {$_.PermissionType -eq 'delegated'}
Get-EntraBetaPermissionGrantConditionSet -PolicyId $permissionGrantPolicy.Id -ConditionSetType 'includes' -Id $conditionSet.Id
```

```Output
Id                                   CertifiedClientApplicationsOnly ClientApplicationIds                                                         ClientApplicationPublisherIds          ClientApplicationTenantIds
--                                   ------------------------------- --------------------                                                         -----------------------------          --------------------
dddddddd-3333-4444-5555-eeeeeeeeeeee False                           {33334444-dddd-5555-eeee-6666ffff7777} {d5aec55f-2d12-4442-8d2f-ccca95d4390e} {aaaabbbb-0000-cccc-1111-dddd2222eeee}
```

This command gets a permission grant condition set specified by Id.

- `-PolicyId` parameter specifies the unique identifier of a permission grant policy.
- `-ConditionSetType` parameter indicates whether the condition sets are included in the policy or excluded.
- `-Id` parameter specifies the unique identifier of the permission grant condition set object.

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
Parameter Sets: GetById
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Property

Specifies properties to be returned.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases: Select

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

### String

## Outputs

### Microsoft.Open.MSGraph.Model.PermissionGrantConditionSet

## Notes

## Related links

[New-EntraBetaPermissionGrantConditionSet](New-EntraBetaPermissionGrantConditionSet.md)

[Set-EntraBetaPermissionGrantConditionSet](Set-EntraBetaPermissionGrantConditionSet.md)

[Remove-EntraBetaPermissionGrantConditionSet](Remove-EntraBetaPermissionGrantConditionSet.md)
