---
title: Get-EntraDomainNameReference
description: This article provides details on the Get-EntraDomainNameReference command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraDomainNameReference

## Synopsis

This cmdlet retrieves the objects that are referenced with a given domain name.

## Syntax

```powershell
Get-EntraDomainNameReference 
 -Name <String> 
 [<CommonParameters>]
```

## Description

The `Get-EntraDomainNameReference` cmdlet retrieves the objects that are referenced with a given domain name.

The work or school account needs to belong to at least the Domain Name Administrator or Global Reader Microsoft Entra role.

## Examples

### Example 1: Retrieve the domain name reference objects for a domain

```powershell
 Connect-Entra -Scopes 'Domain.Read.All'
 Get-EntraDomainNameReference -Name contoso.com
```

```Output
ageGroup                        :
onPremisesLastSyncDateTime      :
creationType                    :
imAddresses                     : {}
preferredLanguage               :
mail                            : Hood@contoso.com
securityIdentifier              : A-1-22-3-4444444444-5555555555-6666666-7777777777
identities                      : {@{signInType=userPrincipalName; issuer=contoso.com; issuerAssignedId=Hood@contoso.com}}
consentProvidedForMinor         :
onPremisesUserPrincipalName     :
assignedLicenses                : {}
department                      :
jobTitle                        :
proxyAddresses                  : {SMTP:Hood@contoso.com}
```

This example shows how to retrieve the domain name reference objects for a domain that is specified through the -Name parameter.

## Parameters

### -Name

The name of the domain name for which the referenced objects are retrieved.

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

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

### System.String

## Outputs

### System.Object

## Notes

## Related Links
