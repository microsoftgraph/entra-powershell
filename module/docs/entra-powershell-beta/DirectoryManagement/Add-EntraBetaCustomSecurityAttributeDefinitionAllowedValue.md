---
author: msewaweru
description: This article provides details on the Add-EntraBetaCustomSecurityAttributeDefinitionAllowedValue command.
external help file: Microsoft.Entra.Beta.DirectoryManagement-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 07/12/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Add-EntraBetaCustomSecurityAttributeDefinitionAllowedValue
schema: 2.0.0
title: Add-EntraBetaCustomSecurityAttributeDefinitionAllowedValue
---

# Add-EntraBetaCustomSecurityAttributeDefinitionAllowedValue

## Synopsis

Adds a predefined value for a custom security attribute definition.

## Syntax

```powershell
Add-EntraBetaCustomSecurityAttributeDefinitionAllowedValue
 -IsActive <Boolean>
 -CustomSecurityAttributeDefinitionId <String>
 -Id <String>
 [<CommonParameters>]
```

## Description

The `Add-EntraBetaCustomSecurityAttributeDefinitionAllowedValue` adds a predefined value for a Microsoft Entra ID custom security attribute definition.

In delegated scenarios with work or school accounts, the signed-in user must have a supported Microsoft Entra role or a custom role with the necessary permissions. The following least privileged roles can be used:

- Attribute Definition Administrator

## Examples

### Example 1: Add a predefined value for a Microsoft Entra ID custom security attribute definition

```powershell
Connect-Entra -Scopes 'CustomSecAttributeDefinition.ReadWrite.All'
$attributeDefinition = Get-EntraBetaCustomSecurityAttributeDefinition | Where-Object { $_.Name -eq 'Engineering' }
Add-EntraBetaCustomSecurityAttributeDefinitionAllowedValue -CustomSecurityAttributeDefinitionId $attributeDefinition.Id -Id 'Alpine' -IsActive $true
```

```Output
Id   IsActive
--   --------
Alpine True
```

This example adds a predefined value to a custom security attribute definition.

- `-CustomSecurityAttributeDefinitionId` parameter specifies the custom security attribute definition ID. You can use the command `Get-EntraBetaCustomSecurityAttributeDefinition` to get the ID.
- `-Id` parameter specifies the identifier for the predefined value.
- `-IsActive` parameter specifies the predefined value is active or deactivated.

## Parameters

### -CustomSecurityAttributeDefinitionId

The unique identifier for a custom security attribute definition in Microsoft Entra ID.

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

The unique identifier for the predefined value, which can be up to 64 characters long and include Unicode characters. Spaces are allowed, but some special characters aren't. This identifier is case sensitive, can't be changed later, and is required.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IsActive

Indicates whether the predefined value is active or deactivated. If set to false, this predefined value can't be assigned to any another supported directory objects.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: True
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

`Add-EntraBetaCustomSecurityAttributeDefinitionAllowedValues` is an alias for `Add-EntraBetaCustomSecurityAttributeDefinitionAllowedValue`.

## Related links

[Get-EntraBetaCustomSecurityAttributeDefinitionAllowedValue](Get-EntraBetaCustomSecurityAttributeDefinitionAllowedValue.md)

[Set-EntraBetaCustomSecurityAttributeDefinitionAllowedValue](Set-EntraBetaCustomSecurityAttributeDefinitionAllowedValue.md)
