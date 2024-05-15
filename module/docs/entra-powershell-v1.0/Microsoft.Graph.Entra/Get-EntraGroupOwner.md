---
title: Get-EntraGroupOwner.
description: This article provides details on the Get-EntraGroupOwner command.

ms.service: entra
ms.subservice: powershell
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

# Get-EntraGroupOwner

## SYNOPSIS
Gets an owner of a group.

## SYNTAX

```powershell
Get-EntraGroupOwner 
 -ObjectId <String>  
 [-All <Boolean>] 
 [-Top <Int32>] 
 [<CommonParameters>]
```

## DESCRIPTION
The Get-EntraGroupOwner cmdlet gets an owner of a group in Microsoft Entra ID.

## EXAMPLES

### Example 1: Get a group owner by ID

```powershell
PS C:\>Get-EntraGroupOwner -ObjectId "ba828166-dcd3-4349-aee9-9fbbf619105d"
```
```output
ageGroup                        :
onPremisesLastSyncDateTime      :
creationType                    :
imAddresses                     : {admin@m365x99297270.onmicrosoft.com}
preferredLanguage               : en
mail                            : admin@M365x99297270.onmicrosoft.com
securityIdentifier              : S-1-12-1-2574072234-1301806508-533216682-2892133300
identities                      : {@{signInType=userPrincipalName; issuer=M365x99297270.onmicrosoft.com; issuerAssignedId=admin@M365x99297270.onmicrosoft.com}}
consentProvidedForMinor         :
onPremisesUserPrincipalName     :
```

This example demonstrates how to retrieve the owner of a specific group.  

### Example 2: Gets all group owners
```powershell
PS C:\>Get-EntraGroupOwner -ObjectId "c072b115-ed7b-47cb-90d3-d5019d8bfd51" -All $true
```
```output
ageGroup                        :
onPremisesLastSyncDateTime      :
creationType                    :
imAddresses                     : {admin@m365x99297270.onmicrosoft.com}
preferredLanguage               : en
mail                            : admin@M365x99297270.onmicrosoft.com
securityIdentifier              : S-1-12-1-2574072234-1301806508-533216682-2892133300
identities                      : {System.Collections.Hashtable}
consentProvidedForMinor         :
onPremisesUserPrincipalName     :
assignedLicenses                : {System.Collections.Hashtable, System.Collections.Hashtable, System.Collections.Hashtable, System.Collections.Hashtable...}
department                      :
jobTitle                        :
```

This example demonstrates how to retrieve the all owner of a specific group.  


### Example 3: Gets two group owners
```powershell
PS C:\>Get-EntraGroupOwner -ObjectId "c072b115-ed7b-47cb-90d3-d5019d8bfd51" -Top 2
```
```output
ageGroup                        :
onPremisesLastSyncDateTime      :
creationType                    :
imAddresses                     : {admin@m365x99297270.onmicrosoft.com}
preferredLanguage               : en
mail                            : admin@M365x99297270.onmicrosoft.com
securityIdentifier              : S-1-12-1-2574072234-1301806508-533216682-2892133300
identities                      : {System.Collections.Hashtable}
consentProvidedForMinor         :
onPremisesUserPrincipalName     :
assignedLicenses                : {System.Collections.Hashtable, System.Collections.Hashtable, System.Collections.Hashtable, System.Collections.Hashtable...}
department                      :
jobTitle                        :
proxyAddresses                  : {SMTP:admin@M365x99297270.onmicrosoft.com}
legalAgeGroupClassification     :
assignedPlans                   : {System.Collections.Hashtable, System.Collections.Hashtable, System.Collections.Hashtable, System.Collections.Hashtable...}
id                              : 996d39aa-fdac-4d97-aa3d-c81fb47362ac
```

This example demonstrates how to retrieve the top two owners of a specific group.  


## PARAMETERS

### -All
If true, return all group owners.
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
Specifies the ID of a group in Microsoft Entra ID.

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

[Add-EntraGroupOwner](Add-EntraGroupOwner.md)

[Remove-EntraGroupOwner](Remove-EntraGroupOwner.md)

