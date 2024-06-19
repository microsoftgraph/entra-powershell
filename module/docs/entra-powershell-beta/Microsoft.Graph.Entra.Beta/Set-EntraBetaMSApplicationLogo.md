---
title: Set-EntraBetaMSApplicationLogo
description: This article provides details on the Set-EntraBetaMSApplicationLogo command.

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

# Set-EntraBetaMSApplicationLogo

## SYNOPSIS

Sets the logo for an application object.

## SYNTAX

```powershell
Set-EntraBetaMSApplicationLogo 
 -ObjectId <String> 
 -Content <Byte[]> 
 [<CommonParameters>]
```

## DESCRIPTION

Sets the logo for an application object. Specify the `ObjectId` and `Content` parameters to set a specific application logo.

## EXAMPLES

### Example 1: Sets the logo of the application

```powershell
$logoPath = 'D:\applogo.jpg'
$logoBytes = [System.IO.File]::ReadAllBytes($logoPath)
Set-EntraBetaMSApplicationLogo -ObjectId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb' -Content $logoBytes
```

This command updates the application logo.

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

### -Content

An ImageByteArray that is to be used as the application logo.

```yaml
Type: System.Byte[]
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

### String

### Byte[]

## OUTPUTS

## NOTES

## RELATED LINKS
