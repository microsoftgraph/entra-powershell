---
title: Get-EntraUserManager.
description: This article provides details on the Get-EntraUserManager command.

ms.service: active-directory
ms.topic: reference
ms.date: 03/08/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraUserManager

## SYNOPSIS
Gets the manager of a user.

## SYNTAX

```
Get-EntraUserManager 
 -ObjectId <String> 
 [<CommonParameters>]
```

## DESCRIPTION
The Get-EntraUserManager cmdlet gets the manager of a user in Microsoft Entra ID.

## EXAMPLES

### Example 1: Get the manager of a user
```powershell
PS C:\>Get-EntraUserManager -ObjectId "412be9d1-1460-4061-8eed-cca203fcb215"
```
```output
ageGroup                        :
onPremisesLastSyncDateTime      :
creationType                    :
imAddresses                     : {miriamg@m365x99297270.onmicrosoft.com}
preferredLanguage               :
mail                            : MiriamG@M365x99297270.OnMicrosoft.com
securityIdentifier              : S-1-12-1-649798363-1255893902-1277583799-1163042182
identities                      : {@{signInType=userPrincipalName; issuer=M365x99297270.onmicrosoft.com; issuerAssignedId=MiriamG@M365x99297270.OnMicrosoft.com}}
consentProvidedForMinor         :
onPremisesUserPrincipalName     :
```

This example demonstrates how to retrieve the manager of a specific user.    
This command gets the manager of a specified user.

## PARAMETERS

### -ObjectId
The unique identifier of a user in Microsoft Entra ID (UserPrincipalName or ObjectId).

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Remove-EntraUserManager](Remove-EntraUserManager.md)

[Set-EntraUserManager](Set-EntraUserManager.md)

