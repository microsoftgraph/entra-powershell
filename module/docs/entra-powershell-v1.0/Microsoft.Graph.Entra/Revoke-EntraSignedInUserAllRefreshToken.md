---
title: Revoke-EntraSignedInUserAllRefreshToken.
description: This article provides details on the Revoke-EntraSignedInUserAllRefreshToken command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
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
The Revoke-EntraSignedInUserAllRefreshToken cmdlet invalidates the refresh tokens issued to applications for the current user. 
The cmdlet also invalidates tokens issued to session cookies in a browser for the user. 
The cmdlet operates by resetting the refreshTokensValidFromDateTime user property to the current date and time.

## Examples

### Example 1: Revoke refresh tokens for the current user
```powershell
PS C:\> Revoke-EntraSignedInUserAllRefreshToken
```

This command revokes the tokens for the current user.

## Parameters

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related Links

[Revoke-EntraUserAllRefreshToken](Revoke-EntraUserAllRefreshToken.md)

[#AzureAD: Certificate based authentication for iOS and Android now in preview!](https://blogs.technet.microsoft.com/enterprisemobility/2016/07/18/azuread-certificate-based-authentication-for-ios-and-android-now-in-preview/)

