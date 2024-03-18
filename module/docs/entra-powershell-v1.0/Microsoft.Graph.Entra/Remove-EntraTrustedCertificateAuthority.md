---
title: Remove-EntraTrustedCertificateAuthority
description: This article provides details on the Remove-EntraTrustedCertificateAuthority command.

ms.service: active-directory
ms.topic: reference
ms.date: 03/16/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Remove-EntraTrustedCertificateAuthority

## SYNOPSIS
Removes a trusted certificate authority.

## SYNTAX

```powershell
Remove-EntraTrustedCertificateAuthority 
	-CertificateAuthorityInformation <CertificateAuthorityInformation>
	[<CommonParameters>]
```

## DESCRIPTION
The **Remove-EntraTrustedCertificateAuthority** cmdlet removes a trusted certificate authority from Microsoft Entra ID.

## EXAMPLES

### Example 1: Remove the trusted certificate authorities that are defined in your directory
```powershell
PS C:\> $cer = Get-EntraTrustedCertificateAuthority #Get the CertificateAuthorityInformation object
PS C:\> Remove-EntraTrustedCertificateAuthority -CertificateAuthorityInformation $cer[0]
```

```output
Name                           Value
----                           -----
@odata.context                 https://graph.microsoft.com/v1.0/$metadata#certificateBasedAuthConfiguration/$entity
certificateAuthorities         {System.Collections.Hashtable, System.Collections.Hashtable, System.Collections.Hashtable...}
id                             29728ade-6ae4-4ee9-9103-412912537da5
```

This command deletes the trusted certificate authorities that are defined in your directory.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraTrustedCertificateAuthority](Get-EntraTrustedCertificateAuthority.md)

[New-EntraTrustedCertificateAuthority](New-EntraTrustedCertificateAuthority.md)

[Set-EntraTrustedCertificateAuthority](Set-EntraTrustedCertificateAuthority.md)

