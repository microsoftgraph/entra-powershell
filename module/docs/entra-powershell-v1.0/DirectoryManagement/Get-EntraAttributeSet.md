---
description: This article provides details on the Get-EntraAttributeSet command.
external help file: Microsoft.Entra.DirectoryManagement-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra
ms.author: eunicewaweru
ms.date: 07/19/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Get-EntraAttributeSet
schema: 2.0.0
title: Get-EntraAttributeSet
---

# Get-EntraAttributeSet

## Synopsis

Gets a list of attribute sets.

## Syntax

### GetQuery (Default)

```powershell
Get-EntraAttributeSet
 [<CommonParameters>]
```

### GetById

```powershell
Get-EntraAttributeSet
 -AttributeSetId <String>
 [<CommonParameters>]
```

## Description

The `Get-EntraAttributeSet` cmdlet gets a list of Microsoft Entra ID attribute sets.

In delegated scenarios with work or school accounts, the signed-in user must have a supported Microsoft Entra role or a custom role with the necessary permissions. The supported roles for this operation are:

- Attribute Assignment Reader
- Attribute Definition Reader
- Attribute Assignment Administrator
- Attribute Definition Administrator

By default, other administrator roles cannot read, define, or assign custom security attributes.

## Examples

### Example 1: Get an all attribute sets

```powershell
Connect-Entra -Scopes 'CustomSecAttributeDefinition.ReadWrite.All'
Get-EntraAttributeSet 
```

```Output
Id                    Description                           MaxAttributesPerSet
--                    -----------                           -------------------
Engineering           Attributes for cloud engineering team 25
Contoso                 Attributes for Contoso            25
```

This example returns all attribute sets.

### Example 2: Get an attribute sets

```powershell
Connect-Entra -Scopes 'CustomSecAttributeDefinition.ReadWrite.All'
Get-EntraAttributeSet -AttributeSetId 'Testing'
```

```Output
Id      Description                     MaxAttributesPerSet
--      -----------                     -------------------
Testing Attributes for engineering team 10
```

This example demonstrates how to retrieve an attribute set by Id.

- `AttributeSetId` parameter specifies the unique identifier for the attribute set within a tenant.

## Parameters

### -AttributeSetId

Unique identifier for the attribute set within a tenant. 

This identifier can be up to 32 characters long and may include Unicode characters. It cannot contain spaces or special characters, and it cannot be changed later. The identifier is case insensitive.

```yaml
Type: System.String
Parameter Sets: GetById
Aliases: Id

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

## Inputs

### System.String

## Outputs

### System.Object

## Notes

## Related links

[New-EntraAttributeSet](New-EntraAttributeSet.md)

[Set-EntraAttributeSet](Set-EntraAttributeSet.md)
