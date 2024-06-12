---
title: Remove-EntraBetaApplication
description: This article provides details on the Remove-EntraBetaApplication command.

ms.service: active-directory
ms.topic: reference
ms.date: 06/04/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Remove-EntraBetaApplication

## SYNOPSIS

Delete an application by ObjectId.

## SYNTAX

```powershell
Remove-EntraBetaApplication 
    -ObjectId <String>
 [<CommonParameters>]
```

## DESCRIPTION

The `Remove-EntraBetaApplication` cmdlet removes the specified application from Microsoft Entra ID.

## EXAMPLES

### Example 1: Remove an application

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All'
Remove-EntraBetaApplication -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
```

This command removes the specified application.

## PARAMETERS

### -ObjectId

Specifies the ID of an application in Microsoft Entra ID.

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

[Get-EntraBetaApplication](Get-EntraBetaApplication.md)

[New-EntraBetaApplication](New-EntraBetaApplication.md)

[Set-EntraBetaApplication](Set-EntraBetaApplication.md)
