---
title: Remove-EntraBetaPrivateAccessApplicationSegment
description: This article provides details on the Remove-EntraBetaPrivateAccessApplicationSegment command.

ms.topic: reference
ms.date: 07/18/2024
ms.author: andresc
ms.reviewer: stevemutungi
manager: CelesteDG
author: andres-canello
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Remove-EntraBetaPrivateAccessApplicationSegment

## Synopsis

The Remove-EntraBetaPrivateAccessApplicationSegment cmdlet deletes an application segments associated to a Private Access application.

## Description

The Remove-EntraBetaPrivateAccessApplicationSegment cmdlet deletes an application segments associated to a Private Access application.

## Examples

### Example 1: Delete an application segment

```powershell
Remove-EntraBetaPrivateAccessApplicationSegment -ObjectId b97db9dd-85c7-4365-ac05-bd824728ab83 -ApplicationSegmentId 89a0ff5a-0440-4411-8f1c-d4e0be0635c8
```

## Parameters

### -ObjectId

The object id of a Private Access application object.

```yaml
Type: String
Parameter Sets: 
Aliases: id

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ApplicationSegmentId

The application segment id of the application segment to be deleted.

```yaml
Type: String
Parameter Sets: 
Aliases: 

Required: True
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