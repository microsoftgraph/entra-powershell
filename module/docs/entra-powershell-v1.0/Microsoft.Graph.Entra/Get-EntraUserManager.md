---
title: Get-EntraUserManager.
description: This article provides details on the Get-EntraUserManager command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Get-EntraUserManager

schema: 2.0.0
---

# Get-EntraUserManager

## Synopsis

Gets the manager of a user.

## Syntax

```powershell
Get-EntraUserManager
 -ObjectId <String>
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

The Get-EntraUserManager cmdlet gets the manager of a user in Microsoft Entra ID.

## Examples

### Example 1: Get the manager of a user

```powershell
Connect-Entra -Scopes 'User.Read.All'
Get-EntraUserManager -ObjectId 'eeeeeeee-4444-5555-6666-ffffffffffff'
```

```output
ageGroup                        :
onPremisesLastSyncDateTime      :
creationType                    :
imAddresses                     : {miriamg@contoso.com}
preferredLanguage               :
mail                            : MiriamG@contoso.com
securityIdentifier              : B-2-33-4-5555555555-6666666666-7777777-8888888888
identities                      : {@{signInType=userPrincipalName; issuer=contoso.com; issuerAssignedId=MiriamG@contoso.com}}
consentProvidedForMinor         :
onPremisesUserPrincipalName     :
```

This example demonstrates how to retrieve the manager of a specific user.

## Parameters

### -ObjectId

The unique identifier of a user in Microsoft Entra ID (UserPrincipalName or ObjectId).

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

### -Property

Specifies properties to be returned

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

[Remove-EntraUserManager](Remove-EntraUserManager.md)

[Set-EntraUserManager](Set-EntraUserManager.md)
