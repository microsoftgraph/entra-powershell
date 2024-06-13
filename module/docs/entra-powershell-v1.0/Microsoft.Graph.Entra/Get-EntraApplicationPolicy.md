---
title: Get-EnterApplicationPolicy.
description: This article provides details on the Get-EnterApplicationPolicy command.
ms.service: entra
ms.topic: reference
ms.date: 06/12/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EnterApplicationPolicy

## SYNOPSIS

Gets an application policy.

## SYNTAX

```powershell
Get-EnterApplicationPolicy
 -Id <String> 
 [<CommonParameters>]
```

## DESCRIPTION

The Get-EnterApplicationPolicy cmdlet gets an Microsoft Entra ID application policy. Specify `Id` parameter to get an application policy.

## EXAMPLES

### Example 1: Get an application policy

```powershell
Connect-Entra -Scopes 'Policy.Read.All'
Get-EnterApplicationPolicy -Id 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'
```

This command gets the specified application policy.

## PARAMETERS

### -Id

The ID of the application for which you need to retrieve the policy

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

[Add-EntraApplicationPolicy](Add-EntraApplicationPolicy.md)

[Remove-EntraApplicationPolicy](Remove-EntraApplicationPolicy.md)
