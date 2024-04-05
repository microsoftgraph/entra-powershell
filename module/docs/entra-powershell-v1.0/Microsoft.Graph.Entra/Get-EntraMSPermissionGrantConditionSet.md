---
title: Get-EntraMSPermissionGrantConditionSet
description: This article provides details on the Get-EntraMSPermissionGrantConditionSet command.

ms.service: active-directory
ms.topic: reference
ms.date: 03/21/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraMSPermissionGrantConditionSet

## SYNOPSIS
Get a Microsoft Entra ID permission grant condition set by id.

## SYNTAX

### GetQuery (Default)
```powershell
Get-EntraMSPermissionGrantConditionSet 
    -ConditionSetType <String> 
    -PolicyId <String> 
    [<CommonParameters>]
```

### GetById
```powershell
Get-EntraMSPermissionGrantConditionSet 
    -ConditionSetType <String> 
    -Id <String> 
    -PolicyId <String>
    [<CommonParameters>]
```

## DESCRIPTION
Get a Microsoft Entra ID permission grant condition set object by id.

## EXAMPLES

### Example 1: Get all permission grant condition sets that are included in the permission grant policy
```powershell
PS C:\>Get-EntraMSPermissionGrantConditionSet -PolicyId "policy1" -ConditionSetType "includes"
```

```output
Id                                   ClientApplicationIds                   ClientApplicationPublisherIds          ClientApplicationTenantIds             ClientApplicationsFromVerifiedPublisherOnly
--                                   --------------------                   -----------------------------          --------------------------             -------------------------------------------
4ccf1a57-4c5e-4ba6-9175-00407743b0e2 {b548ef2c-0bf0-4164-b7f9-99413111826d} {all}                                  {d5aec55f-2d12-4442-8d2f-ccca95d4390e} True
```

This command gets all permission grant condition sets that are included in the policy.

### Example 2: Get all permission grant condition sets that are excluded in the permission grant policy
```powershell
PS C:\>Get-EntraMSPermissionGrantConditionSet -PolicyId "policy1" -ConditionSetType "excludes"
```

```output
Id                                   ClientApplicationIds                   ClientApplicationPublisherIds          ClientApplicationTenantIds             ClientApplicationsFromVerifiedPublisherOnly
--                                   --------------------                   -----------------------------          --------------------------             -------------------------------------------
167e834e-eb78-4773-9994-9ee3a5f37304 {b548ef2c-0bf0-4164-b7f9-99413111826d} {all}                                  {d5aec55f-2d12-4442-8d2f-ccca95d4390e} True
97120a4b-bfe7-4470-8d0b-67bde0127535 {31655662-0682-4a95-9010-f0ffb9b4cbd3} {d5aec55f-2d12-4442-8d2f-ccca95d4390e} {d5aec55f-2d12-4442-8d2f-ccca95d4390e} True
```

This command gets all permission grant condition sets that are excluded in the policy.

### Example 3: Get a permission grant condition set
```powershell
PS C:\>Get-EntraMSPermissionGrantConditionSet -PolicyId "policy1" -ConditionSetType "includes" -Id "4ccf1a57-4c5e-4ba6-9175-00407743b0e2"
```

```output
Id                                   ClientApplicationIds                   ClientApplicationPublisherIds          ClientApplicationTenantIds             ClientApplicationsFromVerifiedPublisherOnly
--                                   --------------------                   -----------------------------          --------------------------             -------------------------------------------
4ccf1a57-4c5e-4ba6-9175-00407743b0e2 {b548ef2c-0bf0-4164-b7f9-99413111826d} {all}                                  {d5aec55f-2d12-4442-8d2f-ccca95d4390e} True
```

This command gets a permission grant condition set specified by Id.

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

### -Id
The unique identifier of a Microsoft Entra ID permission grant condition set object.

```yaml
Type: String
Parameter Sets: GetById
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### String
### String
### String
## OUTPUTS

### Microsoft.Open.MSGraph.Model.PermissionGrantConditionSet
## NOTES

## RELATED LINKS

[New-EntraMSPermissionGrantConditionSet](New-EntraMSPermissionGrantConditionSet.md)

[Set-EntraMSPermissionGrantConditionSet](Set-EntraMSPermissionGrantConditionSet.md)

[Remove-EntraMSPermissionGrantConditionSet](Remove-EntraMSPermissionGrantConditionSet.md)

