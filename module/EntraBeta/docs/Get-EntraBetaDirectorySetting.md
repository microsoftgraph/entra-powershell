---
title: Get-EntraBetaDirectorySetting.
description: This article provides details on the Get-EntraBetaDirectorySetting command.

ms.service: active-directory
ms.topic: reference
ms.date: 11/10/2023
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Get-EntraBetaDirectorySetting

## SYNOPSIS
Gets a directory setting.

## SYNTAX

### GetQuery (Default)
```
Get-EntraBetaDirectorySetting 
 [-All <Boolean>] 
 [-Top <Int32>] 
 [<CommonParameters>]
```

### GetById
```
Get-EntraBetaDirectorySetting 
-Id <String> 
[-All <Boolean>] 
[<CommonParameters>]
```

## DESCRIPTION
The Get-EntraBetaDirectorySetting cmdlet gets a directory setting from Microsoft Entra ID.

## EXAMPLES

### Example 1: Gets directory setting by ID
```
PS C:\> Get-EntraBetaDirectorySetting -Id a658c48f-fd66-498d-8199-27ed3d33c7c3

Id                                   DisplayName TemplateId
--                                   ----------- ----------
a658c48f-fd66-498d-8199-27ed3d33c7c3 Application 4bc7f740-180e-4586-adb6-38b2e9024e6b
```

This command gets the directory setting for specified Id.


### Example 2: Gets all directory settings
```
PS C:\> Get-EntraBetaDirectorySetting -All $true

```

This command gets the all directory settings.

### Example 3: Gets five directory settings
```
PS C:\> Get-EntraBetaDirectorySetting -Top 5
```

This command gets the top five directory settings.


## PARAMETERS

### -All
If true, return all directory settings.
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

### -Id
Specifies the ID of a directory in Microsoft Entra ID.

```yaml
Type: String
Parameter Sets: GetById
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
Parameter Sets: GetQuery
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

[New-EntraBetaDirectorySetting]()

[Remove-EntraBetaDirectorySetting]()

[Set-EntraBetaDirectorySetting]()

