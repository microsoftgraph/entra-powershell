---
title: Get-EntraUserDirectReport.
description: This article provides details on the Get-EntraUserDirectReport command.

ms.service: active-directory
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

# Get-EntraUserDirectReport

## SYNOPSIS
Get the user's direct reports.

## SYNTAX

```powershell
Get-EntraUserDirectReport 
 -ObjectId <String> 
 [-All <Boolean>] 
 [-Top <Int32>] 
 [<CommonParameters>]
```

## DESCRIPTION
The Get-EntraUserDirectReport cmdlet gets the direct reports for a user in Microsoft Entra ID.

## EXAMPLES

### Example 1: Get a user's direct reports
```powershell
PS C:\> Get-EntraUserDirectReport -ObjectId "df19e8e6-2ad7-453e-87f5-037f6529ae16"
```
```output
ageGroup                        :
onPremisesLastSyncDateTime      :
creationType                    :
imAddresses                     : {debrab@m365x99297270.onmicrosoft.com}
preferredLanguage               :
mail                            : DebraB@M365x99297270.OnMicrosoft.com
securityIdentifier              : S-1-12-1-2430512737-1080277439-3869513867-4132559946
identities                      : {@{signInType=userPrincipalName; issuer=M365x99297270.onmicrosoft.com; issuerAssignedId=DebraB@M365x99297270.OnMicrosoft.com}}
consentProvidedForMinor         :
onPremisesUserPrincipalName     :
assignedLicenses                : {@{disabledPlans=System.Object[]; skuId=184efa21-98c3-4e5d-95ab-d07053a96e67}, @{disabledPlans=System.Object[]; skuId=b05e124f-c7cc-45a0-a6aa-8cf78c946968},
                                  @{disabledPlans=System.Object[]; skuId=c7df2760-2c81-4ef7-b578-5b5392b571df}}
```

This example demonstrates how to retrieve direct reports for a user in Microsoft Entra ID.    
This command gets the direct report for the specified user.

### Example 2: Get a all direct reports
```powershell
PS C:\> Get-EntraUserDirectReport -ObjectId "c300541f-2c03-49cb-b25b-72f09cb29abf" -All $true
```
```output
ageGroup                        :
onPremisesLastSyncDateTime      :
creationType                    :
imAddresses                     : {debrab@m365x99297270.onmicrosoft.com}
preferredLanguage               :
mail                            : DebraB@M365x99297270.OnMicrosoft.com
securityIdentifier              : S-1-12-1-2430512737-1080277439-3869513867-4132559946
identities                      : {@{signInType=userPrincipalName; issuer=M365x99297270.onmicrosoft.com; issuerAssignedId=DebraB@M365x99297270.OnMicrosoft.com}}
consentProvidedForMinor         :
onPremisesUserPrincipalName     :
assignedLicenses                : {@{disabledPlans=System.Object[]; skuId=184efa21-98c3-4e5d-95ab-d07053a96e67}, @{disabledPlans=System.Object[]; skuId=b05e124f-c7cc-45a0-a6aa-8cf78c946968},
                                  @{disabledPlans=System.Object[]; skuId=c7df2760-2c81-4ef7-b578-5b5392b571df}}
```

This example demonstrates how to retrieve all direct reports for a user in Microsoft Entra ID.  
This command gets the all direct report for the specified user.

### Example 3: Get a top five direct reports
```powershell
PS C:\> Get-EntraUserDirectReport -ObjectId "c300541f-2c03-49cb-b25b-72f09cb29abf" -Top 5
```
```output
ageGroup                        :
onPremisesLastSyncDateTime      :
creationType                    :
imAddresses                     : {debrab@m365x99297270.onmicrosoft.com}
preferredLanguage               :
mail                            : DebraB@M365x99297270.OnMicrosoft.com
securityIdentifier              : S-1-12-1-2430512737-1080277439-3869513867-4132559946
identities                      : {@{signInType=userPrincipalName; issuer=M365x99297270.onmicrosoft.com; issuerAssignedId=DebraB@M365x99297270.OnMicrosoft.com}}
consentProvidedForMinor         :
onPremisesUserPrincipalName     :
assignedLicenses                : {@{disabledPlans=System.Object[]; skuId=184efa21-98c3-4e5d-95ab-d07053a96e67}, @{disabledPlans=System.Object[]; skuId=b05e124f-c7cc-45a0-a6aa-8cf78c946968},
                                  @{disabledPlans=System.Object[]; skuId=c7df2760-2c81-4ef7-b578-5b5392b571df}}
```

This example demonstrates how to retrieve top five direct reports for a user in Microsoft Entra ID.  
This command gets the five direct report for the specified user.

## PARAMETERS

### -All
If true, return all direct reports for this user.
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
Specifies the ID of a user in Microsoft Entra ID (UserPrincipalName or ObjectId).

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
