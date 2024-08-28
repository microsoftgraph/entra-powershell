---
title: Get-EntraApplicationProxyApplicationConnectorGroup
description: This article provides details on the Get-EntraApplicationProxyApplicationConnectorGroup command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Get-EntraApplicationProxyApplicationConnectorGroup

schema: 2.0.0
---

# Get-EntraApplicationProxyApplicationConnectorGroup

## Synopsis
The Get-EntraApplicationProxyApplicationConnectorGroup cmdlet retrieves the connector group assigned for a specific application.

## Syntax

```powershell
Get-EntraApplicationProxyApplicationConnectorGroup 
 -ObjectId <String> 
 [<CommonParameters>]
```

## Description
The Get-EntraApplicationProxyApplicationConnectorGroup cmdlet retrieves the connector group assigned for the specified application.
The application must be configured for Application Proxy in Microsoft Entra ID.

## Examples

### Example 1: Retrieve application connector group by ID

```powershell
PS C:\WINDOWS\system32> Get-EntraApplicationProxyApplicationConnectorGroup -ObjectId "8d6c6684-6f8c-42e2-8914-32ed2adf9ccf"
```

This example demonstrates how to retrieve specific application connector group by providing ID.

## Parameters

### -ObjectId
ObjectId is the ID of the application.
This can be found using the [Get-EntraApplication](Get-EntraApplication.md) command.
You can also find this in the Microsoft Portal by navigating to Microsoft Entra ID, Enterprise Applications, All Applications, Select your application, go to the properties tab, and use the ObjectId on that page.

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
