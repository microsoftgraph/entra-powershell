---
title: Get-EntraExtensionProperty.
description: This article provides details on the Get-EntraExtensionProperty command.

ms.service: active-directory
ms.topic: reference
ms.date: 03/28/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraExtensionProperty

## SYNOPSIS
Gets extension properties registered with Microsoft Entra ID.

## SYNTAX

```
Get-EntraExtensionProperty 
[-IsSyncedFromOnPremises <Boolean>] 
[<CommonParameters>]
```

## DESCRIPTION
The Get-EntraExtensionProperty cmdlet gets a collection that contains the extension properties registered with Microsoft Entra ID through Microsoft Entra ID Connect. 
You can get extension properties that are synced with on-premises Microsoft Entra ID that aren't synced with on-premises Microsoft Entra ID or both types.

## EXAMPLES

### Example 1: Get extension properties synced from on-premises Microsoft Entra ID
```powershell
PS C:\> Get-EntraExtensionProperty -IsSyncedFromOnPremises $True
```
```output
ObjectId                             Name                                                          TargetObjects
--------                             ----                                                          -------------
b3c7b2c2-bb9a-4e30-a9fc-46adbe8c0899 extension_6e151e1a9cf44f8689a410023ac39235_weather            {User}
05af194f-1068-4539-83c9-06e03a1a1f44 extension_6e151e1a9cf44f8689a410023ac39235_extension_location {User}
9bf6f631-e6a6-41d1-b0a3-777f2acea2d1 extension_ed192e9284d44baf997d1e190a81f28e_extension_4A3UwDDC {User}
```

This command gets extension properties that have sync from on-premises Microsoft Entra ID.

## PARAMETERS

### -IsSyncedFromOnPremises
Specifies whether this cmdlet gets extension properties that are synced or not synced.
- $True.
Get extension properties that are synced from the on-premises Microsoft Entra ID.

- $False. Get extension properties that aren't synced from the on-premises Microsoft Entra ID.
- No value. Get all extension property's.

```yaml
Type: Boolean
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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
