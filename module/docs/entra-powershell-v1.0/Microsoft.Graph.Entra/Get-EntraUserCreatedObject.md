---
title:  Get-EntraUserCreatedObject.
description: This article provides details on the  Get-EntraUserCreatedObject Command.

ms.service: entra
ms.subservice: powershell
ms.topic: reference
ms.date: 03/27/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraUserCreatedObject

## SYNOPSIS
Get objects created by the user.

## SYNTAX

```powershell
Get-EntraUserCreatedObject 
 -ObjectId <String> 
 [-All <Boolean>] 
 [-Top <Int32>] 
 [<CommonParameters>]
```

## DESCRIPTION
The Get-EntraUserCreatedObject cmdlet gets objects created by a user in Microsoft Entra ID.

## EXAMPLES

### Example 1: Get a user-created object
```powershell
PS C:\>Get-EntraUserCreatedObject -ObjectId "412be9d1-1460-4061-8eed-cca203fcb215"
```
```output
Id                                   DeletedDateTime
--                                   ---------------
c057711d-e0a2-40a1-b8af-06d96c20c875
4773e0f6-b400-40b3-8508-340de8ee0893
e3108c4d-86ff-4ceb-9429-24e85b4b8cea
abd3d0d8-62c9-47ea-932e-f80d413c7808
```
This command gets an object created by the specified user.

### Example 2: Get a top one user-created object
```powershell
PS C:\>Get-EntraUserCreatedObject -ObjectId "412be9d1-1460-4061-8eed-cca203fcb215" -Top 1
```
```output
Id                                   DeletedDateTime
--                                   ---------------
c057711d-e0a2-40a1-b8af-06d96c20c875
```
This command gets top one object created by the specified user.

## PARAMETERS

### -All
If true, return all objects created by this user.
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

### -ObjectId
Specifies the ID (as a UPN or ObjectId) of a user in Microsoft Entra ID.

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
