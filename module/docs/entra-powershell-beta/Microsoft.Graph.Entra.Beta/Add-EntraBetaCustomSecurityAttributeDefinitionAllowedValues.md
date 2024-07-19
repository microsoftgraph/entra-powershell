---
title: Add-EntraBetaCustomSecurityAttributeDefinitionAllowedValues.
description: This article provides details on the Add-EntraBetaCustomSecurityAttributeDefinitionAllowedValues command.

ms.topic: reference
ms.date: 07/12/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Add-EntraBetaCustomSecurityAttributeDefinitionAllowedValues

## Synopsis

Adds a predefined value for a custom security attribute definition.

## Syntax

```powershell
Add-EntraBetaCustomSecurityAttributeDefinitionAllowedValues 
 -IsActive <Boolean>
 -CustomSecurityAttributeDefinitionId <String> 
 -Id <String> 
 [<CommonParameters>]
```

## Description

Adds a predefined value for a Microsoft Entra ID custom security attribute definition.

## Examples

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
Name                           Value
----                           -----
@odata.context                 https://graph.microsoft.com/v1.0/$metadata#directory/customSecurityAttributeDefinitions('Engineering_Project')/allowedValues/$entity
id                             Alpine
isActive                       True
```

This example Add a predefined value for a custom security attributr definition.

- `CustomSecurityAttributeDefinitionId` parameter specifies the custom security attribute definition ID.
- `Id` parameter specifies the ID of Microsoft Entra ID Object.
- `IsActive` parameter specifies the predefined value is active or deactivated.

## Parameters

### -CustomSecurityAttributeDefinitionId

The unique identifier for a custom security attribute definition in Microsoft Entra ID.

```yaml
Type: Sysetm.String
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

## Inputs

### System.String

## Outputs

### System.Object

## Notes

## Related Links

[Get-EntraBetaCustomSecurityAttributeDefinitionAllowedValue](Get-EntraBetaCustomSecurityAttributeDefinitionAllowedValue.md)

[Set-EntraBetaCustomSecurityAttributeDefinitionAllowedValue](Set-EntraBetaCustomSecurityAttributeDefinitionAllowedValue.md)
