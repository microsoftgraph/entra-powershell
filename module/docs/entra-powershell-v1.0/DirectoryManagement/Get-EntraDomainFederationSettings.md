---
author: msewaweru
description: This article provides details on the Get-EntraDomainFederationSettings command.
external help file: Microsoft.Entra.DirectoryManagement-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.DirectoryManagement
ms.author: eunicewaweru
ms.date: 06/26/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.DirectoryManagement/Get-EntraDomainFederationSettings
schema: 2.0.0
title: Get-EntraDomainFederationSettings
---

# Get-EntraDomainFederationSettings

## SYNOPSIS

Retrieves settings for a federated domain.

## SYNTAX

```powershell
Get-EntraDomainFederationSettings
 -DomainName <String>
 [-TenantId <String>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Get-EntraDomainFederationSettings` cmdlet gets key settings from Microsoft Entra ID.

Use the `Get-EntraFederationProperty` cmdlet to get settings for both Microsoft Entra ID and the Entra ID Federation Services server.

For delegated scenarios, the calling user must be assigned at least one of the following Microsoft Entra roles:

- Global Reader
- Security Reader
- Domain Name Administrator
- External Identity Provider Administrator
- Hybrid Identity Administrator
- Security Administrator

## EXAMPLES

### Example 1: Get federation settings for specified domain

```powershell
Connect-Entra -Scopes 'Domain.Read.All'
Get-EntraDomainFederationSettings -DomainName 'contoso.com'
```

This command gets federation settings for specified domain.

- `-DomainName` parameter specifies the fully qualified domain name to retrieve.

## PARAMETERS

### -DomainName

The fully qualified domain name to retrieve.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -TenantId

The unique ID of the tenant to perform the operation on. If this isn't provided, then the value will default to the tenant of the current user. This parameter is only applicable to partner users.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Microsoft.Online.Administration.DomainFederationSettings

### This cmdlet returns the following settings

### ActiveLogOnUri

### FederationBrandName

### IssuerUri

### LogOffUri

### MetadataExchangeUri

### NextSigningCertificate

### PassiveLogOnUri

### SigningCertificate

## NOTES

## RELATED LINKS
