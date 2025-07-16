---
author: msewaweru
description: This article provides details on the Get-EntraBetaApplicationProxyApplicationConnectorGroup.
external help file: Microsoft.Entra.Beta.Applications-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 07/15/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Get-EntraBetaApplicationProxyApplicationConnectorGroup
schema: 2.0.0
title: Get-EntraBetaApplicationProxyApplicationConnectorGroup
---

# Get-EntraBetaApplicationProxyApplicationConnectorGroup

## SYNOPSIS

The `Get-EntraBetaApplicationProxyApplicationConnectorGroup` cmdlet retrieves the connector group assigned for a specific application.

## SYNTAX

```powershell
Get-EntraBetaApplicationProxyApplicationConnectorGroup
 -ObjectId <String>
 [<CommonParameters>]
```

## DESCRIPTION

The `Get-EntraBetaApplicationProxyApplicationConnectorGroup` cmdlet retrieves the connector group assigned for the specified application.
The application must be configured for Application Proxy in Microsoft Entra ID.

## EXAMPLES

### Example 1: retrieves the connector group assigned for the specified application

```powershell
Connect-Entra -Scopes 'Directory.ReadWrite.All'
$application = Get-EntraBetaApplication -Filter "DisplayName eq 'Contoso App Proxy'"
Get-EntraBetaApplicationProxyApplicationConnectorGroup -ObjectId $application.Id
```

```Output
Id                                   Name       ConnectorGroupType IsDefault
--                                   ----       ------------------ ---------
bbbbbbbb-1111-2222-3333-cccccccccccc test-group applicationProxy       False
```

This example retrieves the connector group assigned for the specified application.

- `ObjectId` parameter specifies the application ID.

## PARAMETERS

### -ObjectId

ObjectId is the ID of the application.
This ObjectId can be found using the `Get-EntraBetaApplication` command.
You can also find this ObjectId in the Microsoft Portal by navigating to Microsoft Entra ID, Enterprise Applications, All Applications, Select your application, go to the properties tab, and use the ObjectId on that page.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
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

[Set-EntraBetaApplicationProxyApplicationConnectorGroup](Set-EntraBetaApplicationProxyApplicationConnectorGroup.md)

[Remove-EntraBetaApplicationProxyApplicationConnectorGroup](Remove-EntraBetaApplicationProxyApplicationConnectorGroup.md)
