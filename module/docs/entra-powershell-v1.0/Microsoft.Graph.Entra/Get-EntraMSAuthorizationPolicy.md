---
title: Get-EntraMSAuthorizationPolicy
description: This article provides details on the Get-EntraMSAuthorizationPolicy command.

ms.service: entra
ms.subservice: powershell
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

## SYNOPSIS
Gets an authorization policy, which represents a policy that can control Microsoft Entra ID authorization settings.

## SYNTAX

```powershell
Get-EntraMSAuthorizationPolicy 
 [<CommonParameters>]
```

## DESCRIPTION
The Get-EntraMSAuthorizationPolicy cmdlet gets a Microsoft Entra ID authorization policy.

## EXAMPLES

### Example 1: Get an authorization policy by ID.

```powershell
PS C:\>Get-EntraMSAuthorizationPolicy
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

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Set-EntraMSAuthorizationPolicy](Set-EntraMSAuthorizationPolicy.md)

