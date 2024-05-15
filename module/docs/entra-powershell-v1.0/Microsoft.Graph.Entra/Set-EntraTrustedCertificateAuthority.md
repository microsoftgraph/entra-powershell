---
title: Set-EntraTrustedCertificateAuthority
description: This article provides details on the Set-EntraTrustedCertificateAuthority command.

ms.service: entra
ms.subservice: powershell
ms.topic: reference
ms.date: 03/21/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Set-EntraTrustedCertificateAuthority

## SYNOPSIS
Updates a trusted certificate authority.

## SYNTAX

```powershell
Set-EntraTrustedCertificateAuthority 
 -CertificateAuthorityInformation <CertificateAuthorityInformation>
```

## DESCRIPTION
The Set-EntraTrustedCertificateAuthority cmdlet updates a trusted certificate authority in Microsoft Entra ID.

## EXAMPLES

### Example 1: Updates the trusted certificate authorities that are defined in your directory
```powershell
PS C:\> $cer = Set-EntraTrustedCertificateAuthority #Get the CertificateAuthorityInformation object
PS C:\> $cer[0].CrlDistributionPoint = "https://example.crl"
PS C:\> Set-EntraTrustedCertificateAuthority -CertificateAuthorityInformation $cer[0]
```

This command updates the trusted certificate authorities that are defined in your directory.

## PARAMETERS

### -CertificateAuthorityInformation
Specifies a CertificateAuthorityInformation object.

```yaml
Type: CertificateAuthorityInformation
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

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraTrustedCertificateAuthority](Get-EntraTrustedCertificateAuthority.md)

[New-EntraTrustedCertificateAuthority](New-EntraTrustedCertificateAuthority.md)

[Remove-EntraTrustedCertificateAuthority](Remove-EntraTrustedCertificateAuthority.md)

