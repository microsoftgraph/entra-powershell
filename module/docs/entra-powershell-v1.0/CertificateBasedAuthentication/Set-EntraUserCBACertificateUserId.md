---
author: msewaweru
description: Sets certificate-based authentication user IDs for a user in Microsoft Entra ID
external help file: Microsoft.Entra.CertificateBasedAuthentication-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra
ms.author: eunicewaweru
ms.date: 04/13/2025
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Set-EntraUserCBACertificateUserId
schema: 2.0.0
title: Set-EntraUserCBACertificateUserId
---

# Set-EntraUserCBACertificateUserId

## SYNOPSIS

Sets certificate-based authentication user IDs for a user in Microsoft Entra ID using a certificate file or object.

## SYNTAX

```powershell
Set-EntraUserCBACertificateUserId
 -UserId <string>
 [-CertPath <string>]
 [-Cert <System.Security.Cryptography.X509Certificates.X509Certificate2>]
 -CertificateMapping <string[]>
 [<CommonParameters>]
```

## DESCRIPTION

Configures certificate-based authentication user IDs for a user in Microsoft Entra ID. Accepts a certificate file path or object, and one or more certificate mapping types to apply to the user's authorization information.

`Update-EntraUserCBACertificateUserId` is an alias of `Set-EntraUserCBACertificateUserId`.

In delegated scenarios using work or school accounts, the signed-in user must have a Microsoft Entra role or custom role with the necessary permissions. The following least privileged roles support this operation:

- Privileged Authentication Administrator (for Cloud-only users)
- Hybrid Identity Administrator (for synchronized users)

## EXAMPLES

### Example 1: Update user's certificate authorization information using certificate path

```powershell
Connect-Entra -Scopes 'Directory.ReadWrite.All', 'User.ReadWrite.All'
Set-EntraUserCBACertificateUserId -UserId 'SawyerM@contoso.com' -CertPath 'C:\path\to\certificate.cer' -CertificateMapping @('Subject', 'PrincipalName')
```

This example sets the certificate user IDs for the specified user using a certificate file, mapping both the Subject and PrincipalName fields. You can use `Get-EntraUserCBAAuthorizationInfo` command to view updated details.

### Example 2: Update user's certificate authorization information using a certificate

```powershell
Connect-Entra -Scopes 'Directory.ReadWrite.All', 'User.ReadWrite.All'
$text = '-----BEGIN CERTIFICATE-----
MIIDiz...=
-----END CERTIFICATE-----'
$bytes = [System.Text.Encoding]::UTF8.GetBytes($text)
$certificate = [System.Security.Cryptography.X509Certificates.X509Certificate2]::new($bytes)
Set-EntraUserCBACertificateUserId -UserId 'SawyerM@contoso.com' -Cert $certificate -CertificateMapping @('RFC822Name', 'SKI')
```

This example sets the certificate user IDs for the specified user using a certificate object, mapping the RFC822Name and SKI fields. You can use `Get-EntraUserCBAAuthorizationInfo` command to view updated details.

## PARAMETERS

### -UserId

Specifies the ID of a user (as a UserPrincipalName or ObjectId) in Microsoft Entra ID.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: ObjectId, UPN, Identity, UserPrincipalName

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
Aliases: CertificatePath

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Cert

Certificate object used to extract certificate user IDs.

```yaml
Type: System.Security.Cryptography.X509Certificates.X509Certificate2
Parameter Sets: (All)
Aliases: CertificateObject, Certificate

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

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraUserCBAAuthorizationInfo](Get-EntraUserCBAAuthorizationInfo.md)
[Get-EntraUserCertificateUserIdsFromCertificate](Get-EntraUserCertificateUserIdsFromCertificate.md)
[https://aka.ms/aadcba](https://aka.ms/aadcba)
[certificateUserIds](https://learn.microsoft.com/entra/identity/authentication/concept-certificate-based-authentication-certificateuserids)
