---
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Set-EntraBetaTrustedCertificateAuthority

## Synopsis
Updates a trusted certificate authority.

## Syntax

```
Set-EntraBetaTrustedCertificateAuthority -CertificateAuthorityInformation <CertificateAuthorityInformation>
 [<CommonParameters>]
```

## Description
The Set-EntraBetaTrustedCertificateAuthority cmdlet updates a trusted certificate authority in Azure Active Directory (AD).

## Examples

### Example 1: Updates the trusted certificate authorities that are defined in your directory
```
PS C:\> $cer = Set-EntraBetaTrustedCertificateAuthority #Get the CertificateAuthorityInformation object
		PS C:\> $cer[0].CrlDistributionPoint = "https://example.crl"
		PS C:\> Set-EntraBetaTrustedCertificateAuthority -CertificateAuthorityInformation $cer[0]
```

This command updates the trusted certificate authorities that are defined in your directory.

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related LINKS

[Get-EntraBetaTrustedCertificateAuthority]()

[New-EntraBetaTrustedCertificateAuthority]()

[Remove-EntraBetaTrustedCertificateAuthority]()

