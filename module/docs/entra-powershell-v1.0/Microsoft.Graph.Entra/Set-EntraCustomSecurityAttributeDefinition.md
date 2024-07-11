---
title: Set-EntraCustomSecurityAttributeDefinition
description: This article provides details on the Set-EntraCustomSecurityAttributeDefinition command.

ms.service: entra
ms.topic: reference
ms.date: 07/11/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra-help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Set-EntraCustomSecurityAttributeDefinition

## Synopsis

Updates an existing custom security attribute definition.

## Syntax

```powershell
Set-EntraCustomSecurityAttributeDefinition 
 -Id <String> 
 [-Description <String>] 
 [-Status <String>]
 [-UsePreDefinedValuesOnly <Boolean>] 
 [<CommonParameters>]
```

## Description

This `Set-EntraCustomSecurityAttributeDefinition` Updates a Microsoft Entra ID custom security attribute definition object identified by ID. Specify `Id` parameter to update a custom security attribute definition.

## Examples

### Example 1: Update a custom security attribute definition object identified by ID

```powershell
Connect-Entra -Scopes 'CustomSecAttributeDefinition.ReadWrite.All'
Set-EntraCustomSecurityAttributeDefinition -Id 'Engineering_Project'  -Description 'Add-description'
```

This cmdlet update the description of custom security attribute definition object.

### Example 2: Update a custom security attribute definition object identified by ID

```powershell
Connect-Entra -Scopes 'CustomSecAttributeDefinition.ReadWrite.All'
Set-EntraCustomSecurityAttributeDefinition -Id 'Engineering_Project'  -Description 'Add-description' -Status  "Available"
```

This cmdlet update the  custom security attribute definition object.

### Example 3: Update a custom security attribute definition object identified by ID

```powershell
Connect-Entra -Scopes 'CustomSecAttributeDefinition.ReadWrite.All'
Set-EntraCustomSecurityAttributeDefinition -Id 'Engineering_Project' -Description 'Add-description' -Status  "Available" -UsePreDefinedValuesOnly $false
```

This cmdlet update the  custom security attribute definition object.

## Parameters

### -Description

Description of the custom security attribute.

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

### -Id

The unique identifier for an entity. Read-only.

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

### -Status

Specifies whether the custom security attribute is active or deactivated. Acceptable values are: Available and Deprecated. Can be changed later.

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

### -UsePreDefinedValuesOnly

Indicates whether only predefined values can be assigned to the custom security attribute. If set to false, free-form values are allowed. Can later be changed from true to false, but can't be changed from false to true. If type is set to Boolean, usePreDefinedValuesOnly can't be set to true.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
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
