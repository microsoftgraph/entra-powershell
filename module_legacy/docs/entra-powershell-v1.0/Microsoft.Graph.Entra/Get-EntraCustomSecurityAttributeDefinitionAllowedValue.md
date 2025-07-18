---
title: Get-EntraCustomSecurityAttributeDefinitionAllowedValue
description: This article provides details on the Get-EntraCustomSecurityAttributeDefinitionAllowedValue command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: mwongerapk
author: msewaweru

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Get-EntraCustomSecurityAttributeDefinitionAllowedValue
schema: 2.0.0
---

# Get-EntraCustomSecurityAttributeDefinitionAllowedValue

## Synopsis

Gets the predefined value for a custom security attribute definition.

## Syntax

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

## Description

The `Get-EntraCustomSecurityAttributeDefinitionAllowedValue` cmdley gets the predefined value for a Microsoft Entra ID custom security attribute definition. Specify `CustomSecurityAttributeDefinitionId` parameter to get the predefined value custom security attribute definition.

The signed-in user must be assigned one of the following directory roles:

- Attribute Definition Reader
- Attribute Definition Administrator

## Examples

### Example 1: Get all predefined values

```powershell
Connect-Entra -Scopes 'CustomSecAttributeDefinition.ReadWrite.All'
$CustomSecurityAttributeDefinition  = Get-EntraCustomSecurityAttributeDefinition -Id '<attributename_attributedefinition>'
Get-EntraCustomSecurityAttributeDefinitionAllowedValue -CustomSecurityAttributeDefinitionId $CustomSecurityAttributeDefinition.Id
```

```Output
Id    IsActive
--    --------
Apline True
```

This example retrieves an all predefined values.

- `-CustomSecurityAttributeDefinitionId` parameter specifies the custom security attribute definition ID. You can use `Get-EntraBetaCustomSecurityAttributeDefinition` to get this value.

### Example 2: Get predefined value with ID parameter

```powershell
Connect-Entra -Scopes 'CustomSecAttributeDefinition.ReadWrite.All'
$CustomSecurityAttributeDefinition  = Get-EntraCustomSecurityAttributeDefinition -Id '<attributename_attributedefinition>'
$params = @{
    CustomSecurityAttributeDefinitionId = $CustomSecurityAttributeDefinition.Id
    Id = 'Alpine'
}
Get-EntraCustomSecurityAttributeDefinitionAllowedValue @params
```

```Output
id      isActive
--      --------
Apline      True
```

This example retrieves a specific predefined value.

- `-CustomSecurityAttributeDefinitionId` parameter specifies the custom security attribute definition ID. You can use `Get-EntraBetaCustomSecurityAttributeDefinition` to get this value.
- `-Id` parameter specifies the ID of Microsoft Entra ID Object.

### Example 3: Get predefined value with Filter parameter

```powershell
Connect-Entra -Scopes 'CustomSecAttributeDefinition.ReadWrite.All'
$CustomSecurityAttributeDefinition  = Get-EntraCustomSecurityAttributeDefinition -Id '<attributename_attributedefinition>'
$params = @{
    CustomSecurityAttributeDefinitionId = $CustomSecurityAttributeDefinition.Id
    Filter = "Id eq 'Apline'"
}
Get-EntraCustomSecurityAttributeDefinitionAllowedValue @params
```

```Output
id      isActive
--      --------
Apline      True
```

This example Get a predefined value with Filter.

- `-CustomSecurityAttributeDefinitionId` parameter specifies the custom security attribute definition ID. You can use `Get-EntraBetaCustomSecurityAttributeDefinition` to get this value.

## Parameters

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

The unique identifier for the predefined value, which can be up to 64 characters long and include Unicode characters. Spaces are allowed, but some special characters are not. This identifier is case sensitive, cannot be changed later, and is required.

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

[Add-EntraCustomSecurityAttributeDefinitionAllowedValue](Add-EntraCustomSecurityAttributeDefinitionAllowedValue.md)

[Set-EntraCustomSecurityAttributeDefinitionAllowedValue](Set-EntraCustomSecurityAttributeDefinitionAllowedValue.md)
