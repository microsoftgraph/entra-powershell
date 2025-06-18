---
description: This article provides details on the Get-EntraBetaTrustedCertificateAuthority command.
external help file: Microsoft.Entra.Beta.SignIns-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 08/13/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Get-EntraBetaTrustedCertificateAuthority
schema: 2.0.0
title: Get-EntraBetaTrustedCertificateAuthority
---

# Get-EntraBetaTrustedCertificateAuthority

## Synopsis

Gets the trusted certificate authority.

## Syntax

```powershell
Get-EntraBetaTrustedCertificateAuthority
 [-TrustedIssuer <String>]
 [-TrustedIssuerSki <String>]
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

The `Get-EntraBetaTrustedCertificateAuthority` cmdlet gets the trusted certificate authority in Microsoft Entra ID.

## Examples

### Example 1: Retrieve the trusted certificate authorities that are defined in your directory

```powershell
Connect-Entra -Scopes 'Organization.Read.All'
Get-EntraBetaTrustedCertificateAuthority
```

```Output
AuthorityType             : RootAuthority
CrlDistributionPoint      : https://example3.crl
DeltaCrlDistributionPoint : https://example3.crl
TrustedCertificate        : {48, 130, 3, 0…}
TrustedIssuer             : CN=mscmdlet
TrustedIssuerSki          : 4BA2D7AC2A5DF47C70E19E61EDFB4E62B3BF67FD
```

This command retrieves the trusted certificate authorities that are defined in your directory.

### Example 2: Retrieve the trusted certificate authorities that are defined in your directory based on TrustedIssuer

```powershell
Connect-Entra -Scopes 'Organization.Read.All'
Get-EntraBetaTrustedCertificateAuthority -TrustedIssuer 'CN=mscmdlet'
```

```Output
AuthorityType             : RootAuthority
CrlDistributionPoint      : https://example3.crl
DeltaCrlDistributionPoint : https://example3.crl
TrustedCertificate        : {48, 130, 3, 0…}
TrustedIssuer             : CN=mscmdlet
TrustedIssuerSki          : 4BA2D7AC2A5DF47C70E19E61EDFB4E62B3BF67FD
```

This command retrieves the trusted certificate authorities that are defined in your directory based on TrustedIssuer.

- `-TrustedIssuer` parameter specifies the trusted issuer.

### Example 3: Retrieve the trusted certificate authorities that are defined in your directory based on TrustedIssuerSki

```powershell
Connect-Entra -Scopes 'Organization.Read.All'
Get-EntraBetaTrustedCertificateAuthority -TrustedIssuerSki '4BA2D7AC2A5DF47C70E19E61EDFB4E62B3BF67FD'
```

```Output
AuthorityType             : RootAuthority
CrlDistributionPoint      : https://example3.crl
DeltaCrlDistributionPoint : https://example3.crl
TrustedCertificate        : {48, 130, 3, 0…}
TrustedIssuer             : CN=mscmdlet
TrustedIssuerSki          : 4BA2D7AC2A5DF47C70E19E61EDFB4E62B3BF67FD
```

This command retrieves the trusted certificate authorities that are defined in your directory based on TrustedIssuerSki.

- `-TrustedIssuerSki` parameter specifies the trusted issuer ski.

## Parameters

### -TrustedIssuer

Specifies a trusted issuer.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -TrustedIssuerSki

Specifies a trusted issuer ski.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Property

Specifies properties to be returned.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases: Select

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related links

[New-EntraBetaTrustedCertificateAuthority](New-EntraBetaTrustedCertificateAuthority.md)

[Set-EntraBetaTrustedCertificateAuthority](Set-EntraBetaTrustedCertificateAuthority.md)

[Remove-EntraBetaTrustedCertificateAuthority](Remove-EntraBetaTrustedCertificateAuthority.md)
