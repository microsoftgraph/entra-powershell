---
title: Get-EntraCustomSecurityAttributeDefinitionAllowedValue.
description: This article provides details on the Get-EntraCustomSecurityAttributeDefinitionAllowedValue command.
ms.service: entra
ms.topic: reference
ms.date: 06/14/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraCustomSecurityAttributeDefinitionAllowedValue

## SYNOPSIS

Gets the predefined value for a custom security attribute definition.

## SYNTAX

### GetQuery (Default)

```powershell
Get-EntraCustomSecurityAttributeDefinitionAllowedValue 
 -CustomSecurityAttributeDefinitionId <String>
 [-Filter <String>] 
 [<CommonParameters>]
```

### GetById

```powershell
Get-EntraCustomSecurityAttributeDefinitionAllowedValue 
 -CustomSecurityAttributeDefinitionId <String>
 -Id <String> 
 [<CommonParameters>]
```

## DESCRIPTION

Gets the predefined value for a Microsoft Entra ID custom security attribute definition. Specify `CustomSecurityAttributeDefinitionId` parameter to Get the predefined value custom security attribute definition.

## EXAMPLES

### Example 1: Get all predefined values

```powershell
Connect-Entra -Scopes 'CustomSecAttributeDefinition.Read.All, CustomSecAttributeDefinition.ReadWrite.All'
Get-EntraCustomSecurityAttributeDefinitionAllowedValue -CustomSecurityAttributeDefinitionId 'Engineering_Project'
```

```output
id      isActive
--      --------
Apline      True
```

This example Get all predefined values.

- Attribute set: `Engineering`
- Attribute: `Project`

### Example 2: Get predefined value with ID parameter

```powershell
Connect-Entra -Scopes 'CustomSecAttributeDefinition.Read.All, CustomSecAttributeDefinition.ReadWrite.All'
Get-EntraCustomSecurityAttributeDefinitionAllowedValue -CustomSecurityAttributeDefinitionId 'Engineering_Project' -Id 'Alpine'
```

```output
id      isActive
--      --------
Apline      True
```

This example Get a predefined value.

- Attribute set: `Engineering`
- Attribute: `Project`
- Predefined value: `Alpine`

### Example 3: Get predefined value with Filter parameter

```powershell
Connect-Entra -Scopes 'CustomSecAttributeDefinition.Read.All, CustomSecAttributeDefinition.ReadWrite.All'
Get-EntraCustomSecurityAttributeDefinitionAllowedValue -CustomSecurityAttributeDefinitionId 'Engineering_Project' -Filter "id eq 'Apline'"
```

```output
id      isActive
--      --------
Apline      True
```

This example Get a predefined value with Filter.

- Attribute set: `Engineering`
- Attribute: `Project`
- Predefined value: `Alpine`

## PARAMETERS

### -CustomSecurityAttributeDefinitionId

The unique identifier of a custom security attribute definition in Microsoft Entra ID.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Filter

Filter items by property values

```yaml
Type: System.String
Parameter Sets: GetQuery
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Id

The unique identifier of a predefined value in Microsoft Entra ID.

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
