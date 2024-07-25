---
title: Set-EntraBetaAttributeSet.
description: This article provides details on the Set-EntraBetaAttributeSet command.

ms.topic: reference
ms.date: 07/10/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Set-EntraBetaAttributeSet

schema: 2.0.0
---

# Set-EntraBetaAttributeSet

## Synopsis

Updates an existing attribute set.

## Syntax

```powershell
Set-EntraBetaAttributeSet 
 -Id <String>
 [-Description <String>] 
 [-MaxAttributesPerSet <Int32>]
 [<CommonParameters>]
```

## Description

Updates a Microsoft Entra ID attribute set object identified by ID. Specify `Id` parameter to update an attribute set.

## Examples

### Example 1: Update an attribute set

```powershell
Connect-Entra -Scopes 'CustomSecAttributeDefinition.ReadWrite.All'
$params = @{
    Id = 'Testing' 
    Description = 'Attributes for engineering team'
}
Set-EntraBetaAttributeSet @params
```

This example update an attribute set.

- `Id` parameter specifies the name of the attribute set.
- `Description` parameter specifies the description for the attribute set.

### Example 2: Update an attribute set using MaxAttributesPerSet

```powershell
Connect-Entra -Scopes 'CustomSecAttributeDefinition.ReadWrite.All'
$params = @{
    Id = 'Testing' 
    MaxAttributesPerSet = 10
}
Set-EntraBetaAttributeSet @params
```

This example update an attribute set using MaxAttributesPerSet.

- `Id` parameter specifies the name of the attribute set.
- `MaxAttributesPerSet` parameter specifies the maximum number of custom security attributes.

## Parameters

### -Description

Description for the attribute set.

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

Name of the attribute set. Must be unique within a tenant.

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

### -MaxAttributesPerSet

Maximum number of custom security attributes that can be defined in the attribute set.

```yaml
Type: System.Int32
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

### System.String

## Outputs

### System.Object

## Notes

## Related Links

[New-EntraBetaAttributeSet](New-EntraBetaAttributeSet.md)

[Get-EntraBetaAttributeSet](Get-EntraBetaAttributeSet.md)
