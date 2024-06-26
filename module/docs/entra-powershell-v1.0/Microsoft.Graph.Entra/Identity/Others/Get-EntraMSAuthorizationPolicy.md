---
title: Get-EntraMSAuthorizationPolicy
description: This article provides details on the Get-EntraMSAuthorizationPolicy command.

ms.service: entra
ms.topic: reference
ms.date: 03/05/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraMSAuthorizationPolicy

## Synopsis
Gets an authorization policy, which represents a policy that can control Microsoft Entra ID authorization settings.

## Syntax

```powershell
Get-EntraMSAuthorizationPolicy 
 [<CommonParameters>]
```

## Description
The Get-EntraMSAuthorizationPolicy cmdlet gets a Microsoft Entra ID authorization policy.

## Examples

### Example 1: Get an authorization policy by ID

```powershell
Connect-Entra -Scopes 'Policy.Read.All'
Get-EntraMSAuthorizationPolicy
```

```Output
DeletedDateTime Description DisplayName            Id                  AllowEmailVerifiedUsersToJoinOrganization AllowInvitesFrom AllowUserConsentForRiskyApps AllowedToSig
                                                                                                                                                               nUpEmailBase
                                                                                                                                                               dSubscriptio
                                                                                                                                                               ns
--------------- ----------- -----------            --                  ----------------------------------------- ---------------- ---------------------------- ------------
                test        Authorization Policies authorizationPolicy True                                      everyone                                      False

```

This command gets the Microsoft Entra ID authorization policy.

## Parameters

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related LINKS

[Set-EntraMSAuthorizationPolicy](Set-EntraMSAuthorizationPolicy.md)
