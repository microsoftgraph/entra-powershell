---
title: Remove-EntraBetaApplicationProxyApplicationConnectorGroup
description: This article provides details on the Remove-EntraBetaApplicationProxyApplicationConnectorGroup command.
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

# Remove-EntraBetaApplicationProxyApplicationConnectorGroup

## Synopsis
the Remove-EntraBetaApplicationProxyApplicationConnectorGroupcmdlet sets the connector group assigned for the specified application to 'Default' and removes the current assignment.

## Syntax

```powershell
Remove-EntraBetaApplicationProxyApplicationConnectorGroup
 -ObjectId <String> 
 [<CommonParameters>]
```

## Description
if your application is already in the 'Default' group, you see an error because the application can't be removed from the 'Default' group unless it's being added to another group.
The application must be configured for Application Proxy in Microsoft Entra ID.

## Examples

### Example 1: Remove the Connector Group associated with an application, setting the group to 'Default'

```POWERSHELL
PS C:\> Remove-EntraBetaApplicationProxyApplicationConnectorGroup -ObjectId 59462d3c-a1bc-40a0-9bed-be799357ebce
```

This command Remove the Connector Group associated with an application, setting the group to 'Default.'

## Parameters

### -ObjectId
The unique application ID of the application.
The application ID can be found using the Get-EntraBetaApplication command.
You can also find objectId  in the Microsoft Entra Admin Center by navigating to Microsoft Entra ID > App registrations > All applications. Select your application. From the application overview page, copy the ObjectId.

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
