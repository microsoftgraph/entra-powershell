---
title: Set-EntraAttributeSet
description: This article provides details on the Set-EntraAttributeSet command.

ms.topic: reference
ms.date: 07/19/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Set-EntraAttributeSet

## SYNOPSIS

Updates an existing attribute set.

## SYNTAX

```powershell
Set-EntraAttributeSet 
 -Id <String> 
 [-Description <String>] 
 [-MaxAttributesPerSet <Int32>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Set-EntraAttributeSet` cmdlet update a Microsoft Entra ID attribute set object identified by ID. Specify `Id` parameter to Update a Microsoft Entra ID attribute set object.

## EXAMPLES

### Example 1: Update an attribute set

```powershell
Connect-Entra -Scopes 'CustomSecAttributeDefinition.ReadWrite.All'
$params = @{
    Id = 'Engineering'
    Description = 'Attributes for cloud engineering team'
}
Set-EntraAttributeSet @params
```

This example Update an attribute set.

- Attribute set: `Engineering`

### Example 2: Update an attribute set using MaxAttributesPerSet

```powershell
Connect-Entra -Scopes 'CustomSecAttributeDefinition.ReadWrite.All'
$params = @{
    Id = 'Engineering' 
    MaxAttributesPerSet = 10    
}
Set-EntraAttributeSet @params
```

This example Update an attribute set using MaxAttributesPerSet

- Attribute set: `Engineering`

## PARAMETERS

### -Description

Description of the attribute set.

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

Name of the attribute set.

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

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS

[New-EntraAttributeSet](New-EntraAttributeSet.md)

[Get-EntraAttributeSet](Get-EntraAttributeSet.md)
