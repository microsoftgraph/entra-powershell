---
author: msewaweru
description: This article provides details on the Set-EntraAttributeSet command.
external help file: Microsoft.Entra.DirectoryManagement-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.DirectoryManagement
ms.author: eunicewaweru
ms.date: 07/19/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.DirectoryManagement/Set-EntraAttributeSet
schema: 2.0.0
title: Set-EntraAttributeSet
---

# Set-EntraAttributeSet

## SYNOPSIS

Updates an existing attribute set.

## SYNTAX

```powershell
Set-EntraAttributeSet
 -AttributeSetId <String>
 [-Description <String>]
 [-MaxAttributesPerSet <Int32>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Set-EntraAttributeSet` cmdlet updates a Microsoft Entra ID attribute set object specified by its ID. You can only update the `description` and `maxAttributesPerSet` properties.

The signed-in user must be assigned one of the following directory roles:

- Attribute Definition Administrator

## EXAMPLES

### Example 1: Update an attribute set

```powershell
Connect-Entra -Scopes 'CustomSecAttributeDefinition.ReadWrite.All'
Set-EntraAttributeSet -AttributeSetId 'Engineering' -Description 'Attributes for cloud engineering team'
```

This example update an attribute set.

- `-AttributeSetId` parameter specifies the name of the attribute set. You can `Get-EntraAttributeSet` to get more details.
- `-Description` parameter specifies the description for the attribute set.

### Example 2: Update an attribute set using MaxAttributesPerSet

```powershell
Connect-Entra -Scopes 'CustomSecAttributeDefinition.ReadWrite.All'
Set-EntraAttributeSet -AttributeSetId 'Engineering' -MaxAttributesPerSet 10
```

This example update an attribute set using MaxAttributesPerSet.

- `-AttributeSetId` parameter specifies the name of the attribute set. You can `Get-EntraAttributeSet` to get more details.
- `-MaxAttributesPerSet` parameter specifies the maximum number of custom security attributes.

## PARAMETERS

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

## INPUTS

### System.String

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS

[New-EntraAttributeSet](New-EntraAttributeSet.md)

[Get-EntraAttributeSet](Get-EntraAttributeSet.md)
