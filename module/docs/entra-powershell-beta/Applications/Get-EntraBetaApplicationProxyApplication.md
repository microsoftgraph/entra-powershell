---
author: msewaweru
description: This article provides details on the Get-EntraBetaApplicationProxyApplication.
external help file: Microsoft.Entra.Beta.Applications-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 07/15/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Get-EntraBetaApplicationProxyApplication
schema: 2.0.0
title: Get-EntraBetaApplicationProxyApplication
---

# Get-EntraBetaApplicationProxyApplication

## SYNOPSIS

Retrieves an application configured for Application Proxy in Microsoft Entra ID.

## SYNTAX

```powershell
Get-EntraBetaApplicationProxyApplication
 -ApplicationId <String>
 [-Property <String[]>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Get-EntraBetaApplicationProxyApplication` cmdlet retrieves an application configured for Application Proxy in Microsoft Entra ID. Specify `ApplicationId` parameter to retrieve application configured for application proxy.

## EXAMPLES

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

## PARAMETERS

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
Aliases: Select

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS

[New-EntraBetaApplicationProxyApplication](New-EntraBetaApplicationProxyApplication.md)

[Set-EntraBetaApplicationProxyApplication](Set-EntraBetaApplicationProxyApplication.md)

[Remove-EntraBetaApplicationProxyApplication](Remove-EntraBetaApplicationProxyApplication.md)
