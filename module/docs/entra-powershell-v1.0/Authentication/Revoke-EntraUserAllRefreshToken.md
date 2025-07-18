---
author: msewaweru
description: This article provides details on the Revoke-EntraUserAllRefreshToken command.
external help file: Microsoft.Entra.Authentication-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra
ms.author: eunicewaweru
ms.date: 06/26/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Revoke-EntraUserAllRefreshToken
schema: 2.0.0
title: Revoke-EntraUserAllRefreshToken
---

# Revoke-EntraUserAllRefreshToken

## SYNOPSIS

Invalidates the refresh tokens issued to applications for a user.

## SYNTAX

```powershell
Revoke-EntraUserAllRefreshToken
 -UserId <String>
 [<CommonParameters>]
```

## DESCRIPTION

The `Revoke-EntraUserAllRefreshToken` cmdlet invalidates the refresh tokens issued to applications for a user.

The cmdlet also invalidates tokens issued to session cookies in a browser for the user.

The cmdlet operates by resetting the refreshTokensValidFromDateTime user property to the current date and time.

This operation is usually performed by the user or an administrator if the user's device is lost or stolen. It blocks access to the organization's data by requiring the user to sign in again to all previously authorized applications, regardless of the device.

## EXAMPLES

### Example 1: Revoke refresh tokens for a user

```powershell
Connect-Entra -Scopes 'User.RevokeSessions.All'
Revoke-EntraUserAllRefreshToken -UserId 'SawyerM@contoso.com'
```

```Output
Value
-----
True
```

This example demonstrates how to revoke the tokens for the specified user.

- `-UserId` parameter specifies the unique identifier of a user.

## PARAMETERS

### -UserId

Specifies the unique ID of a user.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: ObjectId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Revoke-EntraSignedInUserAllRefreshToken](Revoke-EntraSignedInUserAllRefreshToken.md)
