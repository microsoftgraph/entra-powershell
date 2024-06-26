---
title: Set-EntraUserThumbnailPhoto.
description: This article provides details on the Set-EntraUserThumbnailPhoto command.

ms.service: entra
ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Set-EntraUserThumbnailPhoto

## Synopsis
set the thumbnail photo for a user.

## Syntax

### File (Default)
```powershell
Set-EntraUserThumbnailPhoto 
 [-ObjectId <String>] 
 -FilePath <String> 
 [<CommonParameters>]
```

### Stream
```powershell
Set-EntraUserThumbnailPhoto 
 -FileStream <Stream> 
 [-ObjectId <String>] 
 [<CommonParameters>]
```

### ByteArray
```powershell
Set-EntraUserThumbnailPhoto 
 [-ObjectId <String>] 
 -ImageByteArray <Byte[]> 
 [<CommonParameters>]
```

## Description
this cmdlet is used to set the thumbnail photo for a user.

## Examples

### Example 1: Sets the thumbnail photo.

```powershell
PS C:\WINDOWS\system32> Set-EntraUserThumbnailPhoto -ObjectId ba6752c4-6a2e-4be5-a23d-67d8d5980796 -FilePath D:\UserThumbnailPhoto.jpg
```

This example sets the thumbnail photo of the user specified with the ObjectId parameter to the image specified with the FilePath parameter.

## Parameters

### -FilePath
The file path of the image to be uploaded as the user thumbnail photo.

```yaml
Type: String
Parameter Sets: File
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -ObjectId
The Object ID of the user for which the user thumbnail photo is set.

```yaml
Type: String
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

## Inputs

### System.String
System.IO.Stream System.Byte\[\]

## Outputs

### System.Object
## Notes

## Related Links

[Get-EntraUserThumbnailPhoto](Get-EntraUserThumbnailPhoto.md)