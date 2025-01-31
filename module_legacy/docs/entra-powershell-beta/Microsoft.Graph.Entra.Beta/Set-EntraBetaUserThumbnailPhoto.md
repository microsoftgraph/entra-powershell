---
title: Set-EntraBetaUserThumbnailPhoto
description: This article provides details on the Set-EntraBetaUserThumbnailPhoto command.

ms.topic: reference
ms.date: 07/24/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Set-EntraBetaUserThumbnailPhoto

schema: 2.0.0
---

# Set-EntraBetaUserThumbnailPhoto

## Synopsis

Set the thumbnail photo for a user.

## Syntax

### File (Default)

```powershell
Set-EntraBetaUserThumbnailPhoto
 -FilePath <String>
 [-UserId <String>]
 [<CommonParameters>]
```

### ByteArray

```powershell
Set-EntraBetaUserThumbnailPhoto
 -ImageByteArray <Byte[]>
 [-UserId <String>]
 [<CommonParameters>]
```

### Stream

```powershell
Set-EntraBetaUserThumbnailPhoto
 -FileStream <Stream>
 [-UserId <String>]
 [<CommonParameters>]
```

## Description

The `Set-EntraBetaUserThumbnailPhoto` cmdlet is used to set the thumbnail photo for a user.

Updating any user's photo in the organization requires the User.ReadWrite.All permission. Updating only the signed-in user's photo requires the User.ReadWrite permission.

## Examples

### Example 1: Sets the thumbnail photo

```powershell
Connect-Entra -Scopes 'User.ReadWrite','User.ReadWrite.All'
Set-EntraBetaUserThumbnailPhoto -UserId -FilePath 'D:\UserThumbnailPhoto.jpg'
```

This example sets the thumbnail photo of the user specified with the UserId parameter to the image specified with the FilePath parameter.

- `-UserId` parameter specifies the ID of a user in Microsoft Entra ID.
- `-FilePath` parameter specifies the file path of the image to be uploaded as the user thumbnail photo.

## Parameters

### -FilePath

The file path of the image to be uploaded as the user thumbnail photo.

```yaml
Type: System.String
Parameter Sets: File
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -FileStream

A filestream that contains the user thumbnail photo.

```yaml
Type: System.Stream
Parameter Sets: Stream
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -ImageByteArray

An Image Byte Array that contains the user thumbnail photo.

```yaml
Type: System.Byte[]
Parameter Sets: ByteArray
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -UserId

The Object ID of the user for which the user thumbnail photo is set.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: ObjectId

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

System.IO.Stream System.Byte\[\]

## Outputs

### System.Object

## Notes

## Related Links

[Get-EntraBetaUserThumbnailPhoto](Get-EntraBetaUserThumbnailPhoto.md)
