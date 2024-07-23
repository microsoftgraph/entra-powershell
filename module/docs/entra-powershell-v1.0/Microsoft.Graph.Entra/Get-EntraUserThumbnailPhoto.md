---
title: Get-EntraUserThumbnailPhoto.
description: This article provides details on the Get-EntraUserThumbnailPhoto command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/en-us/powershell/module/Microsoft.Graph.Entra/Get-EntraUserThumbnailPhoto

schema: 2.0.0
---

# Get-EntraUserThumbnailPhoto

## Synopsis

Retrieve the thumbnail photo of a user.

## Syntax

```powershell
Get-EntraUserThumbnailPhoto
 -ObjectId <String>
 [-FileName <String>]
 [-View <Boolean>]
 [-FilePath <String>]
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

Retrieve the thumbnail photo of a user.

## Examples

### Example 1: Retrieve thumbnail photo by Id

```powershell
Connect-Entra -Scopes 'User.Read' #Delegated Permission
Connect-Entra -Scopes 'User.Read.All' #Application Permission
Get-EntraUserThumbnailPhoto -ObjectId '00aa00aa-bb11-cc22-dd33-44ee44ee44ee'
```

```Output
Id      Height Width
--      ------ -----
default 292    278
```

This example demonstrates how to retrieve the thumbnail photo of a specified user.

## Parameters

### -FileName

If specified, a copy of the thumbnail photo is written to the specified file name.

```yaml
Type: System.String
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
Type: System.String
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
Type: System.String
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
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
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

## Related Links

[Set-EntraUserThumbnailPhoto](Set-EntraUserThumbnailPhoto.md)
