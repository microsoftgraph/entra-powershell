---
title: Remove-EntraBetaApplicationProxyApplication
description: This article provides details on the Remove-EntraBetaApplicationProxyApplication command.
ms.service: active-directory
ms.topic: reference
ms.date: 04/16/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Remove-EntraBetaApplicationProxyApplication

## SYNOPSIS
Deletes an Application Proxy application.

## SYNTAX

```powershell
Remove-EntraBetaApplicationProxyApplication 
 -ObjectId <String> 
 [-RemoveADApplication <Boolean>]
 [<CommonParameters>]
```

## DESCRIPTION
The Remove-EntraBetaApplicationProxyApplication cmdlet removes Application Proxy configurations from a specific application in Microsoft Entra ID, and can delete the application completely if specified.

## EXAMPLES

### Example 1: Remove a Proxy Application
```powershell
PS C:\> Remove-EntraBetaApplicationProxyApplication -ObjectId 257098d1-f8dd-4efb-88a2-1c92d3654f10
```
This command Remove a Proxy Application.

### Example 2: Remove a Proxy Application, and remove it from Microsoft Entra ID completely

```powershell
PS C:\> Remove-EntraBetaApplicationProxyApplication -ObjectId 0d7b0f02-3f63-414d-8d20-4b8bd0291e42 -RemoveADApplication $true
```

This command Remove a Proxy Application, and remove it from Microsoft Entra ID completely.

## PARAMETERS

### -ObjectId
The unique application ID of the application.
This ObjectId can be found using the Get-EntraApplication command.
You can also find this ObjectId in the Microsoft by navigating to Microsoft Entra ID > App registrations > All applications. Select your application. This will takes you to the application's overview page. Use the ObjectId on that page.

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

### -RemoveADApplication
This RemoveADApplication parameter allows you to delete application completely.
When this RemoveADApplication is false (default), Application Proxy properties are removed from the application, but the application still exists.
If this RemoveADApplication is true, the application is removed from Microsoft Entra ID.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS