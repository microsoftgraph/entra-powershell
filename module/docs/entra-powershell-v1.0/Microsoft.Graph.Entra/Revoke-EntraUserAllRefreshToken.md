---
title: Revoke-EntraUserAllRefreshToken.
description: This article provides details on the Revoke-EntraUserAllRefreshToken command.

ms.service: entra
ms.topic: reference
ms.date: 03/19/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Revoke-EntraUserAllRefreshToken

## Synopsis
Invalidates the refresh tokens issued to applications for a user.

## Syntax

```powershell
Revoke-EntraUserAllRefreshToken 
 -ObjectId <String> 
 [<CommonParameters>]
```

## Description
The Revoke-EntraUserAllRefreshToken cmdlet invalidates the refresh tokens issued to applications for a user. 
The cmdlet also invalidates tokens issued to session cookies in a browser for the user.
The cmdlet operates by resetting the refreshTokensValidFromDateTime user property to the current date and time.

## Examples

### Example 1: Revoke refresh tokens for a user
```powershell
PS C:\> Revoke-EntraUserAllRefreshToken -ObjectId "a1d91a49-70c6-4d1d-a80a-b74c820a9a33"
```

This example demonstrates how to revoke the tokens for the specified user.  
This command revokes the tokens for the specified user.

## Parameters

### -ObjectId
Specifies the unique ID of a user.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related LINKS

[Revoke-EntraSignedInUserAllRefreshToken](Revoke-EntraSignedInUserAllRefreshToken.md)

[(#Microsoft Entra ID: Certificate based authentication for iOS and Android now in preview!](https://blogs.technet.microsoft.com/enterprisemobility/2016/07/18/azuread-certificate-based-authentication-for-ios-and-android-now-in-preview/)

