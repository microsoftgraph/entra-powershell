---
title: Get-EntraUserThumbnailPhoto.
description: This article provides details on the Get-EntraUserThumbnailPhoto command.

ms.service: active-directory
ms.topic: reference
ms.date: 03/13/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraUserThumbnailPhoto

## SYNOPSIS
Retrieve the thumbnail photo of a user.

## SYNTAX

```
Get-EntraUserThumbnailPhoto 
 -ObjectId <String> 
 [-FileName <String>] 
 [-View <Boolean>] 
 [-FilePath <String>]
 [<CommonParameters>]
```

## DESCRIPTION
Retrieve the thumbnail photo of a user.

## EXAMPLES

### Example 1: Retrieve thumbnail photo by Id
```powershell
PS C:\WINDOWS\system32> Get-EntraUserThumbnailPhoto -ObjectId df19e8e6-2ad7-453e-87f5-037f6529ae16
```

This example demonstrates how to retrieve the thumbnail photo of a user that is specified through the value of the ObejctId parameter.

## PARAMETERS

### -FileName
If specified, a copy of the thumbnail photo is written to the specified file name.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -FilePath
If specified, a copy of the thumbnail photo is written to the specified file path with a random name.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -ObjectId
The object ID of the user for which the thumbnail photo is retrieved.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -View
If true, view the photo on the screen in a new window.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String
System.Boolean

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS

[Set-EntraUserThumbnailPhoto](Set-EntraUserThumbnailPhoto.md)