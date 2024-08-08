---
title: Remove-EntraApplicationProxyApplicationConnectorGroup
description: This article provides details on the Remove-EntraApplicationProxyApplicationConnectorGroup command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Remove-EntraApplicationProxyApplicationConnectorGroup

schema: 2.0.0
---

# Remove-EntraApplicationProxyApplicationConnectorGroup

## Synopsis
The Remove-EntraApplicationProxyApplicationConnectorGroup cmdlet sets the connector group assigned for the specified application to 'Default' and removes the current assignment.

## Syntax

```powershell
Remove-EntraApplicationProxyApplicationConnectorGroup 
 -ObjectId <String> 
 [<CommonParameters>]
```

## Description
If your application is already in the 'Default' group, you see an error because the application can't be removed from the 'Default' group unless it's being added to another group. The application must be configured for Application Proxy in Microsoft Entra ID.

## Examples

### Example 1:  Remove the Connector Group associated with an application.

```powershell
PS C:\> Remove-EntraApplicationProxyApplicationConnectorGroup -ObjectId 59462d3c-a1bc-40a0-9bed-be799357ebce
```
This example demonstrates how to remove the Connector Group associated with an application, setting the group to 'Default.'

## Parameters

### -ObjectId
The unique application ID of the application.
ObjectId can be found using the Get-EntraApplication command.
You can also find ObjectId in the Microsoft Entra ID Portal by navigating to  Microsoft Entra ID > App registrations > All applications. Select your application. This will takes you to the application's overview page. Use the ObjectId on that page.

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

## Outputs

## Notes

## Related Links


