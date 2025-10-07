---
author: msewaweru
description: This article provides details on the New-EntraBetaPermissionGrantConditionSet command.
external help file: Microsoft.Entra.Beta.SignIns-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.Beta.SignIns
ms.author: eunicewaweru
ms.date: 08/07/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta.SignIns/New-EntraBetaPermissionGrantConditionSet
schema: 2.0.0
title: New-EntraBetaPermissionGrantConditionSet
---

# New-EntraBetaPermissionGrantConditionSet

## SYNOPSIS

Create a new Microsoft Entra ID permission grant condition set in a given policy.

## SYNTAX

```powershell
New-EntraBetaPermissionGrantConditionSet
 -PolicyId <String>
 -ConditionSetType <String>
 [-Permissions <System.Collections.Generic.List`1[System.String]>]
 [-ClientApplicationTenantIds <System.Collections.Generic.List`1[System.String]>]
 [-ClientApplicationsFromVerifiedPublisherOnly <Boolean>]
 [-ClientApplicationIds <System.Collections.Generic.List`1[System.String]>]
 [-ResourceApplication <String>]
 [-ClientApplicationPublisherIds <System.Collections.Generic.List`1[System.String]>]
 [-PermissionClassification <String>]
 [-PermissionType <String>]
 [<CommonParameters>]
```

## DESCRIPTION

Create a new Microsoft Entra ID permission grant condition set object in an existing policy.

## EXAMPLES

### Example 1: Create a basic permission grant condition set in an existing policy with all build in values

```powershell
Connect-Entra -Scopes 'Policy.ReadWrite.PermissionGrant'
$permissionGrantPolicy = Get-EntraBetaPermissionGrantPolicy | Where-Object {$_.Id -eq 'my-custom-consent-policy'}
New-EntraBetaPermissionGrantConditionSet -PolicyId $permissionGrantPolicy.Id -ConditionSetType 'includes' -PermissionType 'delegated'
```

```Output
Id                                   CertifiedClientApplicationsOnly ClientApplicationIds ClientApplicationPublisherIds ClientApplicationTenantIds ClientApplicationsFromVerifiedPublisherOnly PermissionClassification
--                                   ------------------------------- -------------------- ----------------------------- -------------------------- ------------------------------------------- -------------------
aaaa0000-bb11-2222-33cc-444444dddddd False                           {all}                {all}                         {all}                      False                                       all                                  all                      delegated      {all}
```

This command creates a basic permission grant condition set in an existing policy with all build in values.

- `-PolicyId` parameter specifies the unique identifier of a permission grant policy.
- `-ConditionSetType` parameter indicates whether the condition sets are included in the policy or excluded.
- `-PermissionType` parameter specifies the type of permissions (application, delegated) to scope consent operation down to.

### Example 2: Create a permission grant condition set in an existing policy that includes specific permissions for a resource application

```powershell
Connect-Entra -Scopes 'Policy.ReadWrite.PermissionGrant'
$permission = (Get-EntraBetaServicePrincipal -Filter "DisplayName eq 'Box'").AppRoles.Id
$permissionGrantPolicy = Get-EntraBetaPermissionGrantPolicy | Where-Object { $_.Id -eq 'my-custom-consent-policy' }
New-EntraBetaPermissionGrantConditionSet -PolicyId $permissionGrantPolicy.Id -ConditionSetType 'includes' -PermissionType 'delegated' -Permissions @($permission) -ResourceApplication 'resource-application-id'
```

```Output
Id                                   CertifiedClientApplicationsOnly ClientApplicationIds ClientApplicationPublisherIds ClientApplicationTenantIds ClientApplicationsFromVerifiedPublisherOnly PermissionClassification
--                                   ------------------------------- -------------------- ----------------------------- -------------------------- ------------------------------------------- -------------------
bbbb1111-cc22-3333-44dd-555555eeeeee False                           {all}                {all}                         {all}                      False                                       all                                  all                      delegated      {all}
```

This command creates a permission grant condition set in an existing policy that includes specific permissions for a resource application.

- `-PolicyId` parameter specifies the unique identifier of a permission grant policy.
- `-ConditionSetType` parameter indicates whether the condition sets are included in the policy or excluded.
- `-PermissionType` parameter specifies the type of permissions (application, delegated) to scope consent operation down to.
- `-Permissions` parameter specifies the identifier of the resource application to scope consent operation down to. It could be @("All") or a list of permission IDs.
- `-ResourceApplication` parameter specifies identifier of the resource application to scope consent operation down to. It could be "Any" or a specific resource application ID.

### Example 3: Create a permission grant condition set in an existing policy that is excluded

```powershell
Connect-Entra -Scopes 'Policy.ReadWrite.PermissionGrant'
$permissionGrantPolicy = Get-EntraBetaPermissionGrantPolicy | Where-Object { $_.Id -eq 'my-custom-consent-policy' }
$params = @{
    PolicyId                                    = $permissionGrantPolicy.Id
    ConditionSetType                            = 'excludes'
    PermissionType                              = 'delegated'
    Permissions                                 = @('All')
    ResourceApplication                         = 'a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1'
    PermissionClassification                    = 'low'
    ClientApplicationsFromVerifiedPublisherOnly = $true
    ClientApplicationIds                        = @('All')
    ClientApplicationTenantIds                  = @('All')
    ClientApplicationPublisherIds               = @('All')
}
New-EntraBetaPermissionGrantConditionSet @params
```

```Output
Id                                   CertifiedClientApplicationsOnly ClientApplicationIds ClientApplicationPublisherIds ClientApplicationTenantIds ClientApplicationsFromVerifiedPublisherOnly PermissionClassification
--                                   ------------------------------- -------------------- ----------------------------- -------------------------- ------------------------------------------- -------------------
dddd3333-ee44-5555-66ff-777777aaaaaa False                           {all}                {all}                         {all}                      True                                        low
```

This command creates a permission grant condition set in an existing policy that is excluded.

- `-PolicyId` parameter specifies the unique identifier of a permission grant policy.
- `-ConditionSetType` parameter indicates whether the condition sets are included in the policy or excluded.
- `-PermissionType` parameter specifies the type of permissions (application, delegated) to scope consent operation down to.
- `-Permissions` parameter specifies the identifier of the resource application to scope consent operation down to. It could be @("All") or a list of permission IDs.
- `-ResourceApplication` parameter specifies identifier of the resource application to scope consent operation down to. It could be "Any" or a specific resource application ID.
- `-PermissionClassification` parameter specifies the specific classification (all, low, medium, high) to scope consent operation down to.
- `-ClientApplicationsFromVerifiedPublisherOnly` parameter indicates whether to only includes client applications from verified publishers.
- `-ClientApplicationIds` parameter specifies the set of client application IDs to scope consent operation down to. It could be @("All") or a list of client application IDs.
- `-ClientApplicationTenantIds` parameter specifies the set of client applications publisher IDs to scope consent operation down to. It could be @("All") or a list of client application publisher IDs.
- `-ClientApplicationPublisherIds` parameter specifies the set of client applications publisher IDs to scope consent operation down to. It could be @("All") or a list of client application publisher IDs.

### Example 4: Create a permission grant condition set in an existing policy that is excluded

```powershell
Connect-Entra -Scopes 'Policy.ReadWrite.PermissionGrant'
$permissionGrantPolicy = Get-EntraBetaPermissionGrantPolicy | Where-Object { $_.Id -eq 'my-custom-consent-policy' }
$permission = (Get-EntraBetaServicePrincipal -Filter "DisplayName eq '<service-principal-displayname>'").AppRoles.Id
$params = @{
    PolicyId                                    = $permissionGrantPolicy.Id
    ConditionSetType                            = 'excludes'
    PermissionType                              = 'delegated'
    Permissions                                 = @($permission)
    ResourceApplication                         = 'a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1'
    PermissionClassification                    = 'low'
    ClientApplicationsFromVerifiedPublisherOnly = $true
    ClientApplicationIds                        = @('00001111-aaaa-2222-bbbb-3333cccc4444', '11112222-bbbb-3333-cccc-4444dddd5555')
    ClientApplicationTenantIds                  = @('aaaabbbb-0000-cccc-1111-dddd2222eeee', 'bbbbcccc-1111-dddd-2222-eeee3333ffff', 'ccccdddd-2222-eeee-3333-ffff4444aaaa')
    ClientApplicationPublisherIds               = @('33334444-dddd-5555-eeee-6666ffff7777')
}
New-EntraBetaPermissionGrantConditionSet @params
```

```Output
Id                                   CertifiedClientApplicationsOnly ClientApplicationIds                                                         ClientApplicationPublisherIds          ClientApplicationTenantIds
--                                   ------------------------------- --------------------                                                         -----------------------------          --------------------
cccccccc-2222-3333-4444-dddddddddddd False                           {33334444-dddd-5555-eeee-6666ffff7777} {d5aec55f-2d12-4442-8d2f-ccca95d4390e} {aaaabbbb-0000-cccc-1111-dddd2222eeee}
```

This command creates a permission grant condition set in an existing policy that is excluded.

- `-PolicyId` parameter specifies the unique identifier of a permission grant policy.
- `-ConditionSetType` parameter indicates whether the condition sets are included in the policy or excluded.
- `-PermissionType` parameter specifies the type of permissions (application, delegated) to scope consent operation down to.
- `-Permissions` parameter specifies the identifier of the resource application to scope consent operation down to. It could be @("All") or a list of permission IDs.
- `-ResourceApplication` parameter specifies identifier of the resource application to scope consent operation down to. It could be "Any" or a specific resource application ID.
- `-PermissionClassification` parameter specifies the specific classification (all, low, medium, high) to scope consent operation down to.
- `-ClientApplicationsFromVerifiedPublisherOnly` parameter indicates whether to only includes client applications from verified publishers.
- `-ClientApplicationIds` parameter specifies the set of client application IDs to scope consent operation down to. It could be @("All") or a list of client application IDs.
- `-ClientApplicationTenantIds` parameter specifies the set of client applications publisher IDs to scope consent operation down to. It could be @("All") or a list of client application publisher IDs.
- `-ClientApplicationPublisherIds` parameter specifies the set of client applications publisher IDs to scope consent operation down to. It could be @("All") or a list of client application publisher IDs.

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

## INPUTS

### String

## OUTPUTS

### Microsoft.Open.MSGraph.Model.PermissionGrantConditionSet

## NOTES

## RELATED LINKS

[Set-EntraBetaPermissionGrantConditionSet](Set-EntraBetaPermissionGrantConditionSet.md)

[Get-EntraBetaPermissionGrantConditionSet](Get-EntraBetaPermissionGrantConditionSet.md)

[Remove-EntraBetaPermissionGrantConditionSet](Remove-EntraBetaPermissionGrantConditionSet.md)
