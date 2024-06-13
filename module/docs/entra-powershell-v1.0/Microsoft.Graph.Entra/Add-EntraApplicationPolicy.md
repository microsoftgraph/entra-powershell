---
title: Add-EntraApplicationPolicy.
description: This article provides details on the Add-EntraApplicationPolicy command.
ms.service: entra
ms.topic: reference
ms.date: 06/13/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Add-EntraApplicationPolicy

## SYNOPSIS

**The Add-EntraApplicationPolicy cmdlet is not available at this time**.

## SYNTAX

```powershell
Add-EntraApplicationPolicy 
 -Id <String> 
 -RefObjectId <String> 
 [<CommonParameters>]
```

## DESCRIPTION

The Add-EntraApplicationPolicy  cmdlet adds an Microsoft Entra ID application policy.

## EXAMPLES

### Example 1: Add an application policy

```powershell
Connect-Entra -Scopes
Add-EntraApplicationPolicy -ObjectId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb' -RefObjectId '1aaaaaa1-2bb2-3cc3-4dd4-5eeeeeeeeee5'
```

This command adds an application policy.

## PARAMETERS

### -RefObjectId

Specifies the ID of the policy.

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

### -Id

The ID of the application for which you need to set the policy

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

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraApplicationPolicy](Get-EntraApplicationPolicy.md)

[Remove-EntraApplicationPolicy](Remove-EntraApplicationPolicy.md)
