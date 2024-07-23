---
title: Add-EntraCustomSecurityAttributeDefinitionAllowedValues.
description: This article provides details on the Add-EntraCustomSecurityAttributeDefinitionAllowedValues command.

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

# Add-EntraCustomSecurityAttributeDefinitionAllowedValues

## SYNOPSIS

Adds a predefined value for a custom security attribute definition.

## SYNTAX

```powershell
Add-EntraCustomSecurityAttributeDefinitionAllowedValues 
 -CustomSecurityAttributeDefinitionId <String>
 -Id <String> 
 -IsActive <Boolean> 
 [<CommonParameters>]
```

## DESCRIPTION

The `Add-EntraCustomSecurityAttributeDefinitionAllowedValues` adds a predefined value for a Microsoft Entra ID custom security attribute definition.

## EXAMPLES

### Example 1: Add a predefined value for a Microsoft Entra ID custom security attribute definition

```powershell
Connect-Entra -Scopes 'CustomSecAttributeDefinition.ReadWrite.All'
$params = @{
    CustomSecurityAttributeDefinitionId = 'Engineering_Project'
    Id = 'Alpine'
    IsActive = $true
 }
Add-EntraCustomSecurityAttributeDefinitionAllowedValues @params
```

```Output

Id   IsActive
--   --------
Alpine True
```

This example Add a predefined value:

- `-CustomSecurityAttributeDefinitionId` Specify the unique identifier for custom security attribute definition.
- `-Id` Specify the the unique identifier of an object.
- `-IsActive` Specify whether the predefined value is active or deactivated.

## PARAMETERS

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

The unique identifier of an object in Microsoft Entra ID.

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

## INPUTS

### System.String

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS

[Get-EntraCustomSecurityAttributeDefinitionAllowedValues](Get-EntraCustomSecurityAttributeDefinitionAllowedValues.md)

[Set-EntraCustomSecurityAttributeDefinitionAllowedValues](Set-EntraCustomSecurityAttributeDefinitionAllowedValues.md)
