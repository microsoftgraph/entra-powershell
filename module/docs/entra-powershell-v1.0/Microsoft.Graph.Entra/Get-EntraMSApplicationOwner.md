---
title: Get-EntraMSApplicationOwner
description: This article provides details on the Get-EntraMSApplicationOwner command.

ms.service: active-directory
ms.topic: reference
ms.date: 03/14/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraMSApplicationOwner

## SYNOPSIS
Retrieves the list of owners for an application object.

## SYNTAX

```powershell
Get-EntraMSApplicationOwner 
    -ObjectId <String> 
    [-All <Boolean>] 
    [-Top <Int32>] 
 [<CommonParameters>]
```

## DESCRIPTION
Retrieves the list of owners for an application object.

## EXAMPLES

### Example 1: Get the owners of an application.
```powershell
PS C:\>Get-EntraMSApplicationOwner -ObjectId "3ddd22e7-a150-4bb3-b100-e410dea1cb84"
```

```output
Id                                   DeletedDateTime
--                                   ---------------
412be9d1-1460-4061-8eed-cca203fcb215
abd3d0d8-62c9-47ea-932e-f80d413c7808
cbf777a2-1ed5-4ea5-80bf-aad80d0a384e
```

This command gets the owner of an application.  

### Example 2: Get the owners of an application using all parameter.
```powershell
PS C:\>Get-EntraMSApplicationOwner -ObjectId "3ddd22e7-a150-4bb3-b100-e410dea1cb84" -All $true
```

```output
Id                                   DeletedDateTime
--                                   ---------------
412be9d1-1460-4061-8eed-cca203fcb215
abd3d0d8-62c9-47ea-932e-f80d413c7808
cbf777a2-1ed5-4ea5-80bf-aad80d0a384e
```

This command gets the owner of an application using all parameter.  

### Example 3: Get top two owners of an application.
```powershell
PS C:\>Get-EntraMSApplicationOwner -ObjectId "3ddd22e7-a150-4bb3-b100-e410dea1cb84" -Top 2
```

```output
Id                                   DeletedDateTime
--                                   ---------------
412be9d1-1460-4061-8eed-cca203fcb215
abd3d0d8-62c9-47ea-932e-f80d413c7808
```

This command gets top two owners of an application.  

## PARAMETERS

### -ObjectId
Specifies the ID of an application in Microsoft Entra ID.

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

### -All
If true, return all owners.
If false, return the number of objects specified by the Top parameter.

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

### -Top
Specifies the maximum number of records to return.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### Bool?
### Int?
### String
## OUTPUTS

### Microsoft.Open.MSGraph.Model.GetDirectoryObjectsResponse
## NOTES

## RELATED LINKS

[Add-EntraMSApplicationOwner](Add-EntraMSApplicationOwner.md)

[Remove-EntraMSApplicationOwner](Remove-EntraMSApplicationOwner.md)
