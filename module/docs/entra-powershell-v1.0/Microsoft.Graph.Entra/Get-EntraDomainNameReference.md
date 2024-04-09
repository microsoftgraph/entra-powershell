---
title: Get-EntraDomainNameReference
description: This article provides details on the Get-EntraDomainNameReference command.

ms.service: active-directory
ms.topic: reference
ms.date: 03/16/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraDomainNameReference

## SYNOPSIS
This cmdlet retrieves the objects that are referenced with a given domain name.

## SYNTAX

```powershell
Get-EntraDomainNameReference 
 -Name <String> 
 [<CommonParameters>]
```

## DESCRIPTION
The Get-EntraDomainNameReference cmdlet retrieves the objects that are referenced with a given domain name.

## EXAMPLES

### Example 1: Retrieve the domain name reference objects for a domain
```powershell
PS C:\> Get-EntraDomainNameReference -Name M365x99297270.onmicrosoft.com
```

```output
ageGroup                        :
onPremisesLastSyncDateTime      :
creationType                    :
imAddresses                     : {}
preferredLanguage               :
mail                            : Hood@M365x99297270.OnMicrosoft.com
securityIdentifier              : S-1-12-1-2465307174-1183218137-1495780736-693310342
identities                      : {@{signInType=userPrincipalName; issuer=M365x99297270.onmicrosoft.com; issuerAssignedId=Hood@M365x99297270.OnMicrosoft.com}}
consentProvidedForMinor         :
onPremisesUserPrincipalName     :
assignedLicenses                : {}
department                      :
jobTitle                        :
proxyAddresses                  : {SMTP:Hood@M365x99297270.OnMicrosoft.com}
```

This example shows how to retrieve the domain name reference objects for a domain that is specified through the -Name parameter.

## PARAMETERS

### -Name
The name of the domain name for which the referenced objects are retrieved.

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String
## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
