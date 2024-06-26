---
title: Set-EntraBetaApplicationProxyApplicationConnectorGroup.
description: This article provides details on the Set-EntraBetaApplicationProxyApplicationConnectorGroup command.

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

# Set-EntraBetaApplicationProxyApplicationConnectorGroup

## Synopsis
the Set-EntraBetaApplicationProxyApplicationConnectorGroup cmdlet assigns the given connector group to a specified application.

## Syntax

```powershell
Set-EntraBetaApplicationProxyApplicationConnectorGroup 
 -ObjectId <String> 
 -ConnectorGroupId <String>
 [<CommonParameters>]
```

## Description
the Set-EntraBetaApplicationProxyApplicationConnectorGroup cmdlet sets the connector group assigned for the specified application.
The application must be configured for Application Proxy in Microsoft Entra ID.

## Examples

### Example 1: Set a new Connector Group for a specific application
```powershell
PS C:\> Set-EntraBetaApplicationProxyApplicationConnectorGroup -ObjectId 59462d3c-a1bc-40a0-9bed-be799357ebce -ConnectorGroupId a39b9095-8dc8-4d3a-86c3-e7b5c3f0fb84
```

This command Set a new Connector Group for a specific application

## Parameters

### -ConnectorGroupId
The ID of the Connector group that should be assigned to the application.
You can find the Connector Group ID by using the Get-EntraBetaApplicationProxyConnectorGroup command.

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

### -ObjectId
The unique application ID for the application the Connector group assigns to.
The application ID can be found using the Get-EntraBetaApplication command.

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
