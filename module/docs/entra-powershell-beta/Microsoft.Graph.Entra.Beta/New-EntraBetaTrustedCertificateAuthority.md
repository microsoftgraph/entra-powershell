---
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# New-EntraBetaTrustedCertificateAuthority

## SYNOPSIS
Creates a trusted certificate authority.

## SYNTAX

```
New-EntraBetaTrustedCertificateAuthority -CertificateAuthorityInformation <CertificateAuthorityInformation>
 [<CommonParameters>]
```

## DESCRIPTION
The New-EntraBetaTrustedCertificateAuthority cmdlet creates a trusted certificate authority in Azure Active Directory (AD).

## EXAMPLES

### Example 1: Creates the trusted certificate authorities in your directory
```
PS C:\> $new_ca = New-Object -TypeName Microsoft.Open.AzureAD.Model.CertificateAuthorityInformation #Create CertificateAuthorityInformation object
		PS C:\> $new_ca.AuthorityType = "RootAuthority"
		PS C:\> $new_ca.CrlDistributionPoint = "https://example.crl"
		PS C:\> $new_ca.DeltaCrlDistributionPoint = "https://deltaexample.crl"
		PS C:\> $new_ca.TrustedCertificate = "Path to .cer file(including cer file name)"
		PS C:\> New-EntraBetaTrustedCertificateAuthority -CertificateAuthorityInformation $new_ca
```

This command creates the trusted certificate authorities in your directory.

## PARAMETERS

### -CertificateAuthorityInformation
@{Text=}

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

[Get-EntraBetaTrustedCertificateAuthority]()

[Remove-EntraBetaTrustedCertificateAuthority]()

[Set-EntraBetaTrustedCertificateAuthority]()

