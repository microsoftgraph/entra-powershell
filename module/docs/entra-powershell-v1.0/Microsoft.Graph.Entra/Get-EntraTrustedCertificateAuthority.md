---
title: Get-EntraTrustedCertificateAuthority
description: This article provides details on the Get-EntraTrustedCertificateAuthority command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Get-EntraTrustedCertificateAuthority

schema: 2.0.0
---

# Get-EntraTrustedCertificateAuthority

## Synopsis

Gets the trusted certificate authority.

## Syntax

```powershell
Get-EntraTrustedCertificateAuthority
 [-TrustedIssuerSki <String>]
 [-TrustedIssuer <String>]
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

The `Get-EntraTrustedCertificateAuthority` cmdlet gets the trusted certificate authority in Microsoft Entra ID.

## Examples

### Example 1: Retrieve the trusted certificate authorities that are defined in your directory

```powershell
Connect-Entra -Scopes 'Organization.Read.All'
Get-EntraTrustedCertificateAuthority
```

```Output
AuthorityType             : RootAuthority
CrlDistributionPoint      : https://example.crl1
DeltaCrlDistributionPoint :
TrustedCertificate        : {48, 130, 3, 4...}
TrustedIssuer             : CN=example.azure.com, O=MSIT. Ltd, L=Redmond, C=US
TrustedIssuerSki          : E48DBC5D4AF447E9D9D4A5440D4096C70AF5352A

AuthorityType             : RootAuthority
CrlDistributionPoint      : https://example.crl
DeltaCrlDistributionPoint : https://deltaexample.crl
TrustedCertificate        : {48, 130, 3, 4...}
TrustedIssuer             : CN=example.azure.com, O=MSIT. Ltd, L=Redmond, C=US
TrustedIssuerSki          : 69506400C9806497DCB48F160C31CFFEA87E544C

AuthorityType             : RootAuthority
CrlDistributionPoint      : https://example.crl
DeltaCrlDistributionPoint :
TrustedCertificate        : {48, 130, 3, 0...}
TrustedIssuer             : CN=example1.azure.com, O=MSIT. Ltd, L=Redmond, C=US
TrustedIssuerSki          : 4BA2D7AC2A5DF47C70E19E61EDFB4E62B3BF67FD
```

This command retrieves the trusted certificate authorities that are defined in your directory.

### Example 2: Retrieve the trusted certificate authorities that are defined in your directory based on TrustedIssuer

```powershell
Connect-Entra -Scopes 'Organization.Read.All'
Get-EntraTrustedCertificateAuthority -TrustedIssuer 'CN=mscmdlet'
```

```Output
AuthorityType             : RootAuthority
CrlDistributionPoint      : https://example.crl1
DeltaCrlDistributionPoint :
TrustedCertificate        : {48, 130, 3, 4...}
TrustedIssuer             : CN=example.azure.com, O=MSIT. Ltd, L=Redmond, C=US
TrustedIssuerSki          : E48DBC5D4AF447E9D9D4A5440D4096C70AF5352A

AuthorityType             : RootAuthority
CrlDistributionPoint      : https://example.crl
DeltaCrlDistributionPoint : https://deltaexample.crl
TrustedCertificate        : {48, 130, 3, 4...}
TrustedIssuer             : CN=example.azure.com, O=MSIT. Ltd, L=Redmond, C=US
TrustedIssuerSki          : 69506400C9806497DCB48F160C31CFFEA87E544C
```

This command retrieves the trusted certificate authorities that are defined in your directory based on TrustedIssuer.

- `-TrustedIssuer` parameter specifies the trusted issuer.

### Example 3: Retrieve the trusted certificate authorities that are defined in your directory based on TrustedIssuerSki

```powershell
Connect-Entra -Scopes 'Organization.Read.All'
Get-EntraTrustedCertificateAuthority -TrustedIssuerSki 4BA2D7AC2A5DF47C70E19E61EDFB4E62B3BF67FD
```

```Output
AuthorityType             : RootAuthority
CrlDistributionPoint      : https://example.crl
DeltaCrlDistributionPoint :
TrustedCertificate        : {48, 130, 3, 0...}
TrustedIssuer             : CN=example1.azure.com, O=MSIT. Ltd, L=Redmond, C=US
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
Aliases:

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

## Related Links

[New-EntraTrustedCertificateAuthority](New-EntraTrustedCertificateAuthority.md)

[Remove-EntraTrustedCertificateAuthority](Remove-EntraTrustedCertificateAuthority.md)

[Set-EntraTrustedCertificateAuthority](Set-EntraTrustedCertificateAuthority.md)
