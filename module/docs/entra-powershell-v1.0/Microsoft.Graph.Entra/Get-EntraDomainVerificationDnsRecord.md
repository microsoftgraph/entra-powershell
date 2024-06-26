---
title: Get-EntraDomainVerificationDnsRecord.
description: This article provides details on the Get-EntraDomainVerificationDnsRecord command.

ms.service: entra
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

```powershell
Get-EntraDomainVerificationDnsRecord 
 -Name <String> 
 [<CommonParameters>]
```

## DESCRIPTION

Gets the domain's verification records from the `verificationDnsRecords` navigation property.

You can't use the domain with your Microsoft Entra ID tenant until you have successfully verified that you own the domain.

To verify the ownership of the domain, you need to first retrieve a set of domain verification records that you need to add to the zone file of the domain. This can be done through the domain registrar or DNS server configuration.

Root domains require verification. For example, contoso.com requires verification. If a root domain is verified, subdomains of the root domain are automatically verified. For example, subdomain.contoso.com is automatically be verified if contoso.com has been verified.

The work or school account needs to belong to at least the Domain Name Administrator or Global Reader Microsoft Entra role.

## EXAMPLES

### Example 1: Retrieve the domain verification DNS record

```powershell
Connect-Entra -Scopes 'Domain.Read.All'
Get-EntraDomainVerificationDnsRecord -Name mail.contoso.com
```

```Output
Id                                   IsOptional Label                              RecordType SupportedService Ttl
--                                   ---------- -----                              ---------- ---------------- ---
aaaa0000-bb11-2222-33cc-444444dddddd False      mail.contoso.com Txt        Email            3600
bbbb1111-cc22-3333-44dd-555555eeeeee False      mail.contoso.com Mx         Email            3600
```

This example shows how to retrieve the Domain verification DNS records for a domain with the given name.

## PARAMETERS

### -Name

The domain name for which the domain verification Domain Name System (DNS) records are to be retrieved.

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

## INPUTS

### System.String

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS
