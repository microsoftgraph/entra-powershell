---
author: andres-canello
description: This article provides details on the Remove-EntraBetaPrivateAccessApplicationSegment command.
external help file: Microsoft.Entra.Beta.NetworkAccess.NetworkAccess-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.Beta.NetworkAccess
ms.author: eunicewaweru
ms.date: 07/18/2024
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta.NetworkAccess/Remove-EntraBetaPrivateAccessApplicationSegment
reviewer: andres-canello
schema: 2.0.0
title: Remove-EntraBetaPrivateAccessApplicationSegment
---

# Remove-EntraBetaPrivateAccessApplicationSegment

## SYNOPSIS

Removes an application segment associated to a Private Access application.

## SYNTAX

```powershell
Remove-EntraBetaPrivateAccessApplicationSegment
 -ApplicationId <String>
 [-ApplicationSegmentId <String>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Remove-EntraBetaPrivateAccessApplicationSegment` cmdlet removes application segments associated to a Private Access application.

## EXAMPLES

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

## PARAMETERS

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

## INPUTS

### System.String

System.Nullable\`1\[\[System. Boolean, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089\]\] System.Nullable\`1\[\[System.Int32, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089\]\]

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS

[Get-EntraBetaPrivateAccessApplicationSegment](Get-EntraBetaPrivateAccessApplicationSegment.md)

[New-EntraBetaPrivateAccessApplicationSegment](New-EntraBetaPrivateAccessApplicationSegment.md)

[Get-EntraBetaApplication](../Applications/Get-EntraBetaApplication.md)
