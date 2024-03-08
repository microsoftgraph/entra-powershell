---
title: New-EntraTrustedCertificateAuthority
description: This article provides details on the New-EntraTrustedCertificateAuthority command.

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

# New-EntraTrustedCertificateAuthority

## SYNOPSIS
Creates a trusted certificate authority.

## SYNTAX

```powershell
New-EntraTrustedCertificateAuthority 
    -CertificateAuthorityInformation <CertificateAuthorityInformation>
    [-InformationAction <ActionPreference>] 
    [-InformationVariable <String>] 
    [<CommonParameters>]
```

## DESCRIPTION
The **New-EntraTrustedCertificateAuthority** cmdlet creates a trusted certificate authority in Microsoft Entra ID.

## EXAMPLES

### Example 1: Creates the trusted certificate authorities in your directory
```powershell
PS C:\> $new_ca = New-Object -TypeName Microsoft.Open.AzureAD.Model.CertificateAuthorityInformation #Create CertificateAuthorityInformation object
PS C:\> $new_ca.AuthorityType = "RootAuthority"
PS C:\> $new_ca.CrlDistributionPoint = "https://example.crl"
PS C:\> $new_ca.DeltaCrlDistributionPoint = "https://deltaexample.crl"
PS C:\> $new_ca.TrustedCertificate = "Path to .cer file(including cer file name)"
PS C:\> New-EntraTrustedCertificateAuthority -CertificateAuthorityInformation $new_ca
```

```output
Id                                   CertificateAuthorities
--                                   ----------------------
29728ade-6ae4-4ee9-9103-412912537da5 {class CertificateAuthorityInformation {...
```

This command creates the trusted certificate authorities in your directory.

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraTrustedCertificateAuthority](Get-EntraTrustedCertificateAuthority.md)

[Remove-EntraTrustedCertificateAuthority](Remove-EntraTrustedCertificateAuthority.md)

[Set-EntraTrustedCertificateAuthority](Set-EntraTrustedCertificateAuthority.md)

