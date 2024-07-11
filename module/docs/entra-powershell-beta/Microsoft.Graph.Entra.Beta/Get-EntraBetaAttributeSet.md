---
title: Set-EntraBetaAttributeSet.
description: This article provides details on the Set-EntraBetaAttributeSet command.

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

# Get-EntraBetaAttributeSet

## Synopsis

Gets a list of attribute sets.

## Syntax

### GetQuery (Default)

```powershell
Get-EntraBetaAttributeSet 
 [<CommonParameters>]
```

### GetById

```powershell
Get-EntraBetaAttributeSet 
 -Id <String> 
 [<CommonParameters>]
```

## Description

Gets a list of Microsoft Entra ID attribute sets. Specify `Id` parameter to retrieve an attribute set.

## Examples

### Example 1: Get an all attribute sets

```powershell
Connect-Entra -Scopes 'CustomSecAttributeDefinition.ReadWrite.All'
Set-EntraBetaAttributeSet 
```

```Output
Id                    Description                           MaxAttributesPerSet
--                    -----------                           -------------------
engineering           Attributes for cloud engineering team 25
Test2                 Attributes for test2  team            25
demo                  NEW Demo Description                  25
demo2                 TEST THE DEMO
DEMO5
DEMO6                 Description to test the demo6
DEMO7                 Description to test the demo6         24
demo3                 Demo3's Description                   33
```

This example Get all attribute sets.

### Example 2: Get an attribute sets

```powershell
Connect-Entra -Scopes 'CustomSecAttributeDefinition.ReadWrite.All'
Get-EntraAttributeSet -Id 'Testing'
```

```Output
Id      Description                     MaxAttributesPerSet
--      -----------                     -------------------
Testing Attributes for engineering team 10
```

This example gets an attribute set by Id.

## Parameters

### -Id

The unique identifier of a Microsoft Entra ID set object.

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

### System.String

## Outputs

### System.Object

## Notes

## Related Links

[New-EntraBetaAttributeSet](New-EntraBetaAttributeSet.md)

[Set-EntraBetaAttributeSet](Set-EntraBetaAttributeSet.md)
