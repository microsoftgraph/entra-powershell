---
title: Remove-EntraTrustedCertificateAuthority
description: This article provides details on the Remove-EntraTrustedCertificateAuthority command.

ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Entra.SignIns-Help.xml
Module Name: Microsoft.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Remove-EntraTrustedCertificateAuthority

schema: 2.0.0
---

# Remove-EntraTrustedCertificateAuthority

## Synopsis

Removes a trusted certificate authority.

## Syntax

```powershell
Remove-EntraTrustedCertificateAuthority
 -CertificateAuthorityInformation <CertificateAuthorityInformation>
 [<CommonParameters>]
```

## Description

The `Remove-EntraTrustedCertificateAuthority` cmdlet removes a trusted certificate authority from Microsoft Entra ID.

## Examples

### Example 1: Remove the trusted certificate authorities that are defined in your directory

```powershell
Connect-Entra -Scopes 'Organization.ReadWrite.All'
$cer = Get-EntraTrustedCertificateAuthority #Get the CertificateAuthorityInformation object
Remove-EntraTrustedCertificateAuthority -CertificateAuthorityInformation $cer[0]
```

```Output
Id
--
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb
```

This command deletes the trusted certificate authorities that are defined in your directory.

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

## Related links

[Get-EntraTrustedCertificateAuthority](Get-EntraTrustedCertificateAuthority.md)

[New-EntraTrustedCertificateAuthority](New-EntraTrustedCertificateAuthority.md)

[Set-EntraTrustedCertificateAuthority](Set-EntraTrustedCertificateAuthority.md)
