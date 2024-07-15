---
title: New-EntraBetaAttributeSet.
description: This article provides details on the New-EntraBetaAttributeSet command.

ms.service: entra
ms.topic: reference
ms.date: 07/10/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# New-EntraBetaAttributeSet

## Synopsis

Adds a new attribute set.

## Syntax

```powershell
New-EntraBetaAttributeSet 
 [-Description <String>] 
 [-MaxAttributesPerSet <Int32>] 
 [-Id <String>]
 [<CommonParameters>]
```

## Description

Adds a new Microsoft Entra ID attribute set object.

## Examples

### Example 1: Add a single attribute set

```powershell
Connect-Entra -Scopes 'CustomSecAttributeDefinition.ReadWrite.All'
$params = @{
    Id = 'Testing'
    Description = 'Attributes for engineering team'
    MaxAttributesPerSet = 10
}
New-EntraBetaAttributeSet @params
```

```Output
Id      Description                     MaxAttributesPerSet
--      -----------                     -------------------
Testing Attributes for engineering team 10
```

This example demonstrates hoe to add a single attribute set.

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

Required: False
Position: Named
Default value: None
Accept pipeline input: False
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

### None

## Outputs

### System.Object

## Notes

## Related Links

[Set-EntraBetaAttributeSet](Set-EntraBetaAttributeSet.md)

[Get-EntraBetaAttributeSet](Get-EntraBetaAttributeSet.md)
