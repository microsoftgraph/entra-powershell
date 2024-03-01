---
title: Get-EntraApplicationOwner.
description: This article provides details on the Get-EntraApplicationOwner command.

ms.service: active-directory
ms.topic: reference
ms.date: 11/10/2023
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraApplicationOwner

## SYNOPSIS
Gets the owner of an application.

## SYNTAX

```
Get-EntraApplicationOwner 
 -ObjectId <String> 
 [-All <Boolean>] 
 [-Top <Int32>] 
 [<CommonParameters>]
```

## DESCRIPTION
The Get-EntraApplicationOwner cmdlet get an owner of a Microsoft Entra ID application.

## EXAMPLES

### Example 1: Get the owner of an application
```
PS C:\>Get-EntraApplicationOwner -ObjectId "3ddd22e7-a150-4bb3-b100-e410dea1cb84"
```

This command gets the owners of an application.

### Example 2: Get all owners of an application
```
PS C:\>Get-EntraApplicationOwner -ObjectId "3ddd22e7-a150-4bb3-b100-e410dea1cb84" -All $true
```

This command gets the all owners of an specified application.

### Example 3: Get top two owners of an application
```
PS C:\>Get-EntraApplicationOwner -ObjectId "3ddd22e7-a150-4bb3-b100-e410dea1cb84" -Top 2
```

This command gets the two owners of an specified application.

## PARAMETERS

### -All
If true, return all owners.
If false, return the number of objects specified by the Top parameter

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

### -ObjectId
Specifes the ID of an application in Microsoft Entra ID.

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Add-EntraApplicationOwner]()

[Remove-EntraApplicationOwner]()

