---
title: Get-EntraDomainFedrationSettings
description: This article provides details on the Get-EntraDomainFedrationSettings command.

ms.service: active-directory
ms.topic: reference
ms.date: 03/28/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra-help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraDomainFedrationSettings

## Synopsis
Gets key settings for a federated domain.

## Syntax

```powershell
Get-EntraDomainFedrationSettings 
 -DomainName <String>
 [-TenantId <Guid>]
 [<CommonParameters>]
```

## Description
The Get-EntraDomainFederationSettings cmdlet gets key settings from Microsoft Entra ID.
Use the [Get-EntraFederationProperty](./Get-EntraFederationProperty.md) cmdlet to get settings for both Microsoft Entra ID and the Entra ID Federation Services server.

## Examples

### Example 1: Get federation settings for specified domain
```powershell
PS C:\> Get-EntraDomainFederationSettings -DomainName contoso.com
```

This command gets federation settings for specified domain.

## Parameters

### -DomainName
The fully qualified domain name to retrieve.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -TenantId
The unique ID of the tenant to perform the operation on.
If this isn't provided then the value defaults to the tenant of the current user.
This parameter is only applicable to partner users.

```yaml
Type: Guid
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

### Microsoft.Online.Administration.DomainFederationSettings
### This cmdlet returns the following settings:
###         ActiveLogOnUri
###         FederationBrandName
###         IssuerUri
###         LogOffUri
###         MetadataExchangeUri
###         NextSigningCertificate
###         PassiveLogOnUri
###         SigningCertificate
## Notes

## Related LINKS
