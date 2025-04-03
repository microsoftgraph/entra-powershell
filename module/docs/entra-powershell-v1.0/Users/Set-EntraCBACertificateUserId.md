---
title: Set-EntraCBACertificateUserId
description: Sets certificate-based authentication user IDs for a user in Entra ID
ms.topic: reference
ms.date: 04/03/2025
ms.author: peichensun
manager: vimrang
author: peichensun
ms.reviewer: stevemutungi
external help file: Microsoft.Entra.Users-Help.xml
Module Name: Microsoft.Entra.Users
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Users/Set-EntraCBACertificateUserId

schema: 2.0.0
---

# Set-EntraCBACertificateUserId

## SYNOPSIS
Sets certificate-based authentication user IDs for a specified user in Entra ID using either a certificate file or certificate object.

## SYNTAX
```syntax
Set-EntraCBACertificateUserId -UserId <string> [-CertPath <string>] [-Cert <System.Security.Cryptography.X509Certificates.X509Certificate2>] -CertificateMapping <string[]> [<CommonParameters>]
```

## DESCRIPTION
Configures certificate-based authentication user IDs for a user in Entra ID. The cmdlet accepts either a certificate file path or a certificate object, along with one or more certificate mapping types to be applied to the user's authorization information.

## EXAMPLES

### EXAMPLE 1
```powershell
Set-EntraCBACertificateUserId -UserId "12345678-1234-1234-1234-123456789012" -CertPath "C:\path\to\certificate.cer" -CertificateMapping @("Subject", "PrincipalName")
```

This example sets the certificate user IDs for the specified user using a certificate file, mapping both the Subject and PrincipalName fields.

### EXAMPLE 2
```powershell
$cert = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2 -ArgumentList $certBytes
Set-EntraCBACertificateUserId -UserId "12345678-1234-1234-1234-123456789012" -Cert $cert -CertificateMapping @("RFC822Name", "SKI")
```

This example sets the certificate user IDs for the specified user using a certificate object, mapping the RFC822Name and SKI fields.

## PARAMETERS

### -UserId
The unique identifier of the user in Entra ID.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CertPath
Path to the certificate file.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Cert
Certificate object from which the certificate user IDs will be extracted.

```yaml
Type: System.Security.Cryptography.X509Certificates.X509Certificate2
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CertificateMapping
One or more certificate mapping types to be applied. Valid values are: PrincipalName, RFC822Name, IssuerAndSubject, Subject, SKI, SHA1PublicKey, and IssuerAndSerialNumber.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: True
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

[https://aka.ms/aadcba](https://aka.ms/aadcba)
[certificateUserIds](https://learn.microsoft.com/en-us/entra/identity/authentication/concept-certificate-based-authentication-certificateuserids) 