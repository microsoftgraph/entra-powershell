---
title: Get-EntraBetaPrivateAccessApplicationSegment
description: This article provides details on the Get-EntraBetaPrivateAccessApplicationSegment command.

ms.topic: reference
ms.date: 06/26/2024
ms.author: andresc
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

Retrieves a list of all application segments associated to a Private Access application, or if specified, details of a specific application segment.

## Description

The `Get-EntraBetaPrivateAccessApplicationSegment` cmdlet retrieves a list of all application segments associated to a Private Access application, or if specified, details of a specific application segment.

## Examples

### Example 1: Retrieve all application segments associated to an application

```powershell
Get-EntraBetaPrivateAccessApplicationSegment -ObjectId '00001111-aaaa-2222-bbbb-3333cccc4444'
```

```Output
destinationHost : 10.1.1.20
destinationType : ip
port            : 0
ports           : {22-22}
protocol        : tcp
id              : cccc2222-dd33-4444-55ee-666666ffffff

destinationHost : 10.20.20.20
destinationType : ip
port            : 0
ports           : {8080-8080}
protocol        : tcp
id              : cccc2222-dd33-4444-55ee-666666ffffff
```

This command retrieves all application segments for an application.

### Example 2: Retrieve a specific application segment associated to an application

```powershell
$params = @{
    ObjectId = '00001111-aaaa-2222-bbbb-3333cccc4444'
    ApplicationSegmentId = 'cccc2222-dd33-4444-55ee-666666ffffff'
}

Get-EntraBetaPrivateAccessApplicationSegment @params
```

```Output
destinationHost : 10.1.1.20
destinationType : ip
port            : 0
ports           : {22-22}
protocol        : tcp
id              : cccc2222-dd33-4444-55ee-666666ffffff
```

This example demonstrates how to retrieve information for a specific application segment.

## Parameters

### -ObjectId

The Object ID of a Private Access application object.

```yaml
Type: System.String
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
Type: System.String
Parameter Sets: SingleApplicationSegment
Aliases:

Required: False
Position: 2, Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

### System.String

System.Nullable\`1\[\[System. Boolean, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089\]\] System.Nullable\`1\[\[System.Int32, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089\]\]

## Outputs

### System.Object

## Notes

## RELATED LINKS
