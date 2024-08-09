---
title: Get-EntraCustomSecurityAttributeDefinition
description: This article provides details on the Get-EntraCustomSecurityAttributeDefinition command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Get-EntraCustomSecurityAttributeDefinition
schema: 2.0.0
---

# Get-EntraCustomSecurityAttributeDefinition

## Synopsis

Gets a list of custom security attribute definitions.

## Syntax

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

## Description

The `Get-EntraCustomSecurityAttributeDefinition` cmdlet gets a list of Microsoft Entra ID custom security attribute definitions. Specify `Id` parameter to gets a list of custom security attribute definitions.

In delegated scenarios with work or school accounts, the signed-in user must be assigned a supported Microsoft Entra role or a custom role with the necessary permissions. The following privileged roles are supported for this operation:

- Attribute Assignment Reader
- Attribute Definition Reader
- Attribute Assignment Administrator
- Attribute Definition Administrator

## Examples

### Example 1: Get a list of all custom security attribute definitions

```powershell
Connect-Entra -Scopes 'CustomSecAttributeDefinition.Read.All', 'CustomSecAttributeDefinition.ReadWrite.All'
Get-EntraCustomSecurityAttributeDefinition
```

```Output
Id                                      AttributeSet          Description                         IsCollection IsSearchable Name                             Status     Typ
                                                                                                                                                                        e
--                                      ------------          -----------                         ------------ ------------ ----                             ------     ---
engineering_newvalue                    engineering           new value for command test          True         True         newvalue                         Available  Str
Engineering_ProjectDate                 Engineering           Target completion date              False        True         ProjectDate                      Available  Str
```

This example get all custom security attribute definitions.

### Example 2: Get a specific custom security attribute definitions

```powershell
Connect-Entra -Scopes 'CustomSecAttributeDefinition.Read.All', 'CustomSecAttributeDefinition.ReadWrite.All'
Get-EntraCustomSecurityAttributeDefinition -Id 'Engineering_Project'
```

```Output
Id                  AttributeSet Description IsCollection IsSearchable Name    Status     Type   UsePreDefinedValuesOnly
--                  ------------ ----------- ------------ ------------ ----    ------     ----   -----------------------
Engineering_Project Engineering  new update1 True         True         Project Deprecated String False
```

Get a custom security attribute definition.

- `-Id` Specify the unique identifier of custom security attribute definition object.
- Attribute set: `Engineering`
- Attribute: `ProjectDate`

## Parameters

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

## Inputs

### System.String

## Outputs

### System.Object

## Notes

## Related Links

[New-EntraCustomSecurityAttributeDefinition](New-EntraCustomSecurityAttributeDefinition.md)

[Set-EntraCustomSecurityAttributeDefinition](Set-EntraCustomSecurityAttributeDefinition.md)
