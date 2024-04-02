---
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Remove-EntraBetaTrustedCertificateAuthority

## SYNOPSIS
Removes a trusted certificate authority.

## SYNTAX

```
Remove-EntraBetaTrustedCertificateAuthority -CertificateAuthorityInformation <CertificateAuthorityInformation>
 [-InformationAction <ActionPreference>] [-InformationVariable <String>] [<CommonParameters>]
```

## DESCRIPTION
The Remove-EntraBetaTrustedCertificateAuthority cmdlet removes a trusted certificate authority from Azure Active Directory (AD).

## EXAMPLES

### Example 1: Remove the trusted certificate authorities that are defined in your directory
```
PS C:\> $cer = Get-EntraBetaTrustedCertificateAuthority #Get the CertificateAuthorityInformation object
		PS C:\> Remove-EntraBetaTrustedCertificateAuthority -CertificateAuthorityInformation $cer[0]
```

This command deletes the trusted certificate authorities that are defined in your directory.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraBetaTrustedCertificateAuthority]()

[New-EntraBetaTrustedCertificateAuthority]()

[Set-EntraBetaTrustedCertificateAuthority]()

