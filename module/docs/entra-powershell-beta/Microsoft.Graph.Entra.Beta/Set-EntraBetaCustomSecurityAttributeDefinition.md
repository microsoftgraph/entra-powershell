---
title: Set-EntraBetaCustomSecurityAttributeDefinition
description: This article provides details on the Set-EntraBetaCustomSecurityAttributeDefinition command.

ms.topic: reference
ms.date: 07/10/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Set-EntraBetaCustomSecurityAttributeDefinition

schema: 2.0.0
---

# Set-EntraBetaCustomSecurityAttributeDefinition

## Synopsis

Update the properties of a customSecurityAttributeDefinition object.

## Syntax

```powershell
Set-EntraBetaCustomSecurityAttributeDefinition
 -Id <String>
 [-Description <String>]
 [-Status <String>]
 [-UsePreDefinedValuesOnly <Boolean>]
 [<CommonParameters>]
```

## Description

Update the properties of a customSecurityAttributeDefinition object. Specify `Id` parameter to update a custom security attribute definition.

The signed-in user must be assigned one of the following directory roles:

- Attribute Definition Administrator

## Examples

### Example 1: Update a custom security attribute

```powershell
Connect-Entra -Scopes 'CustomSecAttributeDefinition.Read.All', 'CustomSecAttributeDefinition.ReadWrite.All'
$attributeDefinition = Get-EntraBetaCustomSecurityAttributeDefinition | Where-Object {$_.Name -eq 'Engineering'}
Set-EntraBetaCustomSecurityAttributeDefinition -Id $attributeDefinition.Id -Description 'Engineering Description' -Status 'Available' -UsePreDefinedValuesOnly $false
```

This example update a custom security attribute.

- `-Id` parameter specifies the custom security attribute definition object ID.
- `-Description` parameter specifies the description of the custom security attribute.
- `-Status` parameter specifies the custom security attribute is active or deactivated.
- `-UsePreDefinedValuesOnly` parameter specifies the only predefined values can be assigned to the custom security attribute.

## Parameters

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

### -Id

The unique identifier of a Microsoft Entra ID custom security attribute definition object.

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

## Related links

[New-EntraBetaCustomSecurityAttributeDefinition](New-EntraBetaCustomSecurityAttributeDefinition.md)

[Get-EntraBetaCustomSecurityAttributeDefinition](Get-EntraBetaCustomSecurityAttributeDefinition.md)
