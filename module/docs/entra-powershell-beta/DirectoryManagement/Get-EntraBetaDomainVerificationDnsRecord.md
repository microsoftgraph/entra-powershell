---
title: Get-EntraBetaDomainVerificationDnsRecord
description: This article provides details on the Get-EntraBetaDomainVerificationDnsRecord command.


ms.topic: reference
ms.date: 08/08/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Entra.Beta.DirectoryManagement-Help.xml
Module Name: Microsoft.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Get-EntraBetaDomainVerificationDnsRecord

schema: 2.0.0
---

# Get-EntraBetaDomainVerificationDnsRecord

## Synopsis

Retrieve the domain verification DNS record for a domain.

## Syntax

```powershell
Get-EntraBetaDomainVerificationDnsRecord
 -Name <String>
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

Gets the domain's verification records from the `verificationDnsRecords` navigation property.

You can't use the domain with your Microsoft Entra ID tenant until you have successfully verified that you own the domain.

To verify the ownership of the domain, you need to first retrieve a set of domain verification records that you need to add to the zone file of the domain. This can be done through the domain registrar or DNS server configuration.

Root domains require verification. For example, contoso.com requires verification. If a root domain is verified, subdomains of the root domain are automatically verified. For example, subdomain.contoso.com is automatically be verified if contoso.com has been verified.

In delegated scenarios, the signed-in user must have either a supported Microsoft Entra role or a custom role with the necessary permissions. The minimum roles required for this operation are:

- Domain Name Administrator
- Global Reader

## Examples

### Example 1: Retrieve the domain verification DNS record

```powershell
Connect-Entra -Scopes 'Domain.Read.All'
Get-EntraBetaDomainVerificationDnsRecord -Name mail.contoso.com
```

```Output
Id                                   IsOptional Label       RecordType SupportedService Ttl
--                                   ---------- -----       ---------- ---------------- ----
aaaabbbb-0000-cccc-1111-dddd2222eeee False      contoso.com Txt        Email            3600
aaaabbbb-1111-cccc-1111-dddd2222eeee False      contoso.com Mx         Email            3600
```

This example shows how to retrieve the Domain verification DNS records for a domain with the given name.

## Parameters

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

### -Property

Specifies properties to be returned.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases: Select

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

### System.String

## Outputs

### System.Object

## Notes

## Related links
