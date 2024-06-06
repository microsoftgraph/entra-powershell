---
title: New-EntraMSAttributeSet
description: This article provides details on the New-EntraMSAttributeSet command.

ms.service: active-directory
ms.topic: reference
ms.date: 03/04/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# New-EntraMSAttributeSet

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

## EXAMPLES

### Example: Add a single attribute set.
```powershell
New-AzureADMSAttributeSet -Id 'Demo' -Description 'Attributes for engineering team' -MaxAttributesPerSet 10
```
```output
Name                           Value
----                           -----
@odata.context                 https://graph.microsoft.com/v1.0/$metadata#directory/attributeSets/$entity
id                             Demo
description                    Attributes for engineering team
maxAttributesPerSet            10
```

This example adds a single attribute set.

- Attribute set: `Demo`

## PARAMETERS

### -Description
Description for the attribute set.

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
Name of the attribute set. Must be unique within a tenant.

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
