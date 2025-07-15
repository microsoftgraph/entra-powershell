---
author: msewaweru
description: This article provides details on the Get-EntraBetaCustomSecurityAttributeDefinitionAllowedValue command.
external help file: Microsoft.Entra.Beta.DirectoryManagement-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 07/12/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Get-EntraBetaCustomSecurityAttributeDefinitionAllowedValue
schema: 2.0.0
title: Get-EntraBetaCustomSecurityAttributeDefinitionAllowedValue
---

# Get-EntraBetaCustomSecurityAttributeDefinitionAllowedValue

## SYNOPSIS

Gets the predefined value for a custom security attribute definition.

## SYNTAX

### GetQuery (Default)

```powershell
Get-EntraBetaCustomSecurityAttributeDefinitionAllowedValue
 -CustomSecurityAttributeDefinitionId <String>
 [-Filter <String>]
 [-Property <String[]>]
 [<CommonParameters>]
```

### GetById

```powershell
Get-EntraBetaCustomSecurityAttributeDefinitionAllowedValue
 -CustomSecurityAttributeDefinitionId <String>
 -Id <String>
 [-Property <String[]>]
 [<CommonParameters>]
```

## DESCRIPTION

Gets the predefined value for a Microsoft Entra ID custom security attribute definition. Specify `CustomSecurityAttributeDefinitionId` parameter to retrieve the predefined value custom security attribute definition.

The signed-in user must be assigned one of the following directory roles:

- Attribute Definition Reader
- Attribute Definition Administrator

## EXAMPLES

### Example 1: Get all predefined values

```powershell
Connect-Entra -Scopes 'CustomSecAttributeDefinition.ReadWrite.All'
$attributeDefinition = Get-EntraBetaCustomSecurityAttributeDefinition | Where-Object {$_.Name -eq 'Engineering'}
Get-EntraBetaCustomSecurityAttributeDefinitionAllowedValue -CustomSecurityAttributeDefinitionId $attributeDefinition.Id
```

```Output
Id        IsActive
--        --------
Apline    True
```

This example retrieves an all predefined values.

- `-CustomSecurityAttributeDefinitionId` parameter specifies the custom security attribute definition ID. You can use `Get-EntraBetaCustomSecurityAttributeDefinition` to get this value.

### Example 2: Get predefined value with ID parameter

```powershell
Connect-Entra -Scopes 'CustomSecAttributeDefinition.ReadWrite.All'
$attributeDefinition = Get-EntraBetaCustomSecurityAttributeDefinition | Where-Object {$_.Name -eq 'Engineering'}
Get-EntraBetaCustomSecurityAttributeDefinitionAllowedValue -CustomSecurityAttributeDefinitionId $attributeDefinition.Id -Id 'Alpine'
```

```Output
Id        IsActive
--        --------
Apline    True
```

This example retrieves a specific predefined value.

- `-CustomSecurityAttributeDefinitionId` parameter specifies the custom security attribute definition ID. You can use `Get-EntraBetaCustomSecurityAttributeDefinition` to get this value.
- `-Id` parameter specifies the ID of Microsoft Entra ID Object.

### Example 3: Get predefined value with Filter parameter

```powershell
Connect-Entra -Scopes 'CustomSecAttributeDefinition.ReadWrite.All'
$attributeDefinition = Get-EntraBetaCustomSecurityAttributeDefinition | Where-Object {$_.Name -eq 'Engineering'}
Get-EntraBetaCustomSecurityAttributeDefinitionAllowedValue -CustomSecurityAttributeDefinitionId $attributeDefinition.Id -Filter "Id eq 'Alpine'"
```

```Output
Id        IsActive
--        --------
Apline    True
```

This example retrieves a predefined value containing Id with the specified value.

- `-CustomSecurityAttributeDefinitionId` parameter specifies the custom security attribute definition ID. You can use `Get-EntraBetaCustomSecurityAttributeDefinition` to get this value.

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

### -Property

Specifies properties to be returned

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases: Select

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

[Add-EntraBetaCustomSecurityAttributeDefinitionAllowedValue](Add-EntraBetaCustomSecurityAttributeDefinitionAllowedValue.md)

[Set-EntraBetaCustomSecurityAttributeDefinitionAllowedValue](Set-EntraBetaCustomSecurityAttributeDefinitionAllowedValue.md)
