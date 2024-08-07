---
title: Set-EntraApplicationProxyApplicationCustomDomainCertificate
description: This article provides details on the Set-EntraApplicationProxyApplicationCustomDomainCertificate command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Set-EntraApplicationProxyApplicationCustomDomainCertificate

schema: 2.0.0
---

# Set-EntraApplicationProxyApplicationCustomDomainCertificate

## Synopsis
The Set-EntraApplicationProxyApplicationCustomDomainCertificate cmdlet assigns a certificate to an application configured for Application Proxy in Microsoft Entra ID.
This uploads the certificate and allows the application to use Custom Domains.

## Syntax

```powershell
Set-EntraApplicationProxyApplicationCustomDomainCertificate
 -ObjectId <String>
 -PfxFilePath <String>
 -Password <SecureString>
 [<CommonParameters>]
```

## Description
The Set-EntraApplicationProxyApplicationCustomDomainCertificate cmdlet assigns a certificate to an application configured for Application Proxy in Microsoft Entra ID.
This uploads the certificate and allows the application to use Custom Domains.
If you have one certificate that includes many of your applications, you only need to upload it with one application and are assigned to the other relevant applications.

## Examples

### Example 1: Assign a certificate to an application configured for Application Proxy
```powershell
PS C:\> $securePassword = Read-Host -AsSecureString
PS C:\> Set-EntraApplicationProxyApplicationCustomDomainCertificate -ObjectId 4eba5342-8d17-4eac-a1f6-62a0de26311e -PfxFilePath "C:\Temp\Certificates\cert.pfx" -Password $securePassword
```

This command assigns a certificate to an application configured for Application Proxy.

## Parameters

### -ObjectId
The unique application ID for the application the certificate should be uploaded to.
This can be found using the [Get-EntraApplication](./Get-EntraApplication.md) command.
You can also find this in the Azure portal by navigating to AAD, Enterprise Applications, All Applications, Select your application, go to the properties tab, and use the ObjectId on that page.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Password
A secure string containing the password for the pfx certificate

```yaml
Type: SecureString
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -PfxFilePath
The file path for the pfx certificate for the custom domain

```yaml
Type: String
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

### System.String
### System.Security.SecureString

## Outputs

### System.Object
## Notes

## RELATED LINKS