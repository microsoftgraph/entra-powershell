---
title: Get-EntraCustomSecurityAttributeDefinition .
description: This article provides details on the Get-EntraCustomSecurityAttributeDefinition command.
ms.service: entra
ms.topic: reference
ms.date: 06/13/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraCustomSecurityAttributeDefinition

## SYNOPSIS

Gets a list of custom security attribute definitions.

## SYNTAX

### GetQuery (Default)

```powershell
Get-EntraCustomSecurityAttributeDefinition 
 [<CommonParameters>]
```

### GetById

```powershell
Get-EntraCustomSecurityAttributeDefinition 
 -Id <String> 
 [<CommonParameters>]
```

## DESCRIPTION

Gets a list of Microsoft Entra ID custom security attribute definitions. Specify `Id` parameter to gets a list of custom security attribute definitions.

## EXAMPLES

### Example 1: Get a list of all custom security attribute definitions

```powershell
Connect-Entra -Scopes 'CustomSecAttributeDefinition.Read.All, CustomSecAttributeDefinition.ReadWrite.All'
Get-EntraCustomSecurityAttributeDefinition
```

```output
attributeSet            : Engineering
usePreDefinedValuesOnly : False
isCollection            : False
status                  : Available
isSearchable            : True
name                    : Demo010101
id                      : Engineering_Demo010101
description             : data1
type                    : String

attributeSet            : Engineering
usePreDefinedValuesOnly : True
isCollection            : True
status                  : Available
isSearchable            : True
name                    : test23
id                      : Engineering_test23
description             :
type                    : String
```

This example get all custom security attribute definitions.

### Example 2: Get a specific custom security attribute definitions

```powershell
Connect-Entra -Scopes 'CustomSecAttributeDefinition.Read.All, CustomSecAttributeDefinition.ReadWrite.All'
Get-EntraCustomSecurityAttributeDefinition -Id 'Engineering_ProjectDate'
```

```output
attributeSet            : Demo12
usePreDefinedValuesOnly : False
isCollection            : False
status                  : Available
isSearchable            : True
@odata.context          : https://graph.microsoft.com/v1.0/$metadata#directory/customSecurityAttributeDefinitions/$entity
name                    : ProjectDatevaluevaluevalue12
id                      : Demo12_ProjectDatevaluevaluevalue12
description             : update2
type                    : String
```

Get a custom security attribute definition.

- Attribute set: `Engineering`
- Attribute: `ProjectDate`

## PARAMETERS

### -Id

The unique identifier of an Microsoft Entra ID custom security attribute definition object.

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

[New-EntraCustomSecurityAttributeDefinition](New-EntraCustomSecurityAttributeDefinition.md)

[Set-EntraCustomSecurityAttributeDefinition](Set-EntraCustomSecurityAttributeDefinition.md)
