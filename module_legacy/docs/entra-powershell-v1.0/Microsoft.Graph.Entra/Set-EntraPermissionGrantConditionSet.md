---
title: Set-EntraPermissionGrantConditionSet
description: This article provides details on the Set-EntraPermissionGrantConditionSet command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Set-EntraPermissionGrantConditionSet

schema: 2.0.0
---

# Set-EntraPermissionGrantConditionSet

## Synopsis

Update an existing Microsoft Entra ID permission grant condition set.

## Syntax

```powershell
Set-EntraPermissionGrantConditionSet
 -ConditionSetType <String>
 -Id <String>
 -PolicyId <String>
 [-Permissions <System.Collections.Generic.List`1[System.String]>]
 [-ClientApplicationTenantIds <System.Collections.Generic.List`1[System.String]>]
 [-ClientApplicationIds <System.Collections.Generic.List`1[System.String]>]
 [-ResourceApplication <String>]
 [-PermissionType <String>]
 [-PermissionClassification <String>]
 [-ClientApplicationsFromVerifiedPublisherOnly <Boolean>]
 [-ClientApplicationPublisherIds <System.Collections.Generic.List`1[System.String]>]
 [<CommonParameters>]
```

## Description

Updates a Microsoft Entra ID permission grant condition set object identified by Id.

## Examples

### Example 1: Update a permission grant condition set to includes permissions that is classified as low

```powershell
Connect-Entra -Scopes 'Policy.ReadWrite.PermissionGrant'
$permissionGrantPolicy = Get-EntraPermissionGrantPolicy | Where-Object {$_.Id -eq 'my-custom-consent-policy'}
$conditionSet = Get-EntraPermissionGrantConditionSet -PolicyId $permissionGrantPolicy.Id -ConditionSetType 'includes' | Where-Object {$_.PermissionType -eq 'delegated'}
Set-EntraPermissionGrantConditionSet -PolicyId $permissionGrantPolicy -ConditionSetType 'includes' -Id $conditionSet.Id -PermissionClassification 'low' 
```

This command updates sets the specified permission grant set to classify as low.

- `-PolicyId` parameter specifies the unique identifier of a permission grant policy.
- `-ConditionSetType` parameter indicates whether the condition sets are included in the policy or excluded.
- `-Id` parameter specifies the unique identifier of a permission grant condition set object.
- `-PermissionClassification` parameter specifies the specific classification (all, low, medium, high) to scope consent operation down to.

### Example 2: Update a permission grant condition set

```powershell
Connect-Entra -Scopes 'Policy.ReadWrite.PermissionGrant'
$permissionGrantPolicy = Get-EntraPermissionGrantPolicy | Where-Object {$_.Id -eq 'my-custom-consent-policy'}
$conditionSet = Get-EntraPermissionGrantConditionSet -PolicyId $permissionGrantPolicy.Id -ConditionSetType 'includes' | Where-Object {$_.PermissionType -eq 'delegated'}
$params = @{
    PolicyId = $permissionGrantPolicy.Id
    ConditionSetType = 'includes'
    Id = $conditionSet.Id
    PermissionType = 'delegated'
    PermissionClassification = 'low'
    ResourceApplication = 'a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1'
    Permissions = @('All')
    ClientApplicationIds = @('All')
    ClientApplicationTenantIds = @('All')
    ClientApplicationPublisherIds = @('All')
    ClientApplicationsFromVerifiedPublisherOnly = $true
}

Set-EntraPermissionGrantConditionSet @params
```

This command updates sets the specified permission grant set.

- `-PolicyId` parameter specifies the unique identifier of a permission grant policy.
- `-ConditionSetType` parameter indicates whether the condition sets are included in the policy or excluded.
- `-Id` parameter specifies the unique identifier of a permission grant condition set object.
- `-PermissionType` parameter specifies the type of permissions (application, delegated) to scope consent operation down to.
- `-PermissionClassification` parameter specifies the specific classification (all, low, medium, high) to scope consent operation down to.
- `-ResourceApplication` parameter specifies identifier of the resource application to scope consent operation down to. It could be "Any" or a specific resource application ID.
- `-Permissions` parameter specifies the identifier of the resource application to scope consent operation down to. It could be @("All") or a list of permission IDs.
- `-ClientApplicationIds` parameter specifies the set of client application IDs to scope consent operation down to. It could be @("All") or a list of client application IDs.
- `-ClientApplicationTenantIds` parameter specifies the set of client applications publisher IDs to scope consent operation down to. It could be @("All") or a list of client application publisher IDs.
- `-ClientApplicationPublisherIds` parameter specifies the set of client applications publisher IDs to scope consent operation down to. It could be @("All") or a list of client application publisher IDs.
- `-ClientApplicationsFromVerifiedPublisherOnly` parameter indicates whether to only includes client applications from verified publishers.

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

### -PermissionType

Specific type of permissions (application, delegated) to scope consent operation down to.

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

### -PermissionClassification

Specific classification (all, low, medium, high) to scope consent operation down to.

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

### -Permissions

The identifier of the resource application to scope consent operation down to.
It could be @("All") or a list of permission IDs.

```yaml
Type: System.Collections.Generic.List`1[System.String]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ClientApplicationIds

The set of client application IDs to scope consent operation down to.
It could be @("All") or a list of client application IDs.

```yaml
Type: System.Collections.Generic.List`1[System.String]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ClientApplicationTenantIds

The set of client application tenant IDs to scope consent operation down to.
It could be @("All") or a list of client application tenant IDs.

```yaml
Type: System.Collections.Generic.List`1[System.String]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ClientApplicationPublisherIds

The set of client applications publisher IDs to scope consent operation down to.
It could be @("All") or a list of client application publisher IDs.

```yaml
Type: System.Collections.Generic.List`1[System.String]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ClientApplicationsFromVerifiedPublisherOnly

A value indicates whether to only includes client applications from verified publishers.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -ResourceApplication

The identifier of the resource application to scope consent operation down to.
It could be "Any" or a specific resource application ID.

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

### String

## Outputs

## Notes

## Related Links

[New-EntraPermissionGrantConditionSet](New-EntraPermissionGrantConditionSet.md)

[Get-EntraPermissionGrantConditionSet](Get-EntraPermissionGrantConditionSet.md)

[Remove-EntraPermissionGrantConditionSet](Remove-EntraPermissionGrantConditionSet.md)
