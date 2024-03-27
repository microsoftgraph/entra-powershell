---
title: Get-EntraDomainVerificationDnsRecord.
description: This article provides details on the Get-EntraDomainVerificationDnsRecord command.

ms.service: active-directory
ms.topic: reference
ms.date: 03/04/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraDomainVerificationDnsRecord

## SYNOPSIS
Retrieve the domain verification DNS record for a domain.

## SYNTAX

```
Get-EntraDomainVerificationDnsRecord 
 -Name <String> 
 [<CommonParameters>]
```

## DESCRIPTION
Gets the domain's verification records from the verificationDnsRecords navigation property. 
You can't use the domain with your Microsoft Entra ID tenant until you have successfully verifies that you own the domain.
To verify the ownership of the domain, you need to first retrieve a set of domain verification records that you need to add to the zone file of the domain.

## EXAMPLES

### Example 1: Retrieve the domain verification DNS record
```powershell
PS C:\WINDOWS\system32> Get-EntraDomainVerificationDnsRecord -Name M365x99297270.mail.onmicrosoft.com
```
```output
Id                                   IsOptional Label                              RecordType SupportedService Ttl
--                                   ---------- -----                              ---------- ---------------- ---
aceff52c-06a5-447f-ac5f-256ad243cc5c False      M365x99297270.mail.onmicrosoft.com Txt        Email            3600
5fbde38c-0865-497f-82b1-126f596bcee9 False      M365x99297270.mail.onmicrosoft.com Mx         Email            3600
```

This example shows how to retrieve the Domain verification DNS records for a domain with the given name.  
This command retrieves the domain verification DNS records for the given domain name.

## PARAMETERS

### -Name
The domain name for which the domain verification Domain Name System (DNS) records are to be retrieved.

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
