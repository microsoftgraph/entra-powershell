---
title: Remove-EntraBetaPrivateAccessApplicationSegment
description: This article provides details on the Remove-EntraBetaPrivateAccessApplicationSegment command.

ms.topic: reference
ms.date: 07/18/2024
ms.author: eunicewaweru
reviewer: andres-canello
manager: mwongerapk
author: andres-canello
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Remove-EntraBetaPrivateAccessApplicationSegment
schema: 2.0.0
---

# Remove-EntraBetaPrivateAccessApplicationSegment

## Synopsis

Removes an application segment associated to a Private Access application.

## Syntax

```powershell
Remove-EntraBetaPrivateAccessApplicationSegment
 -ApplicationId <String>
 [-ApplicationSegmentId <String>]
 [<CommonParameters>]
```

## Description

The `Remove-EntraBetaPrivateAccessApplicationSegment` cmdlet removes application segments associated to a Private Access application.

## Examples

### Example 1: Delete an application segment

```powershell
Connect-Entra -Scopes 'NetworkAccessPolicy.ReadWrite.All', 'Application.ReadWrite.All', 'NetworkAccess.ReadWrite.All'
$application = Get-EntraBetaApplication -Filter "displayName eq '<GlobalSecureAccess_Application_DisplayName>'"
$applicationSegment = Get-EntraBetaPrivateAccessApplicationSegment -ApplicationId $application.Id | Where-Object {$_.destinationType -eq 'fqdn'}
Remove-EntraBetaPrivateAccessApplicationSegment -ApplicationId $application.Id -ApplicationSegmentId $applicationSegment.Id
```

This example shows how to remove an application segment associated to a Private Access application.

- `ApplicationId` is the application Object ID of the Private Access Application.
- `ApplicationSegmentId` is the application segment identifier to be deleted.

## Parameters

### -ApplicationId

The object ID of a Private Access application object.

```yaml
Type: System.String
Parameter Sets: 
Aliases: ObjectId

Required: True
Position: Named
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

[Get-EntraBetaPrivateAccessApplicationSegment](Get-EntraBetaPrivateAccessApplicationSegment.md)

[New-EntraBetaPrivateAccessApplicationSegment](New-EntraBetaPrivateAccessApplicationSegment.md)

[Get-EntraBetaApplication](Get-EntraBetaApplication.md)
