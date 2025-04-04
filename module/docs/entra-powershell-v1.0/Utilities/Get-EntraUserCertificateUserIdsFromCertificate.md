---
title: Get-EntraUserCertificateUserIdsFromCertificate
description: Creates an object with all values from a certificate file for configuring CertificateUserIDs in Entra ID
ms.topic: reference
ms.date: 03/25/2025
ms.author: eunicewaweru
manager: vimrang
author: thadumi
ms.reviewer: tdumitrescu
external help file: Microsoft.Entra.Utilities-Help.xml
Module Name: Microsoft.Entra.Utilities
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Utilities/Get-EntraUserCertificateUserIdsFromCertificate

schema: 2.0.0
---

# Get-EntraUserCertificateUserIdsFromCertificate

## Synopsis

Returns an object with the certificate values needed to configure CertificateUserIDs for Certificate-Based Authentication in Microsoft Entra ID.

## Syntax

```powershell
Get-EntraUserCertificateUserIdsFromCertificate
 [-Path] <string>
 [[-Certificate] <System.Security.Cryptography.X509Certificates.X509Certificate2> [-CertificateMapping] <string>]
 [<CommonParameters>]
```
## DESCRIPTION

The `Get-EntraUserCertificateUserIdsFromCertificate` returns an object with certificateUserIDs values derived from the provided certificate file, following the format required by Microsoft Entra ID for Certificate-Based Authentication, as described in the [official documentation](https://learn.microsoft.com/entra/identity/authentication/concept-certificate-based-authentication-certificateuserids).

## EXAMPLES

### EXAMPLE 1
```powershell
Get-EntraUserCertificateUserIdsFromCertificate C:\path\to\certificate.cer
```

```Output
Name                           Value
----                           -----
Subject                        X509:<S>DC=com,DC=contoso,OU=UserAccounts,CN=mfatest
IssuerAndSerialNumber          X509:<I>DC=com,DC=contoso,CN=CONTOSO-DC-CA<SR>eF3gH4iJ5kL6mN7oP8qR9sT0uV
RFC822Name                     X509:<RFC822>user@woodgrove.com
SHA1PublicKey                  X509:<SHA1-PUKEY>cD2eF3gH4iJ5kL6mN7oP8qR9sT
IssuerAndSubject               X509:<I>DC=com,DC=contoso,CN=CONTOSO-DC-CA<S>DC=com,DC=contoso,OU=UserAccounts,CN=mfatest
SKI                            X509:<SKI>aB1cD2eF3gH4iJ5kL6mN7oP8qR
PrincipalName                  X509:<PN>bob@woodgrove.com
```

### EXAMPLE 2
```powershell
Get-EntraUserCertificateUserIdsFromCertificate C:\path\to\certificate.cer -CertificateMapping Subject
```

```Output
X509:<S>DC=com,DC=contoso,OU=UserAccounts,CN=mfatest
```

### EXAMPLE 3
```powershell
$certificate = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2 -ArgumentList $certBytes
Get-EntraUserCertificateUserIdsFromCertificate -Certificate $certificate -CertificateMapping Subject
```

```Output
X509:<S>DC=com,DC=contoso,OU=UserAccounts,CN=mfatest
```

## PARAMETERS
### -Path

Path to the certificate file, it can be either a cer or pem file.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```
### -Certificate
Certificate from which the certificateUserIDs mappings will be extracted

```yaml
Type: System.Security.Cryptography.X509Certificates.X509Certificate2
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -CertificateMapping

One of the values `PrincipalName`, `RFC822Name`, `IssuerAndSubject`, `Subject`, `SKI`, `SHA1PublicKey`, and `IssuerAndSerialNumber`.
The meaning of each value is describe in the official documentation of [certificateUserIds](https://learn.microsoft.com/entra/identity/authentication/concept-certificate-based-authentication-certificateuserids). 

```yaml
Type: System.String
Parameter Sets: {PrincipalName | RFC822Name | IssuerAndSubject | Subject | SKI | SHA1PublicKey | IssuerAndSerialNumber}
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://aka.ms/aadcba](https://aka.ms/aadcba)
[certificateUserIds](https://learn.microsoft.com/entra/identity/authentication/concept-certificate-based-authentication-certificateuserids)
