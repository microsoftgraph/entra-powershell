---
title: Remove-EntraBetaApplicationProxyApplicationConnectorGroup
description: This article provides details on the Remove-EntraBetaApplicationProxyApplicationConnectorGroup command.
ms.service: active-directory
ms.topic: reference
ms.date: 04/03/2023
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

## SYNOPSIS
The Remove-EntraBetaApplicationProxyApplicationConnectorGroupcmdlet sets the connector group assigned for the specified application to 'Default' and removes the current assignment.

## SYNTAX

```powershell
Remove-EntraBetaApplicationProxyApplicationConnectorGroup
 -ObjectId <String> 
 [<CommonParameters>]
```

## DESCRIPTION
If your application is already in the 'Default' group, you see an error because the application can't be removed from the 'Default' group unless it's being added to another group.
The application must be configured for Application Proxy in Microsoft Entra ID.

## EXAMPLES

### Example 1: Remove the Connector Group associated with an application, setting the group to 'Default'

```POWERSHELL
PS C:\> Remove-EntraBetaApplicationProxyApplicationConnectorGroup -ObjectId 59462d3c-a1bc-40a0-9bed-be799357ebce
```

This command Remove the Connector Group associated with an application, setting the group to 'Default.'

## PARAMETERS

### -ObjectId
The unique application ID of the application.
This can be found using the Get-EntraBetaApplication command.
You can also find objectId  in the Microsoft Portal by navigating to Microsoft Entra ID > App registrations > All applications. Select your application. This takes you to the application's overview page. Use the ObjectId on that page.

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String
## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS