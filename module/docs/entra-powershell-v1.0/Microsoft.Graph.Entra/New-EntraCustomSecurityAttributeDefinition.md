---
title: New-EntraCustomSecurityAttributeDefinition
description: This article provides details on the New-EntraCustomSecurityAttributeDefinition command.


ms.topic: reference
ms.date: 07/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:  https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/New-EntraCustomSecurityAttributeDefinition

schema: 2.0.0
---

# New-EntraCustomSecurityAttributeDefinition

## Synopsis

Create a new customSecurityAttributeDefinition object.

## Syntax

```powershell
New-EntraCustomSecurityAttributeDefinition
 -IsSearchable <Boolean>
 [-Description <String>]
 -IsCollection <Boolean>
 -AttributeSet <String>
 -Type <String>
 -Name <String>
 -Status <String>
 -UsePreDefinedValuesOnly <Boolean>
 [<CommonParameters>]
```

## Description

The `New-EntraCustomSecurityAttributeDefinition` cmdlet creates a new customSecurityAttributeDefinition object. Specify `IsSearchable`, `IsCollection`, `AttributeSet`, `Type`, `Name`, `Status` and `UsePreDefinedValuesOnly` parameters for create a new custom security attribute definition.

You can define up to 500 active objects in a tenant.

The signed-in user must be assigned one of the following directory roles:

- Attribute Definition Administrator

## Examples

### Example 1: Add a custom security attribute

```powershell
Connect-Entra -Scopes 'CustomSecAttributeDefinition.Read.All','CustomSecAttributeDefinition.ReadWrite.All'
$attributeSet  = Get-EntraAttributeSet -Id 'ContosoSet'
$params = @{
    Name = 'ProjectTest' 
    Description = 'Target completion'
    Type = 'String'
    Status = 'Available'
    AttributeSet = $attributeSet.Id 
    IsCollection = $False
    IsSearchable = $True 
    UsePreDefinedValuesOnly = $True
}
New-EntraCustomSecurityAttributeDefinition @params
```

```Output
Id               AttributeSet Description       IsCollection IsSearchable Name        Status    Type   UsePreDefinedValuesOnly
--               ------------ -----------       ------------ ------------ ----        ------    ----   -----------------------
Test_ProjectTest Test         Target completion False        True         ProjectTest Available String False
```

This example demonstrates how to add a custom security attribute.

- `-Name` parameter specifies the name of the custom security attribute.
- `-Description` parameter specifies the description of the custom security attribute.
- `-Type` parameter specifies the data type for the custom security attribute values.
- `-Status` parameter specifies the custom security attribute is active or deactivated.
- `-AttributeSet` parameter specifies the name of attribute set.
- `-IsCollection` parameter specifies the allows multiple values can be assigned to the custom security attribute.
- `-IsSearchable` parameter specifies the custom security attribute values are indexed for searching on objects.
- `-UsePreDefinedValuesOnly` parameter specifies the only predefined values can be assigned to the custom security attribute.

## Parameters

### -AttributeSet

Name of the attribute set. Case insensitive.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Description

Description of the custom security attribute, up to 128 characters long and including Unicode characters. This description can be changed later.

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

### -IsCollection

Indicates whether multiple values can be assigned to the custom security attribute. Can't be changed later. If type is set to Boolean, isCollection can't be set to true.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IsSearchable

Indicates whether custom security attribute values are indexed for searching on objects that are assigned attribute values. Can't be changed later.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name

Name of the custom security attribute. Must be unique within an attribute set. Can be up to 32 characters long and include Unicode characters. Can't contain spaces or special characters. Can't be changed later. Case insensitive.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Status

Specifies whether the custom security attribute is active or deactivated. Acceptable values are: Available and Deprecated. Can be changed later.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Type

Data type for the custom security attribute values. Supported types are: Boolean, Integer, and String. Can't be changed later.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UsePreDefinedValuesOnly

Indicates whether only predefined values can be assigned to the custom security attribute. If set to false, free-form values are allowed. Can later be changed from true to false, but can't be changed from false to true. If type is set to Boolean, usePreDefinedValuesOnly can't be set to true.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: True
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

## Related links

[Set-EntraCustomSecurityAttributeDefinition](Set-EntraCustomSecurityAttributeDefinition.md)

[Get-EntraCustomSecurityAttributeDefinition](Get-EntraCustomSecurityAttributeDefinition.md)
