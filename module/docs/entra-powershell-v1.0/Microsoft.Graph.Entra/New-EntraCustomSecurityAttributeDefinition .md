---
title: New-EntraCustomSecurityAttributeDefinition
description: This article provides details on the New-EntraCustomSecurityAttributeDefinition command.

ms.topic: reference
ms.date: 07/15/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# New-EntraCustomSecurityAttributeDefinition

## Synopsis

Adds a new custom security attribute definition.

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

This `New-EntraCustomSecurityAttributeDefinition` cmdlet Adds a new Microsoft Entra ID custom security attribute definition object.

## Examples

### Example 1: Add new custom security attribute definition object

```powershell
 Connect-Entra -Scopes 'CustomSecAttributeDefinition.ReadWrite.All'
 New-EntraCustomSecurityAttributeDefinition -AttributeSet 'demo' -Name 'ProjectD2345' -Description 'Target coletion date' -Type 'String' -Status 'Available' -IsCollection $false -IsSearchable $true -UsePreDefinedValuesOnly $true
```

```Output
Name                           Value
----                           -----
attributeSet                   demo
usePreDefinedValuesOnly        True
isCollection                   False
status                         Available
isSearchable                   True
@odata.context                 https://graph.microsoft.com/v1.0/$metadata#directory/customSecurityAttributeDefinitions/$entity
name                           ProjectD2345
id                             demo_ProjectD2345
description                    Target coletion date
type                           String
```

This command creates new custom security attribute definition object.

## Parameters

### -AttributeSet

Name of the attribute set in Microsoft Entra ID.

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

Description for the custom security attribute definition.

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

Indicates whether multiple values can be assigned to the custom security attribute.

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

Indicates whether custom security attribute values are indexed for searching on objects that are assigned attribute values.

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

Name of the custom security attribute. Must be unique within an attribute set.

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

Specifies whether the custom security attribute is active or deactivated. Acceptable values are 'Available' and 'Deprecated.'

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

Specifies the data type of the attribute.

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

Indicates whether only predefined values can be assigned to the custom security attribute. If set to false, free-form values are allowed.

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

## Related Links

[Set-EntraCustomSecurityAttributeDefinition](Set-EntraCustomSecurityAttributeDefinition.md)
[Get-EntraCustomSecurityAttributeDefinition](Get-EntraCustomSecurityAttributeDefinition.md)
