---
title: Get-EntraBetaDomainServiceConfigurationRecord
description: This article provides details on the Get-EntraBetaDomainServiceConfigurationRecord command.


ms.topic: reference
ms.date: 07/31/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Get-EntraBetaDomainServiceConfigurationRecord

schema: 2.0.0
---

# Get-EntraBetaDomainServiceConfigurationRecord

## Synopsis

Gets the domain's service configuration records from the `serviceConfigurationRecords` navigation property.

## Syntax

```powershell
Get-EntraBetaDomainServiceConfigurationRecord
 -Name <String>
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

Gets the domain's service configuration records from the `serviceConfigurationRecords` navigation property.

After you have successfully verified the ownership of a domain and you have indicated what services you plan to use with the domain, you can request Microsoft Entra ID to return you a set of DNS records which you need to add to the zone file of the domain so that the services can work properly with your domain.

## Examples

### Example 1: Retrieve domain service configuration records by Name

```powershell
Connect-Entra -Scopes 'Domain.Read.All'
Get-EntraBetaDomainServiceConfigurationRecord -Name 'test.mail.contoso.com'
```

```Output
Id                                   IsOptional Label                                            RecordType SupportedService           Ttl
--                                   ---------- -----                                            ---------- ----------------           ---
aaaa0000-bb11-2222-33cc-444444dddddd False      test.mail.contoso.com                        Mx         Email                      3600
bbbb1111-cc22-3333-44dd-555555eeeeee False      test.mail.contoso.com                        Txt        Email                      3600
cccc2222-dd33-4444-55ee-666666ffffff False      autodiscover.test.mail.contoso.com           CName      Email                      3600
dddd3333-ee44-5555-66ff-777777aaaaaa False      msoid.test.mail.contoso.com                  CName      OrgIdAuthentication        3600
eeee4444-ff55-6666-77aa-888888bbbbbb False      enterpriseregistration.test.mail.contoso.com CName      Intune                     3600
ffff5555-aa66-7777-88bb-999999cccccc False      enterpriseenrollment.test.mail.contoso.com   CName      Intune                     3600
```

This example shows how to retrieve the Domain service configuration records for a domain with the given name.

- `-Name` parameter specifies domain name for which the domain service configuration records are to be retrieved.

## Parameters

### -Name

The name of the domain for which the domain service configuration records are to be retrieved.

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
Aliases:

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
