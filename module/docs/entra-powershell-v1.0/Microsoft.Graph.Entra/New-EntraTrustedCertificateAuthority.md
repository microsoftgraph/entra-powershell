---
title: New-EntraTrustedCertificateAuthority
description: This article provides details on the New-EntraTrustedCertificateAuthority command.

ms.service: entra
ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# New-EntraTrustedCertificateAuthority

## Synopsis

creates a trusted certificate authority.

## Syntax

```powershell
New-EntraTrustedCertificateAuthority 
 -CertificateAuthorityInformation <CertificateAuthorityInformation>
 [<CommonParameters>]
```

## Description

the New-EntraTrustedCertificateAuthority cmdlet creates a trusted certificate authority in Microsoft Entra ID.

## Examples

### Example 1: Creates the trusted certificate authorities in your directory

```powershell
Connect-Entra -Scopes 'Organization.ReadWrite.All'

$new_ca = New-Object -TypeName Microsoft.Open.AzureAD.Model.CertificateAuthorityInformation #Create CertificateAuthorityInformation object
$new_ca.AuthorityType = "RootAuthority"
$new_ca.CrlDistributionPoint = "https://example.crl"
$new_ca.DeltaCrlDistributionPoint = "https://deltaexample.crl"
$new_ca.TrustedCertificate = "Path to .cer file(including cer file name)"
New-EntraTrustedCertificateAuthority -CertificateAuthorityInformation $new_ca
```

```Output
Id                                   CertificateAuthorities
--                                   ----------------------
0a0a0a0a-1111-bbbb-2222-3c3c3c3c3c3c {class CertificateAuthorityInformation {...
```

This command creates the trusted certificate authorities in your directory.

## Parameters

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

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related Links

[Get-EntraTrustedCertificateAuthority](Get-EntraTrustedCertificateAuthority.md)

[Remove-EntraTrustedCertificateAuthority](Remove-EntraTrustedCertificateAuthority.md)

[Set-EntraTrustedCertificateAuthority](Set-EntraTrustedCertificateAuthority.md)
