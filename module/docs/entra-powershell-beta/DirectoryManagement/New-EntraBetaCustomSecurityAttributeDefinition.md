---
author: msewaweru
description: This article provides details on the New-EntraBetaCustomSecurityAttributeDefinition command.
external help file: Microsoft.Entra.Beta.DirectoryManagement-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 07/10/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/New-EntraBetaCustomSecurityAttributeDefinition
schema: 2.0.0
title: New-EntraBetaCustomSecurityAttributeDefinition
---

# New-EntraBetaCustomSecurityAttributeDefinition

## SYNOPSIS

Create a new customSecurityAttributeDefinition object.

## SYNTAX

```powershell
New-EntraBetaCustomSecurityAttributeDefinition
 -IsSearchable <Boolean>
 -IsCollection <Boolean>
 -AttributeSet <String>
 -Type <String>
 -Name <String>
 -Status <String>
 -UsePreDefinedValuesOnly <Boolean>
 [-Description <String>]
 [<CommonParameters>]
```

## DESCRIPTION

The `New-EntraBetaCustomSecurityAttributeDefinition` cmdlet creates a new customSecurityAttributeDefinition object. Specify `IsSearchable`, `IsCollection`, `AttributeSet`, `Type`, `Name`, `Status` and `UsePreDefinedValuesOnly` parameters for create a new custom security attribute definition.

You can define up to 500 active objects in a tenant.

The signed-in user must be assigned one of the following directory roles:

- Attribute Definition Administrator

## EXAMPLES

### Example 1: Add a custom security attribute

```powershell
Connect-Entra -Scopes 'CustomSecAttributeDefinition.Read.All', 'CustomSecAttributeDefinition.ReadWrite.All'
$attributeSet = Get-EntraAttributeSet -Id 'ContosoSet'
$params = @{
    Name                    = 'ProjectTest' 
    Description             = 'Target completion'
    Type                    = 'String'
    Status                  = 'Available'
    AttributeSet            = $attributeSet.Id 
    IsCollection            = $False
    IsSearchable            = $True 
    UsePreDefinedValuesOnly = $True
}
New-EntraBetaCustomSecurityAttributeDefinition @params
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

## PARAMETERS

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

## INPUTS

### None

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS

[Set-EntraBetaCustomSecurityAttributeDefinition](Set-EntraBetaCustomSecurityAttributeDefinition.md)

[Get-EntraBetaCustomSecurityAttributeDefinition](Get-EntraBetaCustomSecurityAttributeDefinition.md)
