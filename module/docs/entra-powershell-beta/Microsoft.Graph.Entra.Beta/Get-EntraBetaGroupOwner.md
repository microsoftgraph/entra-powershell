---
title: Get-EntraBetaGroupOwner.
description: This article provides details on the Get-EntraBetaGroupOwner command.

ms.service: active-directory
ms.topic: reference
ms.date: 03/20/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Get-EntraBetaGroupOwner

## SYNOPSIS
Gets an owner of a group.

## SYNTAX

```powershell
Get-EntraBetaGroupOwner 
 -ObjectId <String> 
 [-All] 
 [-Top <Int32>] 
 [<CommonParameters>]
```

## DESCRIPTION
The Get-EntraBetaGroupOwner cmdlet gets an owner of a group in Microsoft Entra ID.

## EXAMPLES

### Example 1: Get a group owner by ID
```powershell
PS C:\> Get-EntraBetaGroupOwner -ObjectId "ba828166-dcd3-4349-aee9-9fbbf619105d"
```
```output
Id                                   DeletedDateTime
--                                   ---------------
996d39aa-fdac-4d97-aa3d-c81fb47362ac
```
This example demonstrates how to retrieve the owner of a specific group.  

### Example 2: Gets all group owners
```powershell
PS C:\>Get-EntraBetaGroupOwner -ObjectId "c072b115-ed7b-47cb-90d3-d5019d8bfd51" -All
```
```output
Id                                   DeletedDateTime
--                                   ---------------
996d39aa-fdac-4d97-aa3d-c81fb47362ac
ea53750f-e28a-4645-b174-89618edd034a
2ae2d97b-4bde-42aa-b7c0-7c91a4c91a77
```
This example demonstrates how to retrieve the all owner of a specific group.  

### Example 3: Gets two group owners
```powershell
PS C:\>Get-EntraBetaGroupOwner -ObjectId "c072b115-ed7b-47cb-90d3-d5019d8bfd51" -Top 2
```
```output
Id                                   DeletedDateTime
--                                   ---------------
996d39aa-fdac-4d97-aa3d-c81fb47362ac
ea53750f-e28a-4645-b174-89618edd034a
```
This example demonstrates how to retrieve the top two owners of a specific group. 

## PARAMETERS

### -All
List all pages.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -ObjectId
Specifies the ID of a group in Microsoft Entra ID.

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Add-EntraBetaGroupOwner](Add-EntraBetaGroupOwner.md)

[Remove-EntraBetaGroupOwner](Remove-EntraBetaGroupOwner.md)