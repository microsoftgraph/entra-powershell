---
title: Remove-EntraBetaMSPermissionGrantConditionSet
description: This article provides details on the Remove-EntraBetaMSPermissionGrantConditionSet command.
ms.service: active-directory
ms.topic: reference
ms.date: 04/17/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Remove-EntraBetaMSPermissionGrantConditionSet

## Synopsis
Delete a Microsoft Entra ID permission grant condition set by ID.

## Syntax

```powershell
Remove-EntraBetaMSPermissionGrantConditionSet 
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
PS C:\>Remove-EntraBetaMSPermissionGrantConditionSet -PolicyId "policy1" -ConditionSetType "excludes" -Id "665a9903-0398-48ab-b4e9-7a570d468b66"
```
This command  Delete a permission grant condition set from a policy.

## Parameters

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
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

### String
### String
### String
## Outputs

## Notes

## Related LINKS

[New-EntraBetaMSPermissionGrantConditionSet](New-EntraBetaMSPermissionGrantConditionSet.md)

[Get-EntraBetaMSPermissionGrantConditionSet](Get-EntraBetaMSPermissionGrantConditionSet.md)

[Set-EntraBetaMSPermissionGrantConditionSet](Set-EntraBetaMSPermissionGrantConditionSet.md)

