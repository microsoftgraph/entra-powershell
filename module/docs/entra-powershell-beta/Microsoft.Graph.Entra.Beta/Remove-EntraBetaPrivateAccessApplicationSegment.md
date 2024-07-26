---
title: Remove-EntraBetaPrivateAccessApplicationSegment
description: This article provides details on the Remove-EntraBetaPrivateAccessApplicationSegment command.

ms.topic: reference
ms.date: 07/18/2024
ms.author: eunicewaweru
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

Removes an application segment associated to a Private Access application.

## Description

The `Remove-EntraBetaPrivateAccessApplicationSegment` cmdlet removes application segments associated to a Private Access application.

## Examples

### Example 1: Delete an application segment

```powershell
$ApplicationObjectId = (Get-EntraBetaApplication -Filter "DisplayName eq '<GlobalSecureAccess_Application_DisplayName>'").ObjectId
$ApplicationSegmentId = (Get-EntraBetaPrivateAccessApplicationSegment -ObjectId $ApplicationObjectId -Top 1).Id

$params = @{
    ObjectId = $ApplicationObjectId
    ApplicationSegmentId = $ApplicationSegmentId
}

Remove-EntraBetaPrivateAccessApplicationSegment @params
```

This example shows how to remove an application segment associated to a Private Access application.

- `ObjectId` is the application Object ID of the Private Access Application.
- `ApplicationSegmentId` is the application segment identifier to be deleted.

## Parameters

### -ObjectId

The object ID of a Private Access application object.

```yaml
Type: System.String
Parameter Sets: 
Aliases: id

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ApplicationSegmentId

The application segment ID of the application segment to be deleted.

```yaml
Type: System.String
Parameter Sets: 
Aliases: 

Required: True
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

[Get-EntraBetaPrivateAccessApplicationSegment](Get-EntraBetaPrivateAccessApplicationSegment.md)
[New-EntraBetaPrivateAccessApplicationSegment](New-EntraBetaPrivateAccessApplicationSegment.md)
[Get-EntraBetaApplication](Get-EntraBetaApplication.md)
