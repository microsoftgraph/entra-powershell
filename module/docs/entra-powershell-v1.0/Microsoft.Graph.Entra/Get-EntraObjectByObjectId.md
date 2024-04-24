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
 -ObjectIds <System.Collections.Generic.List`1[System.String]>
 [-Types <System.Collections.Generic.List`1[System.String]>]
 [<CommonParameters>]
```

## DESCRIPTION
Retrieves the objects specified by the ObjectIds parameter.

## EXAMPLES

### Example 1: Get an object One or more object IDs.
```powershell
PS C:\WINDOWS\system32> Get-AzureADObjectByObjectId -ObjectIds f44fe7fb-462c-41bd-9d36-8e3be78c4d5f , b7fd7e22-eefe-4d37-97c4-9cb7ede0ab5e
```
```output
ageGroup                        :
onPremisesLastSyncDateTime      :
creationType                    :
imAddresses                     : {lidiah@m365x99297270.onmicrosoft.com}
preferredLanguage               :
mail                            : LidiaH@M365x99297270.OnMicrosoft.com
securityIdentifier              : S-1-12-1-3086843426-1295511294-3080504471-1588322541
identities                      : {@{signInType=userPrincipalName; issuer=M365x99297270.onmicrosoft.com; issuerAssignedId=LidiaH@M365x99297270.OnMicrosoft.com}}
consentProvidedForMinor         :
onPremisesUserPrincipalName     :
assignedLicenses                : {@{disabledPlans=System.Object[]; skuId=184efa21-98c3-4e5d-95ab-d07053a96e67}, @{disabledPlans=System.Object[];
                                  skuId=b05e124f-c7cc-45a0-a6aa-8cf78c946968}, @{disabledPlans=System.Object[]; skuId=c7df2760-2c81-4ef7-b578-5b5392b571df}}
department                      : Engineering
jobTitle                        : Product Manager


```
This example two objects are retrieved (a DeviceConfiguration object and an Application object) as specified by the value of the ObjectIds parameter.

### Example 2: Get an object by types
```powershell
PS C:\> Get-EntraObjectByObjectId -ObjectIds b7fd7e22-eefe-4d37-97c4-9cb7ede0ab5e -Types User
```
```output
ageGroup                        :
onPremisesLastSyncDateTime      :
creationType                    :
imAddresses                     : {lidiah@m365x99297270.onmicrosoft.com}
preferredLanguage               :
mail                            : LidiaH@M365x99297270.OnMicrosoft.com
securityIdentifier              : S-1-12-1-3086843426-1295511294-3080504471-1588322541
identities                      : {@{signInType=userPrincipalName; issuer=M365x99297270.onmicrosoft.com; issuerAssignedId=LidiaH@M365x99297270.OnMicrosoft.com}}
consentProvidedForMinor         :
onPremisesUserPrincipalName     :
assignedLicenses                : {@{disabledPlans=System.Object[]; skuId=184efa21-98c3-4e5d-95ab-d07053a96e67}, @{disabledPlans=System.Object[];
                                  skuId=b05e124f-c7cc-45a0-a6aa-8cf78c946968}, @{disabledPlans=System.Object[]; skuId=c7df2760-2c81-4ef7-b578-5b5392b571df}}
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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None
## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
