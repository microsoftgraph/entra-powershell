---
title: Set-EntraCBACertificateUserId
description: This article provides details on the Set-EntraCBACertificateUserId command.

ms.topic: reference
ms.date: 03/26/2025
ms.author: tdumitrescu, peichensun
ms.reviewer: 
manager: 
author: 

external help file: Microsoft.Entra.Users-Help.xml
Module Name: Microsoft.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Set-EntraCBACertificateUserId

schema: 2.0.0
---

## SYNOPSIS
    Set Entra ID CertificateUserIDs in Certificate-Based Authentication.

## SYNTAX

```syntax
 Set-EntraCBACertificateUserId 
 -Path <string>
 -UserId <string>
 -CertificateMapping <string>
```

## DESCRIPTION

Set certificateUserIDs configurations to Graph for Certificate-Based Authentication based on the given certificate file. The properties in the object are constructed according to the guidelines outlined in the Microsoft [documentation](https://learn.microsoft.com/en-us/entra/identity/authentication/concept-certificate-based-authentication-certificateuserids
) for certificate-based authentication.

```powershell
@{
    PrincipalName = "X509:<PN>bob@woodgrove.com"
    RFC822Name = "X509:<RFC822>user@woodgrove.com"
    IssuerAndSubject = "X509:<I>DC=com,DC=contoso,CN=CONTOSO-DC-CA<S>DC=com,DC=contoso,OU=UserAccounts,CN=mfatest"
    Subject = "X509:<S>DC=com,DC=contoso,OU=UserAccounts,CN=mfatest"
    SKI = "X509:<SKI>aB1cD2eF3gH4iJ5kL6mN7oP8qR"
    SHA1PublicKey = "X509:<SHA1-PUKEY>cD2eF3gH4iJ5kL6mN7oP8qR9sT"
    IssuerAndSerialNumber = "X509:<I>DC=com,DC=contoso,CN=CONTOSO-DC-CA<SR>eF3gH4iJ5kL6mN7oP8qR9sT0uV"
}
```

## EXAMPLES

### EXAMPLE 1
```powershell
> $output = Set-EntraCBACertificateUserId.ps1 -UserId "79fb4430-1569-4d28-9a00-be3fdb9cc261" -Path "C:\temp\testcert.cer" -CertificateMapping "PrincipalName"
> $output
UserId                               CertificateUserIds
------                               ------------------
79fb4430-1569-4d28-9a00-be3fdb9cc261 X509:<PN>test_peichen@1vbhqz.onmicrosoft.com
```

## PARAMETERS
### -Path

Path to the certificate file, it can be either a cer or pem file.

### -CertificateMapping
One of the values `PrincipalName`, `RFC822Name`, `IssuerAndSubject`, `Subject`, `SKI`, `SHA1PublicKey`, and `IssuerAndSerialNumber`
To filer

### -UserId
The user id whose CertificateUserID will be modified.

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

## OUTPUTS

### System.String

###
```powershell
@{
    PrincipalName = "X509:<PN>bob@woodgrove.com"
    RFC822Name = "X509:<RFC822>user@woodgrove.com"
    IssuerAndSubject = "X509:<I>DC=com,DC=contoso,CN=CONTOSO-DC-CA<S>DC=com,DC=contoso,OU=UserAccounts,CN=mfatest"
    Subject = "X509:<S>DC=com,DC=contoso,OU=UserAccounts,CN=mfatest"
    SKI = "X509:<SKI>aB1cD2eF3gH4iJ5kL6mN7oP8qR"
    SHA1PublicKey = "X509:<SHA1-PUKEY>cD2eF3gH4iJ5kL6mN7oP8qR9sT"
    IssuerAndSerialNumber = "X509:<I>DC=com,DC=contoso,CN=CONTOSO-DC-CA<SR>eF3gH4iJ5kL6mN7oP8qR9sT0uV"
}
```
## NOTES

## RELATED LINKS

[https://aka.ms/aadcba](https://aka.ms/aadcba)
[certificateUserIds](https://learn.microsoft.com/en-us/entra/identity/authentication/concept-certificate-based-authentication-certificateuserids)