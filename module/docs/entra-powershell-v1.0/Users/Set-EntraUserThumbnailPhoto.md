---
author: msewaweru
description: This article provides details on the Set-EntraUserThumbnailPhoto command.
external help file: Microsoft.Entra.Users-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra
ms.author: eunicewaweru
ms.date: 06/26/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Set-EntraUserThumbnailPhoto
schema: 2.0.0
title: Set-EntraUserThumbnailPhoto
---

# Set-EntraUserThumbnailPhoto

## Synopsis

Set the thumbnail photo for a user.

## Syntax

### File (Default)

```powershell
Set-EntraUserThumbnailPhoto
 -UserId <String>
 -FilePath <String>
 [<CommonParameters>]
```

### Stream

```powershell
Set-EntraUserThumbnailPhoto
 -FileStream <Stream>
 -UserId <String>
 [<CommonParameters>]
```

### ByteArray

```powershell
Set-EntraUserThumbnailPhoto
 -UserId <String>
 -ImageByteArray <Byte[]>
 [<CommonParameters>]
```

## Description

The `Set-EntraUserThumbnailPhoto` cmdlet is used to set the thumbnail photo for a user.

Updating any user's photo in the organization requires the `User.ReadWrite.All` permission. Updating only the signed-in user's photo requires the `User.ReadWrite` permission.

## Examples

### Example 1: Sets the thumbnail photo

```powershell
Connect-Entra -Scopes 'User.ReadWrite', 'User.ReadWrite.All'
Set-EntraUserThumbnailPhoto -UserId 'SawyerM@contoso.com' -FilePath 'D:\UserThumbnailPhoto.jpg'
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

## Inputs

### System.String

System.IO.Stream System.Byte\[\]

## Outputs

### System.Object

## Notes

## Related links

[Get-EntraUserThumbnailPhoto](Get-EntraUserThumbnailPhoto.md)
