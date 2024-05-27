---
title: Get-EntraGroupOwner.
description: This article provides details on the Get-EntraGroupOwner command.

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
Connect-Entra -Scopes 'GroupMember.Read.All'
Get-EntraGroupOwner -ObjectId '22222222-2222-2222-2222-222222222222'
```

```output
ageGroup                        :
onPremisesLastSyncDateTime      :
creationType                    :
imAddresses                     : {adellV@contoso.com}
preferredLanguage               : en
mail                            : adellv@contoso.com
securityIdentifier              : S-1-12-1-4444444-7777777-234234234-66666666666
identities                      : {@{signInType=userPrincipalName; issuer=contoso.com; issuerAssignedId=adellv@contoso.com}}
consentProvidedForMinor         :
onPremisesUserPrincipalName     :
```

This example demonstrates how to retrieve the owner of a specific group.  

### Example 2: Gets all group owners

```powershell
Connect-Entra -Scopes 'GroupMember.Read.All'
Get-EntraGroupOwner -ObjectId '44444444-4444-4444-4444-444444444444' -All
```

```output
ageGroup                        :
onPremisesLastSyncDateTime      :
creationType                    :
imAddresses                     : {becky@contoso.com}
preferredLanguage               : en
mail                            : becky@contoso.com
securityIdentifier              : S-1-12-1-55555555-66666666-9999999-23232323
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
Get-EntraGroupOwner -ObjectId '55555555-5555-5555-5555-555555555555' -Top 2
```

```output
ageGroup                        :
onPremisesLastSyncDateTime      :
creationType                    :
imAddresses                     : {jdavid@contoso.com}
preferredLanguage               : en
mail                            : jdavid@contoso.com
securityIdentifier              : S-1-12-1-22222222-13131313-55555555-333333333
identities                      : {System.Collections.Hashtable}
consentProvidedForMinor         :
onPremisesUserPrincipalName     :
assignedLicenses                : {System.Collections.Hashtable, System.Collections.Hashtable, System.Collections.Hashtable, System.Collections.Hashtable...}
department                      :
jobTitle                        :
proxyAddresses                  : {SMTP:jdavid@contoso.com}
legalAgeGroupClassification     :
assignedPlans                   : {System.Collections.Hashtable, System.Collections.Hashtable, System.Collections.Hashtable, System.Collections.Hashtable...}
id                              : 55555555-5555-5555-5555-555555555555
```

This example demonstrates how to retrieve the top two owners of a specific group.  

## PARAMETERS

### -All

If true, return all group owners.
If false, return the number of objects specified by the Top parameter.

```yaml
Type: System.Boolean
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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Add-EntraGroupOwner](Add-EntraGroupOwner.md)

[Remove-EntraGroupOwner](Remove-EntraGroupOwner.md)
