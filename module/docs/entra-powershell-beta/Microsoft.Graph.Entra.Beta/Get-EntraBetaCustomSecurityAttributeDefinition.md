---
title: Get-EntraCustomSecurityAttributeDefinition.
description: This article provides details on the Get-EntraCustomSecurityAttributeDefinition command.

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

# Get-EntraBetaCustomSecurityAttributeDefinition

## Synopsis

Gets a list of custom security attribute definitions.

## Syntax

### GetQuery (Default)

```powershell
Get-EntraBetaCustomSecurityAttributeDefinition 
 [<CommonParameters>]
```

### GetById

```powershell
Get-EntraBetaCustomSecurityAttributeDefinition 
 -Id <String> 
 [<CommonParameters>]
```

## Description

Gets a list of Microsoft Entra ID custom security attribute definitions. Specify `Id` parameter to get a list of custom security attribute definitions.

## Examples

### Example 1: Get a list of all custom security attribute definitions

```powershell
Connect-Entra -Scopes 'CustomSecAttributeDefinition.Read.All, CustomSecAttributeDefinition.ReadWrite.All'
Get-EntraBetaCustomSecurityAttributeDefinition
```

```Output
Id                                      AttributeSet          Description                         IsCollection IsSearchable Name                             Status     Type    UsePreDefinedValuesOnly
--                                      ------------          -----------                         ------------ ------------ ----                             ------     ----    -----------------------
engineering_newvalue                    engineering           new value for command test          True         True         newvalue                         Available  String  False
Engineering_ProjectDate                 Engineering           Target completion date              False        True         ProjectDate                      Available  String  False
Test_Date                               Test                  Target completion date              False        True         Date                             Available  String  True
Test_ProjectDate                        Test                  Target completion date              False        True         ProjectDate                      Available  String  True
test2_ProjectDate                       test2                 Description Value                   False        True         ProjectDate                      Deprecated String  True
Testeng1_ProjectDate                    Testeng1              Target completion date              False        True         ProjectDate                      Available  String  True
Test5_ProjectDate                       Test5                 Target completion date              False        True         ProjectDate                      Available  String  False
DEMO7_ProjectDate                       DEMO7                 Target completion date              False        True         ProjectDate                      Available  String  False
```

This example returns all custom security attribute definitions.

### Example 2: Get a specific custom security attribute definition

```powershell
Connect-Entra -Scopes 'CustomSecAttributeDefinition.Read.All, CustomSecAttributeDefinition.ReadWrite.All'
Get-EntraBetaCustomSecurityAttributeDefinition -Id 'Engineering_ProjectDate'
```

```Output
Id                      AttributeSet Description            IsCollection IsSearchable Name        Status    Type   UsePreDefinedValuesOnly
--                      ------------ -----------            ------------ ------------ ----        ------    ----   -----------------------
Engineering_ProjectDate Engineering  Target completion date False        True         ProjectDate Available String False
```

 This example returns a specific custom security attribute definition.

- `Id` parameter specifies the custom security attribute definition object ID.

## Parameters

### -Id

The unique identifier of a Microsoft Entra ID custom security attribute definition object.

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

[New-EntraBetaCustomSecurityAttributeDefinition](New-EntraBetaCustomSecurityAttributeDefinition.md)

[Set-EntraBetaCustomSecurityAttributeDefinition](Set-EntraBetaCustomSecurityAttributeDefinition.md)
