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

## SYNOPSIS

Invalidates the refresh tokens issued to applications for a user.

## SYNTAX

```powershell
Revoke-EntraUserAllRefreshToken 
 -ObjectId <String> 
 [<CommonParameters>]
```

## DESCRIPTION

The Revoke-EntraUserAllRefreshToken cmdlet invalidates the refresh tokens issued to applications for a user.
The cmdlet also invalidates tokens issued to session cookies in a browser for the user.
The cmdlet operates by resetting the refreshTokensValidFromDateTime user property to the current date and time.

## EXAMPLES

### Example 1: Revoke refresh tokens for a user

```powershell
Connect-Entra -Scopes 'User.RevokeSessions.All'
Revoke-EntraUserAllRefreshToken -ObjectId 'bbbbbbbb-1111-2222-3333-cccccccccccc'
```

This example demonstrates how to revoke the tokens for the specified user.

## PARAMETERS

### -ObjectId

Specifies the unique ID of a user.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

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
