---
title: Get-EntraBetaAuthorizationPolicy
description: This article provides details on the Get-EntraBetaAuthorizationPolicy command.


ms.topic: reference
ms.date: 07/29/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Get-EntraBetaAuthorizationPolicy

schema: 2.0.0
---

# Get-EntraBetaAuthorizationPolicy

## Synopsis

Gets an authorization policy.

## Syntax

### GetQuery (Default)

```powershell
Get-EntraBetaAuthorizationPolicy
 [-Property <String[]>]
 [<CommonParameters>]
```

### GetById

```powershell
Get-EntraBetaAuthorizationPolicy
 -Id <String>
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

The `Get-EntraBetaAuthorizationPolicy` cmdlet gets a Microsoft Entra ID authorization policy.

## Examples

### Example 1: Get an authorization policy by ID

```powershell
Connect-Entra -Scopes 'Policy.Read.All'
Get-EntraBetaAuthorizationPolicy -Id 'authorizationPolicy'
```

```Output
DeletedDateTime Description         DisplayName         Id                  AllowEmailVerifiedUsersToJoinOrganization AllowInvitesFrom AllowUserConsentForRiskyApps AllowedToSignUpEmailBasedSubscriptions Allowed
                                                                                                                                                                                                           ToUseSs
                                                                                                                                                                                                           pr
--------------- -----------         -----------         --                  ----------------------------------------- ---------------- ---------------------------- -------------------------------------- -------
                Updated Description Updated displayName authorizationPolicy True                                      everyone                                      True                                   False
```

This example gets the Microsoft Entra ID authorization policy.

- `-Id` parameter specifies the unique identifier of the authorization policy.

## Parameters

### -Id

Specifies the unique identifier of the authorization policy.

```yaml
Type: System.String
Parameter Sets: GetById
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Property

Specifies properties to be returned.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related Links

[Set-EntraBetaAuthorizationPolicy](Set-EntraBetaAuthorizationPolicy.md)
