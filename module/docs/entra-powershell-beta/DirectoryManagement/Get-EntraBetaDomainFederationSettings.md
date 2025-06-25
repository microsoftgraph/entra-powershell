---
author: msewaweru
description: This article provides details on the Get-EntraBetaDomainFederationSettings command.
external help file: Microsoft.Entra.Beta.DirectoryManagement-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 08/19/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Get-EntraBetaDomainFederationSettings
schema: 2.0.0
title: Get-EntraBetaDomainFederationSettings
---

# Get-EntraBetaDomainFederationSettings

## Synopsis

Retrieves settings for a federated domain.

## Syntax

```powershell
Get-EntraBetaDomainFederationSettings
 -DomainName <String>
 [-TenantId <String>]
 [<CommonParameters>]
```

## Description

The `Get-EntraBetaDomainFederationSettings` cmdlet gets key settings from Microsoft Entra ID.

Use the `Get-EntraBetaFederationProperty` cmdlet to get settings for both Microsoft Entra ID and the Entra ID Federation Services server.

For delegated scenarios, the calling user must be assigned at least one of the following Microsoft Entra roles:

- Global Reader
- Security Reader
- Domain Name Administrator
- External Identity Provider Administrator
- Hybrid Identity Administrator
- Security Administrator

## Examples

### Example 1: Get federation settings for specified domain

```powershell
Connect-Entra -Scopes 'Domain.Read.All'
Get-EntraBetaDomainFederationSettings -DomainName 'contoso.com'
```

This command gets federation settings for specified domain.

- `-DomainName` parameter specifies the fully qualified domain name to retrieve.

## Parameters

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

The unique ID of the tenant to perform the operation on. This parameter provides compatibility with Azure AD and MSOnline for partner scenarios. TenantID is the signed-in user's tenant ID.

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

## Inputs

## Outputs

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

## Notes

## Related links

[Set-EntraBetaDomainFederationSettings](Set-EntraBetaDomainFederationSettings.md)
