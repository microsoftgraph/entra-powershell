---
author: msewaweru
description: This article provides details on the New-EntraBetaAttributeSet command.
external help file: Microsoft.Entra.Beta.DirectoryManagement-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 07/10/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/New-EntraBetaAttributeSet
schema: 2.0.0
title: New-EntraBetaAttributeSet
---

# New-EntraBetaAttributeSet

## SYNOPSIS

Adds a new attribute set.

## SYNTAX

```powershell
New-EntraBetaAttributeSet
 [-Description <String>]
 [-MaxAttributesPerSet <Int32>]
 [-AttributeSetId <String>]
 [<CommonParameters>]
```

## DESCRIPTION

Adds a new Microsoft Entra ID attribute set object.

The signed-in user must be assigned one of the following directory roles:

- Attribute Definition Administrator

## EXAMPLES

### Example 1: Add a single attribute set

```powershell
Connect-Entra -Scopes 'CustomSecAttributeDefinition.ReadWrite.All'
New-EntraBetaAttributeSet -AttributeSetId 'ContosoSet' -Description 'Contoso Set' -MaxAttributesPerSet 15
```

```Output
Id      Description                     MaxAttributesPerSet
--      -----------                     -------------------
Testing Attributes for engineering team 10
```

This example demonstrates hoe to add a single attribute set.

- `-AttributeSetId` parameter specifies the name of the attribute set.
- `-Description` parameter specifies the description for the attribute set.
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

Name of the attribute set. Unique identifier for the attribute set within a tenant, up to 32 Unicode characters. It can't contain spaces or special characters, is case sensitive, and can't be changed later. Required.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: Id

Required: False
Position: Named
Default value: None
Accept pipeline input: False
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

### None

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS

[Set-EntraBetaAttributeSet](Set-EntraBetaAttributeSet.md)

[Get-EntraBetaAttributeSet](Get-EntraBetaAttributeSet.md)
