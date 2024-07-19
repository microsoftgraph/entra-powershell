---
title: Get-EntraAttributeSet
description: This article provides details on the Get-EntraAttributeSet command.

ms.service: entra
ms.topic: reference
ms.date: 07/19/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraAttributeSet

## SYNOPSIS

Gets a list of attribute sets.

## SYNTAX

### GetQuery (Default)

```powershell
Get-EntraAttributeSet
 [<CommonParameters>]
```

### GetById

```powershell
Get-EntraAttributeSet
 -Id <String> 
 [<CommonParameters>]
```

## DESCRIPTION

The `Get-EntraAttributeSet` cmdlet gets a list of Microsoft Entra ID attribute sets.

In delegated scenarios with work or school accounts, the signed-in user must have a supported Microsoft Entra role or a custom role with the necessary permissions. The supported roles for this operation are:

- Attribute Assignment Reader
- Attribute Definition Reader
- Attribute Assignment Administrator
- Attribute Definition Administrator

By default, other administrator roles cannot read, define, or assign custom security attributes.

## EXAMPLES

### Example 1: Get an all attribute sets

```powershell
Connect-Entra -Scopes 'CustomSecAttributeDefinition.Read.All'
Get-EntraAttributeSet
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
```

This example Get all attribute sets.

### Example 2: Get an attribute sets

```powershell
Connect-Entra -Scopes 'CustomSecAttributeDefinition.Read.All'
Get-EntraAttributeSet -Id 'Engineering'
```

```Output
Id          Description                           MaxAttributesPerSet
--          -----------                           -------------------
engineering Attributes for cloud engineering team 25
```

This example gets an attribute set.

- Attribute set: `Engineering`

## PARAMETERS

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

## INPUTS

### System.String

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS

[New-EntraAttributeSet](New-EntraAttributeSet.md)

[Set-EntraAttributeSet](Set-EntraAttributeSet.md)
