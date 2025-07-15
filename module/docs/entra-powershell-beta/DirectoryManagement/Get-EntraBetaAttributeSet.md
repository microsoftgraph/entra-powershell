---
author: msewaweru
description: This article provides details on the Get-EntraBetaAttributeSet command.
external help file: Microsoft.Entra.Beta.DirectoryManagement-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 07/10/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Get-EntraBetaAttributeSet
schema: 2.0.0
title: Get-EntraBetaAttributeSet
---

# Get-EntraBetaAttributeSet

## SYNOPSIS

Gets a list of attribute sets.

## SYNTAX

### GetQuery (Default)

```powershell
Get-EntraBetaAttributeSet
 [-Property <String[]>]
 [<CommonParameters>]
```

### GetById

```powershell
Get-EntraBetaAttributeSet
 -AttributeSetId <String>
 [<CommonParameters>]
```

## DESCRIPTION

The `Get-EntraABetaAttributeSet` cmdlet gets a list of Microsoft Entra ID attribute sets.

In delegated scenarios with work or school accounts, the signed-in user must have a supported Microsoft Entra role or a custom role with the necessary permissions. The supported roles for this operation are:

- Attribute Assignment Reader
- Attribute Definition Reader
- Attribute Assignment Administrator
- Attribute Definition Administrator

By default, other administrator roles cannot read, define, or assign custom security attributes.

## EXAMPLES

### Example 1: Get an all attribute sets

```powershell
Connect-Entra -Scopes 'CustomSecAttributeDefinition.ReadWrite.All'
Get-EntraBetaAttributeSet 
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
Get-EntraBetaAttributeSet -AttributeSetId 'Testing'
```

```Output
Id      Description                     MaxAttributesPerSet
--      -----------                     -------------------
Testing Attributes for engineering team 10
```

This example demonstrates how to retrieve an attribute set by Id.

- `-AttributeSetId` parameter specifies the unique identifier for the attribute set within a tenant.

## PARAMETERS

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

## INPUTS

### System.String

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS

[New-EntraBetaAttributeSet](New-EntraBetaAttributeSet.md)

[Set-EntraBetaAttributeSet](Set-EntraBetaAttributeSet.md)
