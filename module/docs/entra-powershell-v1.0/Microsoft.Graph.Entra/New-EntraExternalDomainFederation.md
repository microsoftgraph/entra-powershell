---
title: New-EntraExternalDomainFederation.
description: This article provides details on the New-EntraExternalDomainFederation command.
ms.service: entra
ms.topic: reference
ms.date: 06/13/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# New-EntraExternalDomainFederation

## SYNOPSIS

Create a new externalDomainFederation in Microsoft Entra ID.

## SYNTAX

```powershell
New-EntraExternalDomainFederation
 [-ExternalDomainName <String>]
 [-FederationSettings <DomainFederationSettings>] 
 [<CommonParameters>]
```

## DESCRIPTION

This New-EntraExternalDomainFederation cmdlet create a new externalDomainFederation in Microsoft Entra ID.

## EXAMPLES

### Example 1: Create a new external domain federation

```powershell
Connect-Entra -Scopes 'IdentityProvider.ReadWrite.All'
$federationSettings = New-Object Microsoft.Open.AzureAD.Model.DomainFederationSettings
$federationSettings.ActiveLogOnUri='https://adfs.com/adfs/ls'
$federationSettings.IssuerUri = 'http://adfs.com/adfs/services/trust'
$federationSettings.LogOffUri = $federationSettings.ActiveLogOnUri
$federationSettings.FederationBrandName = 'Contoso Misa1 US'
$federationSettings.MetadataExchangeUri='http://adfs.com/FederationMetadata.xml'
$federationSettings.PassiveLogOnUri=$federationSettings.ActiveLogOnUri
$federationSettings.PreferredAuthenticationProtocol='WsFed'
$federationSettings.SigningCertificate='X509 signing public key'
New-EntraExternalDomainFederation -ExternalDomainName 'adfs.com' -FederationSettings $federationSettings
```

This command creates a new external federation domain settings.

## PARAMETERS

### -ExternalDomainName

The unique identifer of an externalDomainFederation in Microsoft Entra ID.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FederationSettings

The federation settings for the external domain.

```yaml
Type: DomainFederationSettings
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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraExternalDomainFederation](Get-EntraApplicationPolicy.md)
