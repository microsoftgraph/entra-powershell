---
title: Get-EntraBetaApplicationProxyApplication.
description: This article provides details on the Get-EntraBetaApplicationProxyApplication.
ms.service: active-directory
ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Get-EntraBetaApplicationProxyApplication

## Synopsis
The Get-EntraBetaApplicationProxyApplication cmdlet retrieves an application configured for Application Proxy in Microsoft Entra ID.

## Syntax

```powershell
Get-EntraBetaApplicationProxyApplication 
 -ObjectId <String> 
 [<CommonParameters>]
```

## Description
The Get-EntraBetaApplicationProxyApplication cmdlet retrieves an application configured for Application Proxy in Microsoft Entra ID.

## Examples

### Example 1: Retrieves an application configured for Application Proxy
```powershell
PS C:\> Get-EntraBetaApplicationProxyApplication -ObjectId 61ec5727-7d0b-40b3-bd4e-817076b540fa
```
```output
AlternateUrl ApplicationServerTimeout ApplicationType ExternalAuthenticationType ExternalUrl
------------ ------------------------ --------------- -------------------------- -----------
             Long                     enterpriseapp   aadPreAuthentication      
https://testp-m365x99297270.msapppr...
```
This command Retrieves an application configured for Application Proxy.

## Parameters

### -ObjectId
This ObjectId is the unique application ID of the application.
This ObjectId can be found using the Get-AzureADApplication command.
You can also find ObjectId in the Microsoft Portal by navigating to Microsoft Entra ID, Enterprise Applications, All Applications, Select your application, go to the properties tab, and use the ObjectId on that page.

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

## Related Links
