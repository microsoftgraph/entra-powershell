---
title: Get-EntraBetaPrivateAccessApplicationSegment
description: This article provides details on the Get-EntraBetaPrivateAccessApplicationSegment command.

ms.topic: reference
ms.date: 06/26/2024
ms.author: andres-canello
ms.reviewer: stevemutungi
manager: CelesteDG
author: andres-canello
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Get-EntraBetaPrivateAccessApplicationSegment

## Synopsis
The Get-EntraBetaPrivateAccessApplicationSegment cmdlet a list of all application segments associated to a Private Access application, or if specified, details of a specific application segment.

## Description
The Get-EntraBetaPrivateAccessApplicationSegment cmdlet a list of all application segments associated to a Private Access application, or if specified, details of a specific application segment.

## Examples

### Example 1: Retrieve all application segments associated to an application
```powershell
PS C:\> Get-EntraBetaPrivateAccessApplicationSegment -Objectid b97db9dd-85c7-4365-ac05-bd824728ab83
```
```output
destinationHost : 10.1.1.20
destinationType : ip
port            : 0
ports           : {22-22}
protocol        : tcp
id              : 89a0ff5a-0440-4411-8f1c-d4e0be0635c8

destinationHost : 10.20.20.20
destinationType : ip
port            : 0
ports           : {8080-8080}
protocol        : tcp
id              : 47da55f4-26b1-47ab-a34c-20a86a5e22a7
```

This command retrieves all application segments for an application.

### Example 2: Retrieve a specific application segment associated to an application
```powershell
PS C:\> Get-EntraBetaPrivateAccessApplicationSegment b97db9dd-85c7-4365-ac05-bd824728ab83 -ApplicationSegmentId 89a0ff5a-0440-4411-8f1c-d4e0be0635c8
```
```output
destinationHost : 10.1.1.20
destinationType : ip
port            : 0
ports           : {22-22}
protocol        : tcp
id              : 89a0ff5a-0440-4411-8f1c-d4e0be0635c8
```

This example demonstrates how to retrieve information for a specific application segment.

## Parameters

### -Objectid
The object id of a Private Access application object.

```yaml
Type: String
Parameter Sets: AllApplicationSegments, SingleApplicationSegment
Aliases: id

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ApplicationSegmentId
Specifies a specific application segment to retrieve.

```yaml
Type: String
Parameter Sets: SingleApplicationSegment
Aliases:

Required: False
Position: 2, Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

### System.String
System.Nullable\`1\[\[System. Boolean, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089\]\] System.Nullable\`1\[\[System.Int32, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089\]\]

## Outputs

### System.Object
## Notes

## RELATED LINKS