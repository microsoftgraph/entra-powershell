---
title: Get-EntraDomainServiceConfigurationRecord.
description: This article provides details on the Get-EntraDomainServiceConfigurationRecord command.

ms.service: active-directory
ms.topic: reference
ms.date: 03/04/2023
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraDomainServiceConfigurationRecord

## SYNOPSIS
Gets the domain's service configuration records from the serviceConfigurationRecords navigation property.

## SYNTAX

```
Get-EntraDomainServiceConfigurationRecord 
 -Name <String> 
 [<CommonParameters>]
```

## DESCRIPTION
Gets the domain's service configuration records from the serviceConfigurationRecords navigation property. 
After you have successfully verified the ownership of a domain and you have indicated what services you plan to use with the domain, you can request Microsoft Entra ID to return you a set of DNS records which you need to add to the zone file of the domain so that the services can work properly with your domain.

## EXAMPLES

### Example 1: Retrieve domain service configuration records by name
```
PS C:\WINDOWS\system32> Get-EntraDomainServiceConfigurationRecord -name test.mail.onmicrosoft.com

Id                                   IsOptional Label                                            RecordType SupportedService           Ttl
--                                   ---------- -----                                            ---------- ----------------           ---
2b672ab0-0bee-476f-b334-be436f2449bd False      test.mail.onmicrosoft.com                        Mx         Email                      3600
62bea837-a0d7-4466-b6d9-ff6bd1db8671 False      test.mail.onmicrosoft.com                        Txt        Email                      3600
eea5ce9e-8deb-4ab7-a114-13ed6215774f False      autodiscover.test.mail.onmicrosoft.com           CName      Email                      3600
2f9deed0-42e3-4f6d-ae82-495a7fde4da5 False      _sip._tls.test.mail.onmicrosoft.com              Srv        OfficeCommunicationsOnline 3600
e9046b54-7d0d-422f-9e50-c731b2a8cbd5 False      sip.test.mail.onmicrosoft.com                    CName      OfficeCommunicationsOnline 3600
a2a182ac-0b69-44c3-96c6-5d6bbbe9ee99 False      lyncdiscover.test.mail.onmicrosoft.com           CName      OfficeCommunicationsOnline 3600
b457cd8d-e1bb-4ea9-ae65-cb31c551e27a False      _sipfederationtls._tcp.test.mail.onmicrosoft.com Srv        OfficeCommunicationsOnline 3600
d9113a42-7876-4ff7-8bd6-e2596119517d False      test.mail.onmicrosoft.com                        CName      SharepointDefaultDomain    3600
16f3816b-1105-4764-a195-c249aae14401 False      msoid.test.mail.onmicrosoft.com                  CName      OrgIdAuthentication        3600
db0cde09-f798-4bd7-bbb2-1d19926ca807 False      enterpriseregistration.test.mail.onmicrosoft.com CName      Intune                     3600
ef4f8e4c-f124-446d-8301-2586447cff67 False      enterpriseenrollment.test.mail.onmicrosoft.com   CName      Intune                     3600
```

This command retrieve the domain service configuration records for a domain with the given name.

## PARAMETERS

### -Name
The name of the domain for which the domain service configuration records are to be retrieved

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String
## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
