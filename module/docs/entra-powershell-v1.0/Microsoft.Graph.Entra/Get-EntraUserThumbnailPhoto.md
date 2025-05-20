---
title: Get-EntraUserThumbnailPhoto
description: This article provides details on the Get-EntraUserThumbnailPhoto command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Get-EntraUserThumbnailPhoto

schema: 2.0.0
---

# Get-EntraUserThumbnailPhoto

## Synopsis

Retrieve the thumbnail photo of a user.

## Syntax

```powershell
Get-EntraUserThumbnailPhoto
 -UserId <String>
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

Retrieve the thumbnail photo of a user.

## Examples

### Example 1: Retrieve thumbnail photo by Id

```powershell
Connect-Entra -Scopes 'User.Read','User.Read.All'
Get-EntraUserThumbnailPhoto -UserId 'SawyerM@contoso.com'
```

```Output
Id      Height Width
--      ------ -----
default 292    278
```

This example shows how to retrieve the thumbnail photo of a user that is specified through the value of the UserId parameter.

- `-UserId` parameter specifies the user for which the thumbnail photo is retrieved.

## Parameters

### -UserId

The object ID of the user for which the thumbnail photo is retrieved.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: ObjectId

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
Aliases:

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

System.Boolean

## Outputs

### System.Object

## Notes

## Related links

[Set-EntraUserThumbnailPhoto](Set-EntraUserThumbnailPhoto.md)
