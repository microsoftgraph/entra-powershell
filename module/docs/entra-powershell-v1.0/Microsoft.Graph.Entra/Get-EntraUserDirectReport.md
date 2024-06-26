---
title: Get-EntraUserDirectReport.
description: This article provides details on the Get-EntraUserDirectReport command.

ms.service: entra
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

# Get-EntraUserDirectReport

## Synopsis

get the user's direct reports.

## Syntax

```powershell
Get-EntraUserDirectReport 
 -ObjectId <String> 
 [-All] 
 [-Top <Int32>] 
 [<CommonParameters>]
```

## Description

the Get-EntraUserDirectReport cmdlet gets the direct reports for a user in Microsoft Entra ID.

## Examples

### Example 1: Get a user's direct reports

```powershell
Connect-Entra -Scopes 'User.Read' #Delegated Permission
Connect-Entra -Scopes 'User.Read.All' #Application Permission
Get-EntraUserDirectReport -ObjectId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'
```

```Output
ageGroup                        :
onPremisesLastSyncDateTime      :
creationType                    :
imAddresses                     : {debrab@contoso.com}
preferredLanguage               :
mail                            : DebraB@contoso.com
securityIdentifier              : A-1-22-3-4444444444-5555555555-6666666-7777777777
identities                      : {@{signInType=userPrincipalName; issuer=contoso.com; issuerAssignedId=DebraB@contoso.com}}
consentProvidedForMinor         :
onPremisesUserPrincipalName     :
assignedLicenses                : {@{disabledPlans=System.Object[]; skuId=33334444-dddd-5555-eeee-6666ffff7777}, @{disabledPlans=System.Object[]; skuId=44445555-eeee-6666-ffff-7777aaaa8888},
                                  @{disabledPlans=System.Object[]; skuId=55556666-ffff-7777-aaaa-8888bbbb9999}}
```

This example demonstrates how to retrieve direct reports for a user in Microsoft Entra ID.

### Example 2: Get all direct reports

```powershell
Connect-Entra -Scopes 'User.Read' #Delegated Permission
Connect-Entra -Scopes 'User.Read.All' #Application Permission
Get-EntraUserDirectReport -ObjectId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb' -All 
```

```output
ageGroup                        :
onPremisesLastSyncDateTime      :
creationType                    :
imAddresses                     : {debrab@contoso.com}
preferredLanguage               :
mail                            : DebraB@contoso.com
securityIdentifier              : A-1-22-3-4444444444-5555555555-6666666-7777777777
identities                      : {@{signInType=userPrincipalName; issuer=contoso.com; issuerAssignedId=DebraB@contoso.com}}
consentProvidedForMinor         :
onPremisesUserPrincipalName     :
assignedLicenses                : {@{disabledPlans=System.Object[]; skuId=33334444-dddd-5555-eeee-6666ffff7777}, @{disabledPlans=System.Object[]; skuId=44445555-eeee-6666-ffff-7777aaaa8888},
                                  @{disabledPlans=System.Object[]; skuId=55556666-ffff-7777-aaaa-8888bbbb9999}}
```

This example demonstrates how to retrieve all direct reports for a user in Microsoft Entra ID.

### Example 3: Get a top five direct reports

```powershell
Connect-Entra -Scopes 'User.Read' #Delegated Permission
Connect-Entra -Scopes 'User.Read.All' #Application Permission
Get-EntraUserDirectReport -ObjectId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb' -Top 5
```

```output
ageGroup                        :
onPremisesLastSyncDateTime      :
creationType                    :
imAddresses                     : {debrab@contoso.com}
preferredLanguage               :
mail                            : DebraB@contoso.com
securityIdentifier              : A-1-22-3-4444444444-5555555555-6666666-7777777777
identities                      : {@{signInType=userPrincipalName; issuer=contoso.com; issuerAssignedId=DebraB@contoso.com}}
consentProvidedForMinor         :
onPremisesUserPrincipalName     :
assignedLicenses                : {@{disabledPlans=System.Object[]; skuId=33334444-dddd-5555-eeee-6666ffff7777}, @{disabledPlans=System.Object[]; skuId=44445555-eeee-6666-ffff-7777aaaa8888},
                                  @{disabledPlans=System.Object[]; skuId=55556666-ffff-7777-aaaa-8888bbbb9999}}
```

This example demonstrates how to retrieve top five direct reports for a user in Microsoft Entra ID.

## Parameters

### -All

List all pages.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -ObjectId

Specifies the ID of a user in Microsoft Entra ID (UserPrincipalName or ObjectId).

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

### -Top

Specifies the maximum number of records to return.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related Links
