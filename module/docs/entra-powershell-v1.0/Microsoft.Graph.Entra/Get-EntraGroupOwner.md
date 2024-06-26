---
title: Get-EntraGroupOwner.
description: This article provides details on the Get-EntraGroupOwner command.

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

# Get-EntraGroupOwner

## Synopsis

gets an owner of a group.

## Syntax

```powershell
Get-EntraGroupOwner 
 -ObjectId <String>  
 [-All] 
 [-Top <Int32>] 
 [<CommonParameters>]
```

## Description

the Get-EntraGroupOwner cmdlet gets an owner of a group in Microsoft Entra ID.

## Examples

### Example 1: Get a group owner by ID

```powershell
Connect-Entra -Scopes 'GroupMember.Read.All'
Get-EntraGroupOwner -ObjectId 'vvvvvvvv-7777-9999-7777-jjjjjjjjjjjj'
```

```output
ageGroup                        :
onPremisesLastSyncDateTime      :
creationType                    :
imAddresses                     : {HaydenL@contoso.com}
preferredLanguage               : en
mail                            : HaydenL@contoso.com
securityIdentifier              : B-2-33-4-5555555555-6666666666-7777777-8888888888
identities                      : {@{signInType=userPrincipalName; issuer=contoso.com; issuerAssignedId=HaydenL@contoso.com}}
consentProvidedForMinor         :
onPremisesUserPrincipalName     :
```

This example demonstrates how to retrieve the owner of a specific group.  

### Example 2: Gets all group owners

```powershell
Connect-Entra -Scopes 'GroupMember.Read.All'
Get-EntraGroupOwner -ObjectId 'zzzzzzzz-6666-8888-9999-pppppppppppp' -All
```

```output
ageGroup                        :
onPremisesLastSyncDateTime      :
creationType                    :
imAddresses                     : {BlakeM@contoso.com}
preferredLanguage               : en
mail                            : BlakeM@contoso.com
securityIdentifier              : E-5-66-7-8888888888-9999999999-0000000-1111111111
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
Connect-Entra -Scopes 'GroupMember.Read.All'
Get-EntraGroupOwner -ObjectId 'vvvvvvvv-8888-9999-0000-jjjjjjjjjjjj' -Top 2
```

```output
ageGroup                        :
onPremisesLastSyncDateTime      :
creationType                    :
imAddresses                     : {QuinnA@contoso.com}
preferredLanguage               : en
mail                            : QuinnA@contoso.com
securityIdentifier              : D-4-55-6-7777777777-8888888888-9999999-0000000000
identities                      : {System.Collections.Hashtable}
consentProvidedForMinor         :
onPremisesUserPrincipalName     :
assignedLicenses                : {System.Collections.Hashtable, System.Collections.Hashtable, System.Collections.Hashtable, System.Collections.Hashtable...}
department                      :
jobTitle                        :
proxyAddresses                  : {SMTP:QuinnA@contoso.com}
legalAgeGroupClassification     :
assignedPlans                   : {System.Collections.Hashtable, System.Collections.Hashtable, System.Collections.Hashtable, System.Collections.Hashtable...}
id                              : tttttttt-0000-2222-0000-aaaaaaaaaaaa
```

This example demonstrates how to retrieve the top two owners of a specific group.  

## Parameters

### -All
List all pages.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```
### -ObjectId

Specifies the ID of a group in Microsoft Entra ID.

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

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related Links

[Add-EntraGroupOwner](Add-EntraGroupOwner.md)

[Remove-EntraGroupOwner](Remove-EntraGroupOwner.md)
