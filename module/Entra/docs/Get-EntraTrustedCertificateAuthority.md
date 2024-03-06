---
title: Get-EntraTrustedCertificateAuthority
description: This article provides details on the Get-EntraTrustedCertificateAuthority command.

ms.service: active-directory
ms.topic: reference
ms.date: 03/06/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraTrustedCertificateAuthority

## SYNOPSIS
Gets the trusted certificate authority.

## SYNTAX

```
Get-EntraTrustedCertificateAuthority [-TrustedIssuerSki <String>] [-TrustedIssuer <String>]
 [-InformationAction <ActionPreference>] [-InformationVariable <String>] [<CommonParameters>]
```

## DESCRIPTION
The Get-EntraTrustedCertificateAuthority cmdlet gets the trusted certificate authority in Microsoft Entra ID.

## EXAMPLES

### Example 1: Retrieve the trusted certificate authorities that are defined in your directory
```
PS C:\> Get-EntraTrustedCertificateAuthority

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

This command retrieve the trusted certificate authorities that are defined in your directory.

### Example 2: Retrieve the trusted certificate authorities that are defined in your directory based on TrustedIssuer
```
PS C:\> Get-EntraTrustedCertificateAuthority -TrustedIssuer "CN=example.azure.com, O=MSIT. Ltd, L=Redmond, C=US"

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

This command retrieve the trusted certificate authorities that are defined in your directory based on TrustedIssuer.

### Example 3: Retrieve the trusted certificate authorities that are defined in your directory based on TrustedIssuerSki
```
PS C:\> Get-EntraTrustedCertificateAuthority -TrustedIssuerSki 4BA2D7AC2A5DF47C70E19E61EDFB4E62B3BF67FD

AuthorityType             : RootAuthority
CrlDistributionPoint      : https://example.crl
DeltaCrlDistributionPoint :
TrustedCertificate        : {48, 130, 3, 0...}
TrustedIssuer             : CN=example1.azure.com, O=MSIT. Ltd, L=Redmond, C=US
TrustedIssuerSki          : 4BA2D7AC2A5DF47C70E19E61EDFB4E62B3BF67FD
```

This command retrieve the trusted certificate authorities that are defined in your directory based on TrustedIssuerSki.

## PARAMETERS

### -InformationAction
Specifies how this cmdlet responds to an information event.
The acceptable values for this parameter are:

- Continue
- Ignore
- Inquire
- SilentlyContinue
- Stop
- Suspend

```yaml
Type: ActionPreference
Parameter Sets: (All)
Aliases: infa

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InformationVariable
Specifies an information variable.

```yaml
Type: String
Parameter Sets: (All)
Aliases: iv

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TrustedIssuer
Specifies a trusted issuer.

```yaml
Type: String
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
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[New-EntraTrustedCertificateAuthority]()

[Remove-EntraTrustedCertificateAuthority]()

[Set-EntraTrustedCertificateAuthority]()

[Online help and examples for working with certificate authority](https://azure.microsoft.com/en-us/documentation/articles/active-directory-certificate-based-authentication-ios/)

