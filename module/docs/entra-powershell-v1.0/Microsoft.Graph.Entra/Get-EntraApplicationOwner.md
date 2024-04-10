---
title: Get-EntraApplicationOwner.
description: This article provides details on the Get-EntraApplicationOwner command.

ms.service: active-directory
ms.topic: reference
ms.date: 03/15/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraApplicationOwner

## SYNOPSIS
Gets the owner of an application.

## SYNTAX

```powershell
Get-EntraApplicationOwner 
 -ObjectId <String> 
 [-All <Boolean>] 
 [-Top <Int32>] 
 [<CommonParameters>]
```

## DESCRIPTION
The Get-EntraApplicationOwner cmdlet gets an owner of a Microsoft Entra ID application.

## EXAMPLES

### Example 1: Get the owner of an application
```powershell
PS C:\>Get-EntraApplicationOwner -ObjectId "e3108c4d-86ff-4ceb-9429-24e85b4b8cea"
```
```output
ageGroup                        :
onPremisesLastSyncDateTime      :
creationType                    :
imAddresses                     : {adelev@m365x99297270.onmicrosoft.com}
preferredLanguage               :
mail                            : AdeleV@M365x99297270.OnMicrosoft.com
securityIdentifier              : S-1-12-1-1093396945-1080104032-2731339150-364051459
identities                      : {@{signInType=userPrincipalName; issuer=M365x99297270.onmicrosoft.com; issuerAssignedId=AdeleV@M365x99297270.OnMicrosoft.com}}
consentProvidedForMinor         :
onPremisesUserPrincipalName     :
```

This example demonstrates how to get the owners of an application in Microsoft Entra ID.  
This command gets the owners of an application.

### Example 2: Get all owners of an application
```powershell
PS C:\>Get-EntraApplicationOwner -ObjectId "e3108c4d-86ff-4ceb-9429-24e85b4b8cea" -All $true
```
```output
ageGroup                        :
onPremisesLastSyncDateTime      :
creationType                    :
imAddresses                     : {adelev@m365x99297270.onmicrosoft.com}
preferredLanguage               :
mail                            : AdeleV@M365x99297270.OnMicrosoft.com
securityIdentifier              : S-1-12-1-1093396945-1080104032-2731339150-364051459
identities                      : {@{signInType=userPrincipalName; issuer=M365x99297270.onmicrosoft.com; issuerAssignedId=AdeleV@M365x99297270.OnMicrosoft.com}}
consentProvidedForMinor         :
onPremisesUserPrincipalName     :
```

This example demonstrates how to get the all owners of a specified application in Microsoft Entra ID.  
This command gets the all owners of a specified application.

### Example 3: Get top two owners of an application
```powershell
PS C:\>Get-EntraApplicationOwner -ObjectId "e3108c4d-86ff-4ceb-9429-24e85b4b8cea" -Top 2
```
```output
ageGroup                        :
onPremisesLastSyncDateTime      :
creationType                    :
imAddresses                     : {adelev@m365x99297270.onmicrosoft.com}
preferredLanguage               :
mail                            : AdeleV@M365x99297270.OnMicrosoft.com
securityIdentifier              : S-1-12-1-1093396945-1080104032-2731339150-364051459
identities                      : {@{signInType=userPrincipalName; issuer=M365x99297270.onmicrosoft.com; issuerAssignedId=AdeleV@M365x99297270.OnMicrosoft.com}}
consentProvidedForMinor         :
onPremisesUserPrincipalName     :
```

This example demonstrates how to get the all owners of a specified application in Microsoft Entra ID.  
This command gets the two owners of a specified application.

## PARAMETERS

### -All
If true, return all owners.
If false, return the number of objects specified by the Top parameter.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -ObjectId
Specifies the ID of an application in Microsoft Entra ID.

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

### -Top
Specifies the maximum number of records to return.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Add-EntraApplicationOwner](Add-EntraApplicationOwner.md)

[Remove-EntraApplicationOwner](Remove-EntraApplicationOwner.md)

