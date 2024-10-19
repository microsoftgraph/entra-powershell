---
title: Revoke-EntraSignedInUserAllRefreshToken
description: This article provides details on the Revoke-EntraSignedInUserAllRefreshToken command.

ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Revoke-EntraSignedInUserAllRefreshToken

schema: 2.0.0
---

# Revoke-EntraSignedInUserAllRefreshToken

## Synopsis

Invalidates the refresh tokens issued to applications for the current user.

## Syntax

```powershell
Revoke-EntraSignedInUserAllRefreshToken
 [<CommonParameters>]
```

## Description

The `Revoke-EntraSignedInUserAllRefreshToken` cmdlet invalidates all the refresh tokens issued to applications for a user (and session cookies in a user's browser), by resetting the signInSessionsValidFromDateTime user property to the current date-time.

The user or an administrator typically performs this operation if the user's device is lost or stolen. This action prevents access to the organization's data on the device by requiring the user to sign in again to all previously consented applications, regardless of the device.

Note: If the application attempts to redeem a delegated access token for this user using an invalidated refresh token, the application receives an error. When this happens, the application needs to acquire a new refresh token by making a request to the authorized endpoint, which forces the user to sign in.

After you run this command, a small delay of a few minutes can occur before tokens are revoked.

## Examples

### Example 1: Revoke refresh tokens for the current user

```powershell
Connect-Entra -Scopes 'User.RevokeSessions.All'
Revoke-EntraSignedInUserAllRefreshToken
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

[Revoke-EntraUserAllRefreshToken](Revoke-EntraUserAllRefreshToken.md)
