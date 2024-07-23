---
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/en-us/powershell/module/Microsoft.Graph.Entra.Beta/Remove-EntraBetaTrustedCertificateAuthority

schema: 2.0.0
---

# Remove-EntraBetaTrustedCertificateAuthority

## Synopsis
Removes a trusted certificate authority.

## Syntax

```
Remove-EntraBetaTrustedCertificateAuthority -CertificateAuthorityInformation <CertificateAuthorityInformation>
 [<CommonParameters>]
```

## Description
The Remove-EntraBetaTrustedCertificateAuthority cmdlet removes a trusted certificate authority from Azure Active Directory (AD).

## Examples

### Example 1: Remove the trusted certificate authorities that are defined in your directory
```
PS C:\> $cer = Get-EntraBetaTrustedCertificateAuthority #Get the CertificateAuthorityInformation object
		PS C:\> Remove-EntraBetaTrustedCertificateAuthority -CertificateAuthorityInformation $cer[0]
```

This command deletes the trusted certificate authorities that are defined in your directory.

## Parameters

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

## Inputs

## Outputs

## Notes

## Related Links

[Get-EntraBetaTrustedCertificateAuthority]()

[New-EntraBetaTrustedCertificateAuthority]()

[Set-EntraBetaTrustedCertificateAuthority]()

