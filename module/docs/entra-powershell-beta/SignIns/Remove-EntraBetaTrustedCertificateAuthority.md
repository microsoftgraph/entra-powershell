---
author: msewaweru
description: This article provides details on the Remove-EntraBetaTrustedCertificateAuthority command.
external help file: Microsoft.Entra.Beta.SignIns-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.Beta.SignIns
ms.author: eunicewaweru
ms.date: 07/04/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta.SignIns/Remove-EntraBetaTrustedCertificateAuthority
schema: 2.0.0
title: Remove-EntraBetaTrustedCertificateAuthority
---

# Remove-EntraBetaTrustedCertificateAuthority

## SYNOPSIS

Removes a trusted certificate authority.

## SYNTAX

```powershell
Remove-EntraBetaTrustedCertificateAuthority
 -CertificateAuthorityInformation <CertificateAuthorityInformation>
 [<CommonParameters>]
```

## DESCRIPTION

The `Remove-EntraBetaTrustedCertificateAuthority` cmdlet removes a trusted certificate authority from Microsoft Entra ID.

## EXAMPLES

### Example 1: Remove the trusted certificate authorities that are defined in your directory

```powershell
Connect-Entra -Scopes 'Organization.ReadWrite.All'
$cer = Get-EntraBetaTrustedCertificateAuthority #Get the CertificateAuthorityInformation object
Remove-EntraBetaTrustedCertificateAuthority -CertificateAuthorityInformation $cer[0]
```

```Output
Id
--
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb
```

This command deletes the trusted certificate authorities that are defined in your directory.

- `-CertificateAuthorityInformation` Parameter specifies a CertificateAuthorityInformation object.
It includes properties like `AuthorityType`, `CrlDistributionPoint`, `DeltaCrlDistributionPoint`, and `TrustedCertificate`.

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

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraBetaTrustedCertificateAuthority](Get-EntraBetaTrustedCertificateAuthority.md)

[New-EntraBetaTrustedCertificateAuthority](New-EntraBetaTrustedCertificateAuthority.md)

[Set-EntraBetaTrustedCertificateAuthority](Set-EntraBetaTrustedCertificateAuthority.md)
