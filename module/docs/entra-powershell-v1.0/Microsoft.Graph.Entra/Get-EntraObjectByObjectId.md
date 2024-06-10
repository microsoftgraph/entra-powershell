---
title: Get-EntraObjectByObjectId.
description: This article provides details on the Get-EntraObjectByObjectId command.
ms.service: active-directory
ms.topic: reference
ms.date: 03/18/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraObjectByObjectId

## SYNOPSIS

Retrieves the objects specified by the ObjectIds parameter.

## SYNTAX

```powershell
Get-EntraObjectByObjectId 
 -ObjectIds <System.Collections.Generic.List`1[String]>
 [-Types <System.Collections.Generic.List`1[String]>]
 [<CommonParameters>]
```

## DESCRIPTION

Retrieves the objects specified by the ObjectIds parameter.

## EXAMPLES

### Example 1: Get an object One or more object IDs.

```powershell
Connect-Entra -Scopes 'Directory.Read.All'
Get-EntraObjectByObjectId  -ObjectIds aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb , bbbbbbbb-1111-2222-3333-cccccccccccc
```

```Output
ageGroup                        :
onPremisesLastSyncDateTime      :
creationType                    :
imAddresses                     : {admin@contoso.onmicrosoft.com}
preferredLanguage               :
mail                            : admin@contoso.onmicrosoft.com
securityIdentifier              : A-1-22-3-4444444444-5555555555-6666666-7777777777
identities                      : {@{signInType=userPrincipalName; issuer=contoso.onmicrosoft.com; issuerAssignedId=admin@contoso.onmicrosoft.com}}
consentProvidedForMinor         :
onPremisesUserPrincipalName     :
assignedLicenses                : {@{disabledPlans=System.Object[]; skuId=cccccccc-2222-3333-4444-dddddddddddd}, @{disabledPlans=System.Object[];
                                  skuId=dddddddd-3333-4444-5555-eeeeeeeeeeee}, @{disabledPlans=System.Object[]; skuId=eeeeeeee-4444-5555-6666-ffffffffffff}}
department                      : Engineering
jobTitle                        : Product Manager


```

This example two objects are retrieved (a DeviceConfiguration object and an Application object) as specified by the value of the ObjectIds parameter.

### Example 2: Get an object by types

```powershell
Connect-Entra -Scopes 'Directory.Read.All'
Get-EntraObjectByObjectId -ObjectIds aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb -Types User
```

```Output
ageGroup                        :
onPremisesLastSyncDateTime      :
creationType                    :
imAddresses                     : {admin@contoso.onmicrosoft.com}
preferredLanguage               :
mail                            : admin@contoso.onmicrosoft.com
securityIdentifier              : A-1-22-3-4444444444-5555555555-6666666-7777777777
identities                      : {@{signInType=userPrincipalName; issuer=contoso.onmicrosoft.com; issuerAssignedId=admin@contoso.onmicrosoft.com}}
consentProvidedForMinor         :
onPremisesUserPrincipalName     :
assignedLicenses                : {@{disabledPlans=System.Object[]; skuId=cccccccc-2222-3333-4444-dddddddddddd}, @{disabledPlans=System.Object[];
                                  skuId=dddddddd-3333-4444-5555-eeeeeeeeeeee}, @{disabledPlans=System.Object[]; skuId=eeeeeeee-4444-5555-6666-ffffffffffff}}
department                      : Engineering
jobTitle                        : Product Manager
```

This example demonstrates how to retrieve objects for a specified object type.

## PARAMETERS

### -ObjectIds

One or more object IDs, separated by commas, for which the objects are retrieved.

```yaml
Type: System.Collections.Generic.List`1[System.String]
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Types

Specifies the type of objects that the cmdlet returns.

```yaml
Type: System.Collections.Generic.List`1[System.String]
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

## INPUTS

### None

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS
