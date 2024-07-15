---
title: Get-EntraBetaCustomSecurityAttributeDefinitionAllowedValue.
description: This article provides details on the Get-EntraBetaCustomSecurityAttributeDefinitionAllowedValue command.

ms.service: entra
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

# Get-EntraBetaCustomSecurityAttributeDefinitionAllowedValue

## Synopsis

Gets the predefined value for a custom security attribute definition.

## Syntax

### GetQuery (Default)

```powershell
Get-EntraBetaCustomSecurityAttributeDefinitionAllowedValue 
 -CustomSecurityAttributeDefinitionId <String> 
 [-Filter <String>]
 [<CommonParameters>]
```

### GetById

```powershell
Get-EntraBetaCustomSecurityAttributeDefinitionAllowedValue 
 -CustomSecurityAttributeDefinitionId <String>
 -Id <String> 
 [<CommonParameters>]
```

## Description

Gets the predefined value for a Microsoft Entra ID custom security attribute definition. Specify `CustomSecurityAttributeDefinitionId` parameter to retrieve the predefined value custom security attribute definition.

## Examples

### Example 1: Get all predefined values

```powershell
Connect-Entra -Scopes 'CustomSecAttributeDefinition.ReadWrite.All'
Get-EntraBetaCustomSecurityAttributeDefinitionAllowedValue -CustomSecurityAttributeDefinitionId 'Engineering_Project'
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
Connect-Entra -Scopes 'CustomSecAttributeDefinition.ReadWrite.All'
$params = @{
    CustomSecurityAttributeDefinitionId = 'Engineering_Project'
    Id = 'Alpine'
}
Get-EntraBetaCustomSecurityAttributeDefinitionAllowedValue @params
```

```output
id      isActive
--      --------
Apline      True
```

This example retrieves a specific predefined value.

- Attribute set: `Engineering`
- Attribute: `Project`
- Predefined value: `Alpine`

### Example 3: Get predefined value with Filter parameter

```powershell
Connect-Entra -Scopes 'CustomSecAttributeDefinition.ReadWrite.All'
$params = @{
    CustomSecurityAttributeDefinitionId = 'Engineering_Project'
    Filter = "id eq 'Apline'"
}
Get-EntraBetaCustomSecurityAttributeDefinitionAllowedValue @params
```

```output
id      isActive
--      --------
Apline      True
```

This example retrieves a predefined value containing Id with the specified value.

- Attribute set: `Engineering`
- Attribute: `Project`
- Predefined value: `Alpine`

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

### -Filter

Filter items by property values.

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

## Inputs

### System.String

## Outputs

### System.Object

## Notes

## Related Links

[Add-EntraBetaCustomSecurityAttributeDefinitionAllowedValues](Add-EntraBetaCustomSecurityAttributeDefinitionAllowedValues.md)

[Set-EntraBetaCustomSecurityAttributeDefinitionAllowedValue](Set-EntraBetaCustomSecurityAttributeDefinitionAllowedValue.md)
