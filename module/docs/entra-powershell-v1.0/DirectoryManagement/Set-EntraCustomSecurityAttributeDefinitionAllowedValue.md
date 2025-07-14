---
author: msewaweru
description: This article provides details on the Set-EntraCustomSecurityAttributeDefinitionAllowedValue command.
external help file: Microsoft.Entra.DirectoryManagement-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra
ms.author: eunicewaweru
ms.date: 07/11/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Set-EntraCustomSecurityAttributeDefinitionAllowedValue
schema: 2.0.0
title: Set-EntraCustomSecurityAttributeDefinitionAllowedValue
---

# Set-EntraCustomSecurityAttributeDefinitionAllowedValue

## SYNOPSIS

Updates an existing custom security attribute definition predefined value.

## SYNTAX

```powershell
Set-EntraCustomSecurityAttributeDefinitionAllowedValue
 [-IsActive <Boolean>]
 -CustomSecurityAttributeDefinitionId <String>
 -Id <String> [<CommonParameters>]
```

## DESCRIPTION

The `Set-EntraCustomSecurityAttributeDefinitionAllowedValue` cmdlet update a Microsoft Entra ID custom security attribute definition predefined value object identified by ID. Specify `CustomSecurityAttributeDefinitionId` and `Id` parameter to update a Microsoft Entra ID custom security attribute definition predefined value.

The signed-in user must be assigned one of the following directory roles:

- Attribute Definition Administrator

## EXAMPLES

### Example 1: Update a custom security attribute definition predefined value

```powershell
Connect-Entra -Scopes 'CustomSecAttributeDefinition.ReadWrite.All'
$attributeDefinition = Get-EntraCustomSecurityAttributeDefinition | Where-Object { $_.Name -eq 'Engineering' }
Set-EntraCustomSecurityAttributeDefinitionAllowedValue -CustomSecurityAttributeDefinitionId $attributeDefinition.Id -Id 'Alpine' -IsActive $true
```

This example update a custom security attribute definition predefined value.

- `-CustomSecurityAttributeDefinitionId` parameter specifies the custom security attribute definition ID.
- `-Id` parameter specifies the ID of Microsoft Entra ID Object.
- `-IsActive` parameter specifies the predefined value is active or deactivated.

## PARAMETERS

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

## INPUTS

### System.String

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS

[Get-EntraCustomSecurityAttributeDefinitionAllowedValue](Get-EntraCustomSecurityAttributeDefinitionAllowedValue.md)

[Add-EntraCustomSecurityAttributeDefinitionAllowedValue](Add-EntraCustomSecurityAttributeDefinitionAllowedValue.md)
