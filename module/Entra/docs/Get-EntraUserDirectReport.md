---
title: Get-EntraUserDirectReport.
description: This article provides details on the Get-EntraUserDirectReport command.

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

# Get-EntraUserDirectReport

## SYNOPSIS
Get the user's direct reports.

## SYNTAX

```
Get-EntraUserDirectReport 
   -ObjectId <String> 
   [-All <Boolean>] 
   [-Top <Int32>] 
   [<CommonParameters>]
```

## DESCRIPTION
The Get-EntraUserDirectReport cmdlet gets the direct reports for a user in Microsoft Entra ID.

## EXAMPLES

### Example 1: Get a user's direct reports
```
PS C:\> Get-EntraUserDirectReport -ObjectId "df19e8e6-2ad7-453e-87f5-037f6529ae16"
```

This command gets the direct report for the specified user.

### Example 2: Get a all direct reports
```
PS C:\> Get-EntraUserDirectReport -ObjectId "c300541f-2c03-49cb-b25b-72f09cb29abf" -All $true
```

This command gets the all direct report for the specified user.

### Example 3: Get a top five direct reports
```
PS C:\> Get-EntraUserDirectReport -ObjectId "c300541f-2c03-49cb-b25b-72f09cb29abf" -Top 5
```

This command gets the five direct report for the specified user.

## PARAMETERS

### -All
If true, return all direct reports for this user.
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
Specifies the ID of a user in Microsoft Entra ID (UPN or ObjectId)

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
