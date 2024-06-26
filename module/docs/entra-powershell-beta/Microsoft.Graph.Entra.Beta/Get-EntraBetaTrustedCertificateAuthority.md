---
External help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
Online version:
Schema: 2.0.0
---

# Get-EntraBetaTrustedCertificateAuthority

## Synopsis
Gets the trusted certificate authority.

## Syntax

```
Get-EntraBetaTrustedCertificateAuthority [-TrustedIssuer <String>] [-TrustedIssuerSki <String>]
 [<CommonParameters>]
```

## Description
The Get-EntraBetaTrustedCertificateAuthority cmdlet gets the trusted certificate authority in Azure Active Directory (AD).

## Examples

### Example 1: Retrieve the trusted certificate authorities that are defined in your directory
```
PS C:\> Get-EntraBetaTrustedCertificateAuthority
```

This command retrieve the trusted certificate authorities that are defined in your directory.

### Example 2: Retrieve the trusted certificate authorities that are defined in your directory based on TrustedIssuer
```
PS C:\> Get-EntraBetaTrustedCertificateAuthority -TrustedIssuer "CN=example.azure.com, O=MSIT. Ltd, L=Redmond, C=US"
```

This command retrieve the trusted certificate authorities that are defined in your directory based on TrustedIssuer.

### Example 3: Retrieve the trusted certificate authorities that are defined in your directory based on TrustedIssuerSki
```
PS C:\> Get-EntraBetaTrustedCertificateAuthority -TrustedIssuerSki 4BA2D7AC2A5DF47C70E19E61EDFB4E62B3BF67FD
```

This command retrieve the trusted certificate authorities that are defined in your directory based on TrustedIssuerSki.

## Parameters



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
@{Text=}

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related Links

[New-EntraBetaTrustedCertificateAuthority]()

[Remove-EntraBetaTrustedCertificateAuthority]()

[Set-EntraBetaTrustedCertificateAuthority]()

[Online help and examples for working with certificate authority](https://azure.microsoft.com/en-us/documentation/articles/active-directory-certificate-based-authentication-ios/)

