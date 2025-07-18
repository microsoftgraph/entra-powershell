---
title: Remove-EntraApplicationProxyApplication
description: This article provides details on the Remove-EntraApplicationProxyApplication command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: mwongerapk
author: msewaweru

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Remove-EntraApplicationProxyApplication

schema: 2.0.0
---

# Remove-EntraApplicationProxyApplication

## Synopsis
Deletes an Application Proxy application.

## Syntax

```powershell
Remove-EntraApplicationProxyApplication 
 -ObjectId <String> 
 [-RemoveADApplication <Boolean>]
 [<CommonParameters>]
```

## Description
The Remove-EntraApplicationProxyApplication cmdlet removes Application Proxy configurations from a specific application in Microsoft Entra ID, and can delete the application completely if specified.

## Examples

### Example 1: Remove a Proxy Application
```powershell
PS C:\> Remove-EntraApplicationProxyApplication -ObjectId 257098d1-f8dd-4efb-88a2-1c92d3654f10
```

This command removes a Proxy Application.

### Example 2: Remove a Proxy Application, and remove it from Microsoft Entra ID completely
```powershell
PS C:\> Remove-EntraApplicationProxyApplication -ObjectId 0d7b0f02-3f63-414d-8d20-4b8bd0291e42 -RemoveADApplication $true
```

This command removes a Proxy Application, and removes it from Microsoft Entra ID completely.

## Parameters

### -ObjectId
The unique application Id of the application.
This can be found using the [Get-EntraApplication](./Get-EntraApplication.md) command.
You can also find this in the Azure portal by navigating to Azure AD > App registrations > All applications. Select your application. This takes you to the application's overview page. Use the ObjectId on that page.

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
This allows you to delete application completely.
When this is false (default), Application Proxy properties are removed from the application, but the application still exists.
If this is true, the application is removed from Microsoft Entra ID.

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

## Inputs

## Outputs

## Notes

## RELATED LINKS