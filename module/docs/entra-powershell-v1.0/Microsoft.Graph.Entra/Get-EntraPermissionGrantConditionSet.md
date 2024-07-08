---
title: Get-EntraPermissionGrantConditionSet
description: This article provides details on the Get-EntraPermissionGrantConditionSet command.

ms.service: entra
ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraPermissionGrantConditionSet

## Synopsis

Get a Microsoft Entra ID permission grant condition set by id.

## Syntax

### GetQuery (Default)

```powershell
Get-EntraPermissionGrantConditionSet 
 -ConditionSetType <String> 
 -PolicyId <String> 
 [<CommonParameters>]
```

### GetById

```powershell
Get-EntraPermissionGrantConditionSet 
 -ConditionSetType <String> 
 -Id <String> 
 -PolicyId <String>
 [<CommonParameters>]
```

## Description

Get a Microsoft Entra ID permission grant condition set object by id.

## Examples

### Example 1: Get all permission grant condition sets that are included in the permission grant policy

```powershell
Connect-Entra -Scopes 'Policy.Read.PermissionGrant'
$params = @{
    PolicyId = 'policy1'
    ConditionSetType = 'includes'
}

Get-EntraPermissionGrantConditionSet @params
```

```output
Id                                   ClientApplicationIds                   ClientApplicationPublisherIds          ClientApplicationTenantIds             ClientApplicationsFromVerifiedPublisherOnly
--                                   --------------------                   -----------------------------          --------------------------             -------------------------------------------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb {00001111-aaaa-2222-bbbb-3333cccc4444} {all}                                  {aaaabbbb-0000-cccc-1111-dddd2222eeee} True
```

This command gets all permission grant condition sets that are included in the policy.

### Example 2: Get all permission grant condition sets that are excluded in the permission grant policy

```powershell
Connect-Entra -Scopes 'Policy.Read.PermissionGrant'
$params = @{
    PolicyId = 'policy1'
    ConditionSetType = 'excludes'
}

Get-EntraPermissionGrantConditionSet @params
```

```output
Id                                   ClientApplicationIds                   ClientApplicationPublisherIds          ClientApplicationTenantIds             ClientApplicationsFromVerifiedPublisherOnly
--                                   --------------------                   -----------------------------          --------------------------             -------------------------------------------
cccccccc-2222-3333-4444-dddddddddddd {33334444-dddd-5555-eeee-6666ffff7777} {all}                                  {aaaabbbb-0000-cccc-1111-dddd2222eeee} True
bbbbbbbb-1111-2222-3333-cccccccccccc {11112222-bbbb-3333-cccc-4444dddd5555} {all}                                  {aaaabbbb-0000-cccc-1111-dddd2222eeee} True
```

This command gets all permission grant condition sets that are excluded in the policy.

### Example 3: Get a permission grant condition set

```powershell
Connect-Entra -Scopes 'Policy.Read.PermissionGrant'
$params = @{
    PolicyId = 'policy1'
    ConditionSetType = 'includes'
    Id = 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'
}

Get-EntraPermissionGrantConditionSet @params
```

```output
Id                                   ClientApplicationIds                   ClientApplicationPublisherIds          ClientApplicationTenantIds             ClientApplicationsFromVerifiedPublisherOnly
--                                   --------------------                   -----------------------------          --------------------------             -------------------------------------------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb {00001111-aaaa-2222-bbbb-3333cccc4444} {all}                                  {aaaabbbb-0000-cccc-1111-dddd2222eeee} True
```

This command gets a permission grant condition set specified by `Id`.

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

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

### Microsoft.Open.MSGraph.Model.PermissionGrantConditionSet

## Notes

## Related Links

[New-EntraPermissionGrantConditionSet](New-EntraPermissionGrantConditionSet.md)

[Set-EntraPermissionGrantConditionSet](Set-EntraPermissionGrantConditionSet.md)

[Remove-EntraPermissionGrantConditionSet](Remove-EntraPermissionGrantConditionSet.md)
