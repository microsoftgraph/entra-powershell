---
author: msewaweru
description: This article provides details on the Set-EntraBetaUserThumbnailPhoto command.
external help file: Microsoft.Entra.Beta.Users-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 07/24/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Set-EntraBetaUserThumbnailPhoto
schema: 2.0.0
title: Set-EntraBetaUserThumbnailPhoto
---

# Set-EntraBetaUserThumbnailPhoto

## SYNOPSIS

Set the thumbnail photo for a user.

## SYNTAX

### File (Default)

```powershell
Set-EntraBetaUserThumbnailPhoto
 -FilePath <String>
 -UserId <String>
 [<CommonParameters>]
```

### ByteArray

```powershell
Set-EntraBetaUserThumbnailPhoto
 -ImageByteArray <Byte[]>
 -UserId <String>
 [<CommonParameters>]
```

### Stream

```powershell
Set-EntraBetaUserThumbnailPhoto
 -FileStream <Stream>
 -UserId <String>
 [<CommonParameters>]
```

## DESCRIPTION

The `Set-EntraBetaUserThumbnailPhoto` cmdlet is used to set the thumbnail photo for a user.

Updating any user's photo in the organization requires the `User.ReadWrite.All` permission. Updating only the signed-in user's photo requires the `User.ReadWrite` permission.

## EXAMPLES

### Example 1: Sets the thumbnail photo

```powershell
Connect-Entra -Scopes 'User.ReadWrite', 'User.ReadWrite.All'
Set-EntraBetaUserThumbnailPhoto -UserId 'SawyerM@contoso.com' -FilePath 'D:\UserThumbnailPhoto.jpg'
```

This example sets the thumbnail photo of the user specified with the UserId parameter to the image specified with the FilePath parameter.

- `-UserId` parameter specifies the ID of a user in Microsoft Entra ID.
- `-FilePath` parameter specifies the file path of the image to be uploaded as the user thumbnail photo.

## PARAMETERS

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
Aliases: ObjectId, UPN, Identity, UserPrincipalName

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

System.IO.Stream System.Byte\[\]

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS

[Get-EntraBetaUserThumbnailPhoto](Get-EntraBetaUserThumbnailPhoto.md)
