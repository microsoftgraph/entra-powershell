---
title: Set-EntraCustomSecurityAttributeDefinitionAllowedValue
description: This article provides details on the Set-EntraCustomSecurityAttributeDefinitionAllowedValue command.

ms.topic: reference
ms.date: 07/11/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra-help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Set-EntraCustomSecurityAttributeDefinitionAllowedValue

schema: 2.0.0
---

# Set-EntraCustomSecurityAttributeDefinitionAllowedValue

## Synopsis

Updates an existing custom security attribute definition predefined value.

## Syntax

```powershell
Set-EntraCustomSecurityAttributeDefinitionAllowedValue
 [-IsActive <Boolean>]
 -CustomSecurityAttributeDefinitionId <String>
 -Id <String> [<CommonParameters>]
```

## Description

The `Set-EntraCustomSecurityAttributeDefinitionAllowedValue` cmdlet update a Microsoft Entra ID custom security attribute definition predefined value object identified by ID. Specify `CustomSecurityAttributeDefinitionId` and `Id` parameter to update a Microsoft Entra ID custom security attribute definition predefined value.

The signed-in user must be assigned one of the following directory roles:

- Attribute Definition Administrator

## Examples

### Example 1: Update a custom security attribute definition predefined value

```powershell
Connect-Entra -Scopes 'CustomSecAttributeDefinition.ReadWrite.All'
$attributeDefinition = Get-EntraCustomSecurityAttributeDefinition | Where-Object {$_.Name -eq 'Engineering'}
Set-EntraCustomSecurityAttributeDefinitionAllowedValue -CustomSecurityAttributeDefinitionId $attributeDefinition.Id -Id 'Alpine' -IsActive $true
```

This example update a custom security attribute definition predefined value.

- `-CustomSecurityAttributeDefinitionId` parameter specifies the custom security attribute definition ID.
- `-Id` parameter specifies the ID of Microsoft Entra ID Object.
- `-IsActive` parameter specifies the predefined value is active or deactivated.

## Parameters

### -CustomSecurityAttributeDefinitionId

The unique identifier of customSecurityAttributeDefinition.

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

### -Id

Indicates whether the predefined value is active or deactivated. If set to false, this predefined value cannot be assigned to any additional supported directory objects. This field is optional.

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

### -IsActive

Indicates whether the predefined value is active or deactivated. If set to false, this predefined value can't be assigned to any other supported directory objects.

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

[Get-EntraCustomSecurityAttributeDefinitionAllowedValue](Get-EntraCustomSecurityAttributeDefinitionAllowedValue.md)

[Add-EntraCustomSecurityAttributeDefinitionAllowedValue](Add-EntraCustomSecurityAttributeDefinitionAllowedValue.md)
