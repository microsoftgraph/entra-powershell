---
title: Set-EntraUserThumbnailPhoto.
description: This article provides details on the Set-EntraUserThumbnailPhoto command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Set-EntraUserThumbnailPhoto

schema: 2.0.0
---

# Set-EntraUserThumbnailPhoto

## Synopsis

Set the thumbnail photo for a user.

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

This cmdlet is used to set the thumbnail photo for a user.

Updating any user's photo in the organization requires the User.ReadWrite.All permission. Updating only the signed-in user's photo requires the User.ReadWrite permission.

## Examples

### Example 1: Sets the thumbnail photo

```powershell
Connect-Entra -Scopes 'User.ReadWrite' #Delegated Permission
Connect-Entra -Scopes 'User.ReadWrite.All' #Application Permission
$params = @{
    ObjectId = 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'
    FilePath = 'D:\UserThumbnailPhoto.jpg'
}

Set-EntraUserThumbnailPhoto @params
```

This example sets the thumbnail photo of the user specified with the ObjectId parameter to the image specified with the FilePath parameter.

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

### -ObjectId

The Object ID of the user for which the user thumbnail photo is set.

```yaml
Type: System.String
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

System.IO.Stream System.Byte\[\]

## Outputs

### System.Object

## Notes

## Related Links

[Get-EntraUserThumbnailPhoto](Get-EntraUserThumbnailPhoto.md)
