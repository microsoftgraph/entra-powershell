---
author: msewaweru
description: This article provides details on the Revoke-EntraBetaUserAllRefreshToken command.
external help file: Microsoft.Entra.Beta.Authentication-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 07/25/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Revoke-EntraBetaUserAllRefreshToken
schema: 2.0.0
title: Revoke-EntraBetaUserAllRefreshToken
---

# Revoke-EntraBetaUserAllRefreshToken

## Synopsis

Invalidates the refresh tokens issued to applications for a user.

## Syntax

```powershell
Revoke-EntraBetaUserAllRefreshToken
 -UserId <String>
 [<CommonParameters>]
```

## Description

The `Revoke-EntraBetaUserAllRefreshToken` cmdlet invalidates the refresh tokens issued to applications for a user.

The cmdlet also invalidates tokens issued to session cookies in a browser for the user.

The cmdlet operates by resetting the refreshTokensValidFromDateTime user property to the current date and time.

The user or an administrator usually performs this operation if the user's device is lost or stolen. It blocks access to the organization's data by requiring the user to sign in again to all previously authorized applications, regardless of the device

## Examples

### Example 1: Revoke refresh tokens for a user

```powershell
Connect-Entra -Scopes 'User.RevokeSessions.All'
Revoke-EntraBetaUserAllRefreshToken -UserId 'SawyerM@contoso.com'
```

```Output
Value
-----
True
```

This example demonstrates how to revoke the tokens for the specified user.

- `-UserId` parameter specifies the unique identifier of a user.

## Parameters

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

## Inputs

## Outputs

## Notes

## Related links

[Revoke-EntraBetaSignedInUserAllRefreshToken](Revoke-EntraBetaSignedInUserAllRefreshToken.md)
