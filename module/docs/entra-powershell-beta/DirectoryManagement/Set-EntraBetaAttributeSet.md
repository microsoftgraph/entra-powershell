---
author: msewaweru
description: This article provides details on the Set-EntraBetaAttributeSet command.
external help file: Microsoft.Entra.Beta.DirectoryManagement-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 07/10/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Set-EntraBetaAttributeSet
schema: 2.0.0
title: Set-EntraBetaAttributeSet
---

# Set-EntraBetaAttributeSet

## Synopsis

Updates an existing attribute set.

## Syntax

```powershell
Set-EntraBetaAttributeSet
 -AttributeSetId <String>
 [-Description <String>]
 [-MaxAttributesPerSet <Int32>]
 [<CommonParameters>]
```

## Description

The `Set-EntraBetaAttributeSet` cmdlet updates a Microsoft Entra ID attribute set object specified by its ID. You can only update the `description` and `maxAttributesPerSet` properties.

The signed-in user must be assigned one of the following directory roles:

- Attribute Definition Administrator

## Examples

### Example 1: Update an attribute set

```powershell
Connect-Entra -Scopes 'CustomSecAttributeDefinition.ReadWrite.All'
Set-EntraBetaAttributeSet -AttributeSetId 'Engineering' -Description 'Attributes for cloud engineering team'
```

This example update an attribute set.

- `AttributeSetId` parameter specifies the name of the attribute set. You can `Get-EntraBetaAttributeSet` to get more details.
- `Description` parameter specifies the description for the attribute set.

### Example 2: Update an attribute set using MaxAttributesPerSet

```powershell
Connect-Entra -Scopes 'CustomSecAttributeDefinition.ReadWrite.All'
Set-EntraBetaAttributeSet -AttributeSetId 'Engineering' -MaxAttributesPerSet 10
```

This example update an attribute set using MaxAttributesPerSet.

- `-AttributeSetId` parameter specifies the name of the attribute set. You can `Get-EntraBetaAttributeSet` to get more details.
- `-MaxAttributesPerSet` parameter specifies the maximum number of custom security attributes.

## Parameters

### -Description

Description of the attribute set, up to 128 characters long, including Unicode characters. This description can be changed later.

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

### -AttributeSetId

Name of the attribute set. Unique identifier for the attribute set within a tenant. This identifier can be up to 32 characters long and may include Unicode characters. It cannot contain spaces or special characters, and it cannot be changed later. The identifier is case insensitive.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: Id

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -MaxAttributesPerSet

Maximum number of custom security attributes that can be defined in this attribute set. The default value is null. If not specified, the administrator can add up to 500 active attributes per tenant. This setting can be changed later.

```yaml
Type: System.Int32
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

[New-EntraBetaAttributeSet](New-EntraBetaAttributeSet.md)

[Get-EntraBetaAttributeSet](Get-EntraBetaAttributeSet.md)
