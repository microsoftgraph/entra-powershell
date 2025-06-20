---
author: msewaweru
description: This article provides details on the Get-EntraUserThumbnailPhoto command.
external help file: Microsoft.Entra.Users-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra
ms.author: eunicewaweru
ms.date: 06/26/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Get-EntraUserThumbnailPhoto
schema: 2.0.0
title: Get-EntraUserThumbnailPhoto
---

# Get-EntraUserThumbnailPhoto

## Synopsis

Retrieve the thumbnail photo of a user.

## Syntax

```powershell
Get-EntraUserThumbnailPhoto
 -UserId <String>
 [-FileName <String>]
 [-FilePath <String>]
 [-View <Boolean>]
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
Aliases: ObjectId, UPN, Identity, UserPrincipalName

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
Aliases: Select

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FileName

Specifies the file name to save the retrieved thumbnail photo.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: None

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -FilePath

Specifies the file path or location where the thumbnail photo will be saved.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: None

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -View

Specifies whether to view the thumbnail photo immediately after retrieval.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases: None

Required: False
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName, ByValue)
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
