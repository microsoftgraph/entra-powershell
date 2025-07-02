---
author: andres-canello
description: This article provides details on the Get-EntraBetaPrivateAccessApplicationSegment command.
external help file: Microsoft.Entra.Beta.NetworkAccess-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 06/26/2024
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Get-EntraBetaPrivateAccessApplicationSegment
reviewer: andres-canello
schema: 2.0.0
title: Get-EntraBetaPrivateAccessApplicationSegment
---

# Get-EntraBetaPrivateAccessApplicationSegment

## Synopsis

Retrieves a list of all application segments associated to a Private Access application, or if specified, details of a specific application segment.

## Syntax

```powershell
Get-EntraBetaPrivateAccessApplicationSegment
 -ApplicationId <String>
 [-ApplicationSegmentId <String>]
 [<CommonParameters>]
```

## Description

The `Get-EntraBetaPrivateAccessApplicationSegment` cmdlet retrieves a list of all application segments associated to a Private Access application, or if specified, details of a specific application segment.

## Examples

### Example 1: Retrieve all application segments associated to an application

```powershell
Connect-Entra -Scopes 'NetworkAccessPolicy.ReadWrite.All', 'Application.ReadWrite.All', 'NetworkAccess.ReadWrite.All'
$application = Get-EntraBetaApplication -Filter "displayName eq '<GlobalSecureAccess_Application_DisplayName>'"
Get-EntraBetaPrivateAccessApplicationSegment -ApplicationId $application.Id
```

```Output
destinationHost : 10.1.1.20
destinationType : ip
port            : 0
ports           : {22-22}
protocol        : tcp
id              : cccc2222-dd33-4444-55ee-666666ffffff
```

This command retrieves all application segments for an application.

### Example 2: Retrieve a specific application segment associated to an application

```powershell
Connect-Entra -Scopes 'NetworkAccessPolicy.ReadWrite.All', 'Application.ReadWrite.All', 'NetworkAccess.ReadWrite.All'
$application = Get-EntraBetaApplication -Filter "displayName eq '<GlobalSecureAccess_Application_DisplayName>'"
$applicationSegment = Get-EntraBetaPrivateAccessApplicationSegment -ApplicationId $application.Id | Where-Object {$_.destinationType -eq 'fqdn'}
Get-EntraBetaPrivateAccessApplicationSegment -ApplicationId $application.Id -ApplicationSegmentId $applicationSegment.Id
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

### -ApplicationId

The Object ID of a Private Access application object.

```yaml
Type: System.String
Parameter Sets: AllApplicationSegments, SingleApplicationSegment
Aliases: ObjectId

Required: True
Position: Named
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
Position: Named
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

[Get-EntraBetaApplication](../Applications/Get-EntraBetaApplication.md)

[Remove-EntraBetaPrivateAccessApplicationSegment](Remove-EntraBetaPrivateAccessApplicationSegment.md)

[New-EntraBetaPrivateAccessApplicationSegment](New-EntraBetaPrivateAccessApplicationSegment.md)
