---
author: msewaweru
description: Creates an object with all values from a certificate file for configuring CertificateUserIDs in Microsoft Entra ID
external help file: Microsoft.Entra.CertificateBasedAuthentication-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra
ms.author: eunicewaweru
ms.date: 04/13/2025
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Get-EntraUserCertificateUserIdsFromCertificate
schema: 2.0.0
title: Get-EntraUserCertificateUserIdsFromCertificate
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

## Description

The `Get-EntraUserCertificateUserIdsFromCertificate` returns an object with certificateUserIDs values derived from the provided certificate file, following the format required by Microsoft Entra ID for Certificate-Based Authentication, as described in the [official documentation](https://learn.microsoft.com/entra/identity/authentication/concept-certificate-based-authentication-certificateuserids).

In delegated scenarios using work or school accounts, the signed-in user must have a Microsoft Entra role or custom role with the necessary permissions. The following least privileged roles support this operation:

- Privileged Authentication Administrator (for Cloud-only users)
- Hybrid Identity Administrator (for synchronized users)

## Examples

### Example 1: Retrieve certificate object from a certificate path

```powershell
Get-EntraUserCertificateUserIdsFromCertificate -Path 'C:\path\to\certificate.cer'
```

```Output
Name                           Value
----                           -----
Subject                        X509:<S>DC=com,DC=contoso,OU=UserAccounts,CN=mfatest
IssuerAndSerialNumber          X509:<I>DC=com,DC=contoso,CN=CONTOSO-DC-CA<SR>eF3gH4iJ5kL6mN7oP8qR9sT0uV
RFC822Name                     X509:<RFC822>user@contoso.com
SHA1PublicKey                  X509:<SHA1-PUKEY>cD2eF3gH4iJ5kL6mN7oP8qR9sT
IssuerAndSubject               X509:<I>DC=com,DC=contoso,CN=CONTOSO-DC-CA<S>DC=com,DC=contoso,OU=UserAccounts,CN=mfatest
SKI                            X509:<SKI>aB1cD2eF3gH4iJ5kL6mN7oP8qR
PrincipalName                  X509:<PN>bob@contoso.com
```

This example shows how to get all possible certificate mappings as an object.

### Example 2: Retrieve certificate object from a certificate path and certificate mapping

```powershell
Get-EntraUserCertificateUserIdsFromCertificate -Path 'C:\path\to\certificate.cer' -CertificateMapping 'Subject'
```

```Output
X509:<S>DC=com,DC=contoso,OU=UserAccounts,CN=mfatest
```

This command returns the PrincipalName property.

### Example 3: Retrieve certificate object from a certificate

```powershell
$text = "-----BEGIN CERTIFICATE-----
MIIDiz...=
-----END CERTIFICATE-----"
$bytes = [System.Text.Encoding]::UTF8.GetBytes($text)
$certificate = [System.Security.Cryptography.X509Certificates.X509Certificate2]::new($bytes)
Get-EntraUserCertificateUserIdsFromCertificate -Certificate $certificate -CertificateMapping 'Subject'
```

```Output
X509:<S>DC=com,DC=contoso,OU=UserAccounts,CN=mfatest
```

This command returns the PrincipalName property.

## Parameters

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
Aliases: CertificateObject, Cert

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
Parameter Sets: Default
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related links

[Set-EntraUserCBACertificateUserId](Set-EntraUserCBACertificateUserId.md)
[https://aka.ms/aadcba](https://aka.ms/aadcba)
[certificateUserIds](https://learn.microsoft.com/entra/identity/authentication/concept-certificate-based-authentication-certificateuserids)
