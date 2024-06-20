---
title: Remove-EntraBetaMSApplication.
description: This article provides details on the Remove-EntraBetaMSApplication command.

ms.service: entra
ms.topic: reference
ms.date: 06/19/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Remove-EntraBetaMSApplication

## SYNOPSIS

Deletes an application object.

## SYNTAX

```powershell
Remove-EntraBetaMSApplication 
 -ObjectId <String> 
 [<CommonParameters>]
```

## DESCRIPTION

The `Remove-EntraBetaMSApplication` cmdlet deletes an application object identified by ObjectId. Specify the `ObjectId` parameter to delete an application object.

## EXAMPLES

### Example 1: Remove an application

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All'
Remove-EntraBetaMSApplication -ObjectId 'hhhhhhhh-3333-5555-3333-qqqqqqqqqqqq'
```

This example demonstrates how to delete an application object.

## PARAMETERS

### -ObjectId

The unique identifier of the object specific Microsoft Entra ID object.

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

### System.String

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraBetaMSApplication](Get-EntraBetaMSApplication.md)

[New-EntraBetaMSApplication](New-EntraBetaMSApplication.md)

[Set-EntraBetaMSApplication](Set-EntraBetaMSApplication.md)

