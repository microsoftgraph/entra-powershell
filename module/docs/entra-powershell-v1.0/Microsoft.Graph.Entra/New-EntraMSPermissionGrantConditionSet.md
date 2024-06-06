---
title: New-EntraMSPermissionGrantConditionSet
description: This article provides details on the New-EntraMSPermissionGrantConditionSet command.

ms.service: entra
ms.topic: reference
ms.date: 03/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# New-EntraMSPermissionGrantConditionSet

## SYNOPSIS
Create a new Microsoft Entra ID permission grant condition set in a given policy.

## SYNTAX

```powershell
New-EntraMSPermissionGrantConditionSet 
 -PolicyId <String> 
 -ConditionSetType <String>
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

## DESCRIPTION
Create a new Microsoft Entra ID permission grant condition set object in an existing policy.

## EXAMPLES

### Example 1: Create a basic permission grant condition set in an existing policy with all build in values
```powershell
PS C:\> New-EntraMSPermissionGrantConditionSet -PolicyId "test1" -ConditionSetType "includes" -PermissionType "delegated"
```

```output
Id                                   ClientApplicationIds ClientApplicationPublisherIds ClientApplicationTenantIds ClientApplicationsFromVerifiedPublisherOnly PermissionClassification PermissionType Permissio
                                                                                                                                                                                                       ns
--                                   -------------------- ----------------------------- -------------------------- ------------------------------------------- ------------------------ -------------- ---------
cab65448-9ec4-43a5-b575-d1f4d32fefa5 {all}                {all}                         {all}                      False                                       all                      delegated      {all}
```

 This command creates a basic permission grant condition set in an existing policy with all build in values.

### Example 2: Create a permission grant condition set in an existing policy that includes specific permissions for a resource application
```powershell
PS C:\> New-EntraMSPermissionGrantConditionSet -PolicyId "test1" -ConditionSetType "includes" -PermissionType "delegated" -Permissions @("8b590330-0eb2-45d0-baca-a00ecf7e7b87", "dac1c8fa-e6e4-47b8-a128-599660b8cd5c", "f6db0cc3-88cd-4c74-a374-3d8c7cc4c50b") -ResourceApplication "ec8d61c9-1cb2-4edb-afb0-bcda85645555"
```

```output
Id                                   ClientApplicationIds ClientApplicationPublisherIds ClientApplicationTenantIds ClientApplicationsFromVerifiedPublisherOnly PermissionClassification PermissionType Permissio
                                                                                                                                                                                                       ns
--                                   -------------------- ----------------------------- -------------------------- ------------------------------------------- ------------------------ -------------- ---------
64032dc4-8423-4fd7-930c-a9ed3bb1dbb4 {all}                {all}                         {all}                      False                                       all                      delegated      {8b590...
```

This command creates a permission grant condition set in an existing policy that includes specific permissions for a resource application.

### Example 3: Create a permission grant condition set in an existing policy that is excluded
```powershell
PS C:\> New-EntraMSPermissionGrantConditionSet -PolicyId "test1" -ConditionSetType "excludes" -PermissionType "delegated" -Permissions @("8b590330-0eb2-45d0-baca-a00ecf7e7b87", "dac1c8fa-e6e4-47b8-a128-599660b8cd5c", "f6db0cc3-88cd-4c74-a374-3d8c7cc4c50b") -ResourceApplication "ec8d61c9-1cb2-4edb-afb0-bcda85645555" -PermissionClassification "low" -ClientApplicationsFromVerifiedPublisherOnly $true -ClientApplicationIds @("4a6c40ea-edc1-4202-8620-dd4060ee6583", "17a961bd-e743-4e6f-8097-d7e6612999a7") -ClientApplicationTenantIds @("17a961bd-e743-4e6f-8097-d7e6612999a8", "17a961bd-e743-4e6f-8097-d7e6612999a9", "17a961bd-e743-4e6f-8097-d7e6612999a0") -ClientApplicationPublisherIds @("verifiedpublishermpnid")
```

```output
Id                                   ClientApplicationIds                                                         ClientApplicationPublisherIds ClientApplicationTenantIds
--                                   --------------------                                                         ----------------------------- --------------------------
0f81cce0-a766-4db6-a7e2-4e5f10f6abf8 {4a6c40ea-edc1-4202-8620-dd4060ee6583, 17a961bd-e743-4e6f-8097-d7e6612999a7} {verifiedpublishermpnid}      {17a961bd-e743-4e6f-8097-d7e6612999a8, 17a961bd-e743-4e6f-809...
```

This command creates a permission grant condition set in an existing policy that is excluded.

## PARAMETERS

### -PolicyId
The unique identifier of a Microsoft Entra ID permission grant policy object.

```yaml
Type: String
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
Type: String
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
Type: String
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
Type: String
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
It could be @("All") or a list of client application Ids.

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
Type: Boolean
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
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### String
### String
## OUTPUTS

### Microsoft.Open.MSGraph.Model.PermissionGrantConditionSet
## NOTES

## RELATED LINKS

[Set-EntraMSPermissionGrantConditionSet](Set-EntraMSPermissionGrantConditionSet.md)

[Get-EntraMSPermissionGrantConditionSet](Get-EntraMSPermissionGrantConditionSet.md)

[Remove-EntraMSPermissionGrantConditionSet](Remove-EntraMSPermissionGrantConditionSet.md)

