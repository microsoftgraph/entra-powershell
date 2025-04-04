---
title: Revoke-EntraBetaSignedInUserAllRefreshToken
description: This article provides details on the Revoke-EntraBetaSignedInUserAllRefreshToken command.

ms.topic: reference
ms.date: 07/25/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Revoke-EntraBetaSignedInUserAllRefreshToken
schema: 2.0.0
---

# Revoke-EntraBetaSignedInUserAllRefreshToken

## Synopsis

Invalidates the refresh tokens issued to applications for the current user.

## Syntax

```powershell
Revoke-EntraBetaSignedInUserAllRefreshToken
 [<CommonParameters>]
```

## Description

The `Revoke-EntraBetaSignedInUserAllRefreshToken` cmdlet invalidates all the refresh tokens issued to applications for a user (as well as session cookies in a user's browser), by resetting the signInSessionsValidFromDateTime user property to the current date-time.

Typically, this operation is performed (by the user or an administrator) if the user has a lost or stolen device. This operation prevents access to the organization's data through applications on the device by requiring the user to sign in again to all applications that they have previously consented to, independent of device.

Note: If the application attempts to redeem a delegated access token for this user by using an invalidated refresh token, the application will get an error. If this happens, the application will need to acquire a new refresh token by making a request to the authorize endpoint, which will force the user to sign in.

After running this command, there might be a small delay of a few minutes before tokens are revoked.

## Examples

### Example 1: Revoke refresh tokens for the current user

```powershell
Connect-Entra -Scopes 'User.RevokeSessions.All'
Revoke-EntraBetaSignedInUserAllRefreshToken
```

```Output
Value
-----
True
```

This command revokes the tokens for the current user.

## Parameters

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related Links

[Revoke-EntraBetaUserAllRefreshToken](Revoke-EntraBetaUserAllRefreshToken.md)
