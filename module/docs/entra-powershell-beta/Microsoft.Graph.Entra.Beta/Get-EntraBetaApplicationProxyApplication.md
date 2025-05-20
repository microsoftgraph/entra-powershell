---
title: Get-EntraBetaApplicationProxyApplication
description: This article provides details on the Get-EntraBetaApplicationProxyApplication.

ms.topic: reference
ms.date: 07/15/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Get-EntraBetaApplicationProxyApplication

schema: 2.0.0
---

# Get-EntraBetaApplicationProxyApplication

## Synopsis

Retrieves an application configured for Application Proxy in Microsoft Entra ID.

## Syntax

```powershell
Get-EntraBetaApplicationProxyApplication
 -ApplicationId <String>
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

The `Get-EntraBetaApplicationProxyApplication` cmdlet retrieves an application configured for Application Proxy in Microsoft Entra ID. Specify `ApplicationId` parameter to retrieve application configured for application proxy.

## Examples

### Example 1: Retrieves an application configured for Application Proxy

```powershell
Connect-Entra -Scopes 'Directory.ReadWrite.All'
$application = Get-EntraBetaApplication -Filter "DisplayName eq 'Contoso App Proxy'"
Get-EntraBetaApplicationProxyApplication -ApplicationId $application.Id
```

```Output
AlternateUrl ApplicationServerTimeout ApplicationType ExternalAuthenticationType ExternalUrl
------------ ------------------------ --------------- -------------------------- -----------
             Long                     enterpriseapp   aadPreAuthentication      
https://testp-m365x99297270.msapppr...
```

This example retrieves an application configured for Application Proxy.

- `ApplicationId` parameter specifies the application ID.

## Parameters

### -ApplicationId

The ApplicationId is a unique identifier for the application. You can find it using the `Get-EntraBetaApplication` command in PowerShell, or in the Microsoft Entra admin portal by navigating to **Entra ID** > **Enterprise Applications** > **All Applications**, selecting your application, and viewing the **Properties** tab. Use the `ObjectId` value.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: ObjectId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Property

Specifies properties to be returned

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

### System.String

## Outputs

### System.Object

## Notes

## Related links

[New-EntraBetaApplicationProxyApplication](New-EntraBetaApplicationProxyApplication.md)

[Set-EntraBetaApplicationProxyApplication](Set-EntraBetaApplicationProxyApplication.md)

[Remove-EntraBetaApplicationProxyApplication](Remove-EntraBetaApplicationProxyApplication.md)
