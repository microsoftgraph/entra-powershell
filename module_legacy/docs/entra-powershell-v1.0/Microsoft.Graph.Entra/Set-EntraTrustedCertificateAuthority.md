---
title: Set-EntraTrustedCertificateAuthority
description: This article provides details on the Set-EntraTrustedCertificateAuthority command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Set-EntraTrustedCertificateAuthority

schema: 2.0.0
---

# Set-EntraTrustedCertificateAuthority

## Synopsis

Updates a trusted certificate authority.

## Syntax

```powershell
Set-EntraTrustedCertificateAuthority
 -CertificateAuthorityInformation <CertificateAuthorityInformation>
```

## Description

The `Set-EntraTrustedCertificateAuthority` cmdlet updates a trusted certificate authority in Microsoft Entra ID.

## Examples

### Example 1: Updates the trusted certificate authorities that are defined in your directory

```powershell
Connect-Entra -Scopes 'Organization.ReadWrite.All'
$cer = Get-EntraTrustedCertificateAuthority #Get the CertificateAuthorityInformation object
$cer[0].CrlDistributionPoint = "https://example.crl"
Set-EntraTrustedCertificateAuthority -CertificateAuthorityInformation $cer[0]
```

```Output
Id
--
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb
```

This command updates the trusted certificate authorities that are defined in your directory.

- `-CertificateAuthorityInformation` Parameter specifies a CertificateAuthorityInformation object.

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

[New-EntraTrustedCertificateAuthority](New-EntraTrustedCertificateAuthority.md)

[Remove-EntraTrustedCertificateAuthority](Remove-EntraTrustedCertificateAuthority.md)
