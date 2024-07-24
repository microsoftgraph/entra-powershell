---
title: Get-EntraApplicationProxyApplication
description: This article provides details on the Get-EntraApplicationProxyApplication command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Get-EntraApplicationProxyApplication

schema: 2.0.0
---

# Get-EntraApplicationProxyApplication

## Synopsis
The Get-EntraApplicationProxyApplication cmdlet retrieves an application configured for Application Proxy in Microsoft Entra ID.

## Syntax

```powershell
Get-EntraApplicationProxyApplication 
 -ObjectId <String> 
 [<CommonParameters>]
```

## Description
The Get-EntraApplicationProxyApplication cmdlet retrieves an application configured for Application Proxy in Microsoft Entra ID.

## Examples

### Example 1
```powershell
PS C:\> Get-EntraApplicationProxyApplication -ObjectId 8d6c6684-6f8c-42e2-8914-32ed2adf9ccf
```

```output
ExternalAuthenticationType               : AadPreAuthentication
ApplicationServerTimeout                 : Default
ExternalUrl                              : https://travel.cycles.adventure-works.com/
InternalUrl                              : https://awcyclesapps.adventure-works.com:3000/
IsTranslateHostHeaderEnabled             : False
IsTranslateLinksInBodyEnabled            : False
IsOnPremPublishingEnabled                : True
VerifiedCustomDomainCertificatesMetadata : class OnPremisesPublishingVerifiedCustomDomainCertificatesMetadataObject {
                                             Thumbprint:  [XXXXX]
                                             SubjectName: [XXXXX]
                                             Issuer:
                                             IssueDate: 11/9/2017 5:54:29
                                             ExpiryDate: 11/9/2019 5:54:29
                                           }

VerifiedCustomDomainKeyCredential        :
VerifiedCustomDomainPasswordCredential   :
SingleSignOnSettings                     :
```

## Parameters

### -ObjectId
This is the unique application Id of the application.
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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

### System.String
## Outputs

### System.Object
## Notes

## RELATED LINKS