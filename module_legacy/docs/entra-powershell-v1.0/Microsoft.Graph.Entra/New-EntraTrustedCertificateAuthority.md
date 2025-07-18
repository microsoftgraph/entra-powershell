---
title: New-EntraTrustedCertificateAuthority
description: This article provides details on the New-EntraTrustedCertificateAuthority command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: mwongerapk
author: msewaweru

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/New-EntraTrustedCertificateAuthority

schema: 2.0.0
---

# New-EntraTrustedCertificateAuthority

## Synopsis

Creates a trusted certificate authority.

## Syntax

```powershell
New-EntraTrustedCertificateAuthority
 -CertificateAuthorityInformation <CertificateAuthorityInformation>
 [<CommonParameters>]
```

## Description

The `New-EntraTrustedCertificateAuthority` cmdlet creates a trusted certificate authority in Microsoft Entra ID.

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
Id
--
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb
```

This command creates the trusted certificate authorities in your directory.

- `-CertificateAuthorityInformation` Parameter specifies a CertificateAuthorityInformation object.
It includes properties like `AuthorityType`, `CrlDistributionPoint`, `DeltaCrlDistributionPoint`, and `TrustedCertificate`.

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
