---
author: msewaweru
description: This article provides details on the Get-EntraCustomSecurityAttributeDefinition command.
external help file: Microsoft.Entra.DirectoryManagement-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra
ms.author: eunicewaweru
ms.date: 06/26/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Get-EntraCustomSecurityAttributeDefinition
schema: 2.0.0
title: Get-EntraCustomSecurityAttributeDefinition
---

# Get-EntraCustomSecurityAttributeDefinition

## SYNOPSIS

Gets a list of custom security attribute definitions.

## SYNTAX

### GetQuery (Default)

```powershell
Get-EntraCustomSecurityAttributeDefinition
 [-Property <String[]>]
 [<CommonParameters>]
```

### GetById

```powershell
Get-EntraCustomSecurityAttributeDefinition
 -Id <String>
 [-Property <String[]>]
 [<CommonParameters>]
```

## DESCRIPTION

Gets a list of Microsoft Entra ID custom security attribute definitions. Specify `Id` parameter to get a list of custom security attribute definitions.

In delegated scenarios with work or school accounts, the signed-in user must be assigned a supported Microsoft Entra role or a custom role with the necessary permissions. The following privileged roles are supported for this operation:

- Attribute Assignment Reader
- Attribute Definition Reader
- Attribute Assignment Administrator
- Attribute Definition Administrator

## EXAMPLES

### Example 1: Get a list of all custom security attribute definitions

```powershell
Connect-Entra -Scopes 'CustomSecAttributeDefinition.Read.All, CustomSecAttributeDefinition.ReadWrite.All'
Get-EntraCustomSecurityAttributeDefinition
```

```Output
Id                                      AttributeSet          Description                         IsCollection IsSearchable Name                             Status     Type    UsePreDefinedValuesOnly
--                                      ------------          -----------                         ------------ ------------ ----                             ------     ----    -----------------------
Engineering_newvalue                    Engineering           New Eng Value          True         True         NewValue                         Available  String  False
Engineering_ProjectDate                 Engineering           Target completion date              False        True         ProjectDate                      Available  String  False
```

This example returns all custom security attribute definitions.

### Example 2: Get a specific custom security attribute definition

```powershell
Connect-Entra -Scopes 'CustomSecAttributeDefinition.Read.All, CustomSecAttributeDefinition.ReadWrite.All'
$attributeDefinition = Get-EntraCustomSecurityAttributeDefinition | Where-Object { $_.Name -eq 'Engineering' }
Get-EntraCustomSecurityAttributeDefinition -Id $attributeDefinition.Id
```

```Output
Id                      AttributeSet Description            IsCollection IsSearchable Name        Status    Type   UsePreDefinedValuesOnly
--                      ------------ -----------            ------------ ------------ ----        ------    ----   -----------------------
Engineering_ProjectDate Engineering  Target completion date False        True         ProjectDate Available String False
```

 This example returns a specific custom security attribute definition.

- `Id` parameter specifies the custom security attribute definition object ID.

## PARAMETERS

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

### -Property

Specifies properties to be returned

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases: Select

Required: False
Position: Named
Default value: None
Accept pipeline input: False
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
