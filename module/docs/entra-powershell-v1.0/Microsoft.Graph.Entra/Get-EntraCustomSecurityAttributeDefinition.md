---
title: Get-EntraCustomSecurityAttributeDefinition.
description: This article provides details on the Get-EntraCustomSecurityAttributeDefinition command.

ms.topic: reference
ms.date: 07/23/2024
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

The `Get-EntraCustomSecurityAttributeDefinition` cmdlet gets a list of Microsoft Entra ID custom security attribute definitions. Specify `Id` parameter to gets a list of custom security attribute definitions.

## EXAMPLES

### Example 1: Get a list of all custom security attribute definitions

```powershell
Connect-Entra -Scopes 'CustomSecAttributeDefinition.Read.All, CustomSecAttributeDefinition.ReadWrite.All'
Get-EntraCustomSecurityAttributeDefinition
```

```Output
Id                                      AttributeSet          Description                         IsCollection IsSearchable Name                             Status     Typ
                                                                                                                                                                        e
--                                      ------------          -----------                         ------------ ------------ ----                             ------     ---
engineering_newvalue                    engineering           new value for command test          True         True         newvalue                         Available  Str
Engineering_ProjectDate                 Engineering           Target completion date              False        True         ProjectDate                      Available  Str
Test_Date                               Test                  Target completion date              False        True         Date                             Available  Str
Test_ProjectDate                        Test                  Target completion date              False        True         ProjectDate                      Available  Str
test2_ProjectDate                       test2                 Description Value                   False        True         ProjectDate                      Deprecated Str
Testeng1_ProjectDate                    Testeng1              Target completion date              False        True         ProjectDate                      Available  Str
```

This example get all custom security attribute definitions.

### Example 2: Get a specific custom security attribute definitions

```powershell
Connect-Entra -Scopes 'CustomSecAttributeDefinition.Read.All, CustomSecAttributeDefinition.ReadWrite.All'
Get-EntraCustomSecurityAttributeDefinition -Id 'Engineering_Project'
```

```Output
Id                  AttributeSet Description IsCollection IsSearchable Name    Status     Type   UsePreDefinedValuesOnly
--                  ------------ ----------- ------------ ------------ ----    ------     ----   -----------------------
Engineering_Project Engineering  new update1 True         True         Project Deprecated String False
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
