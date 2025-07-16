---
author: msewaweru
description: This article provides details on the Get-EntraBetaUserThumbnailPhoto command.
external help file: Microsoft.Entra.Beta.Users-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 07/23/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Get-EntraBetaUserThumbnailPhoto
schema: 2.0.0
title: Get-EntraBetaUserThumbnailPhoto
---

# Get-EntraBetaUserThumbnailPhoto

## SYNOPSIS

Retrieve the thumbnail photo of a user.

## SYNTAX

```powershell
Get-EntraBetaUserThumbnailPhoto
 -UserId <String>
 [-FileName <String>]
 [-FilePath <String>]
 [-View <Boolean>]
 [-Property <String[]>]
 [<CommonParameters>]
```

## DESCRIPTION

Retrieve the thumbnail photo of a user.

## EXAMPLES

### Example 1: Retrieve thumbnail photo by Id

```powershell
Connect-Entra -Scopes 'User.Read','User.Read.All'
Get-EntraBetaUserThumbnailPhoto -UserId 'SawyerM@contoso.com'
```

```Output
Id      Height Width
--      ------ -----
default 292    278
```

This example shows how to retrieve the thumbnail photo of a user that is specified through the value of the UserId parameter.

- `-UserId` parameter specifies the user for which the thumbnail photo is retrieved.

## PARAMETERS

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

## INPUTS

### System.String

System.Boolean

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS

[Set-EntraBetaUserThumbnailPhoto](Set-EntraBetaUserThumbnailPhoto.md)
