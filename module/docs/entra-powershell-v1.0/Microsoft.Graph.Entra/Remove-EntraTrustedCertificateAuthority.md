---
Title: Remove-EntraTrustedCertificateAuthority
Description: This article provides details on the Remove-EntraTrustedCertificateAuthority command.

Ms.service: entra
Ms.topic: reference
Ms.date: 06/26/2024
Ms.author: eunicewaweru
Ms.reviewer: stevemutungi
Manager: CelesteDG

External help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
Online version:
Schema: 2.0.0
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

The Remove-EntraTrustedCertificateAuthority cmdlet removes a trusted certificate authority from Microsoft Entra ID.

## Examples

### Example 1: Remove the trusted certificate authorities that are defined in your directory

```powershell
Connect-Entra -Scopes 'Organization.ReadWrite.All'
$cer = Get-EntraTrustedCertificateAuthority #Get the CertificateAuthorityInformation object
Remove-EntraTrustedCertificateAuthority -CertificateAuthorityInformation $cer[0]
```

```output
Name                           Value
----                           -----
@odata.context                 https://graph.microsoft.com/v1.0/$metadata#certificateBasedAuthConfiguration/$entity
CertificateAuthorities         {System.Collections.Hashtable, System.Collections.Hashtable, System.Collections.Hashtable...}
Id                             0a0a0a0a-1111-bbbb-2222-3c3c3c3c3c3c
```

This command deletes the trusted certificate authorities that are defined in your directory.

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

## Related Links

[Get-EntraTrustedCertificateAuthority](Get-EntraTrustedCertificateAuthority.md)

[New-EntraTrustedCertificateAuthority](New-EntraTrustedCertificateAuthority.md)

[Set-EntraTrustedCertificateAuthority](Set-EntraTrustedCertificateAuthority.md)
