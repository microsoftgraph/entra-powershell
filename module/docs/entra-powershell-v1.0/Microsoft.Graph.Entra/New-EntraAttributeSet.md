---
title: New-EntraAttributeSet
description: This article provides details on the New-EntraAttributeSet command.

ms.service: active-directory
ms.topic: reference
ms.date: 07/20/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# New-EntraAttributeSet

## SYNOPSIS

Adds a new attribute set.

## SYNTAX

```powershell
New-AzureADMSAttributeSet 
 [-Id <String>] 
 [-Description <String>] 
 [-MaxAttributesPerSet <Int32>]
 [<CommonParameters>]
```

## DESCRIPTION

Adds a new Microsoft Entra ID attribute set object.

In delegated scenarios with work or school accounts, the signed-in user must be assigned a supported Microsoft Entra role or a custom role with a supported role permission.

Only the Attribute Definition Administrator role is supported for this operation. Ensure the user is assigned this role.

By default, Global Administrator and other administrator roles can't read, define, or assign custom security attributes.

## EXAMPLES

### Example: Add a single attribute set.
```powershell
Connect-Entra -Scopes 'CustomSecAttributeDefinition.ReadWrite.All'
$params = @{
    Id = 'NewCustomAttributeSet'
    Description = 'Attributes for engineering team'
    MaxAttributesPerSet = 10
}

New-EntraAttributeSet @params
```
```Output
Id                     Description                    MaxAttributesPerSet
--                     -----------                    -------------------
NewCustomAttributeSet Attributes for engineering team 10
```

This example adds a single attribute set.

- Attribute set: `Demo`

## PARAMETERS

### -Description
Description of the attribute set, up to 128 Unicode characters. This can be changed later.

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

### -Id
Name of the attribute set. Unique identifier for the attribute set within a tenant, up to 32 Unicode characters. It cannot contain spaces or special characters, is case sensitive, and cannot be changed later. Required.

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

### -MaxAttributesPerSet
Maximum number of custom security attributes that can be defined in the attribute set.

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
