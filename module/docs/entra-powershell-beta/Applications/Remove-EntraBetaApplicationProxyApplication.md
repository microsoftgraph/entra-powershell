---
title: Remove-EntraBetaApplicationProxyApplication
description: This article provides details on the Remove-EntraBetaApplicationProxyApplication command.

ms.topic: reference
ms.date: 07/15/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Remove-EntraBetaApplicationProxyApplication

schema: 2.0.0
---

# Remove-EntraBetaApplicationProxyApplication

## Synopsis

Deletes an Application Proxy application.

## Syntax

```powershell
Remove-EntraBetaApplicationProxyApplication
 -ApplicationId <String>
 [-RemoveADApplication <Boolean>]
 [<CommonParameters>]
```

## Description

The `Remove-EntraBetaApplicationProxyApplication` cmdlet removes Application Proxy configurations from a specific application in Microsoft Entra ID, and can delete the application completely if specified.

## Examples

### Example 1: Remove a Proxy Application

```powershell
Connect-Entra -Scopes 'Directory.ReadWrite.All'
Remove-EntraBetaApplicationProxyApplication -ApplicationId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'
```

This example removes a Proxy Application.

- `ApplicationId` parameter specifies the application ID.

### Example 2: Remove a Proxy Application, and remove it from Microsoft Entra ID completely

```powershell
Connect-Entra -Scopes 'Directory.ReadWrite.All'
Remove-EntraBetaApplicationProxyApplication -ApplicationId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb' -RemoveADApplication $true
```

This example removes a Proxy Application, and removes it from Microsoft Entra ID completely.

- `ApplicationId` parameter specifies the application ID.  
- `RemoveADApplication` parameter specifies the user confirmation to delete application completely.

## Parameters

### -ApplicationId

The unique application ID of the application.
This ApplicationId can be found using the `Get-EntraBetaApplication` command.
You can also find this ApplicationId in the Microsoft by navigating to Microsoft Entra ID > App registrations > All applications. Select your application. This will takes you to the application's overview page. Use the ObjectId on that page.

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

### -RemoveADApplication

This RemoveADApplication parameter allows you to delete application completely.
When this RemoveADApplication is false (default), Application Proxy properties are removed from the application, but the application still exists.
If this RemoveADApplication is true, the application is removed from Microsoft Entra ID.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related Links

[New-EntraBetaApplicationProxyApplication](New-EntraBetaApplicationProxyApplication.md)

[Set-EntraBetaApplicationProxyApplication](Set-EntraBetaApplicationProxyApplication.md)

[Get-EntraBetaApplicationProxyApplication](Get-EntraBetaApplicationProxyApplication.md)

[Get-EntraBetaApplication](Get-EntraBetaApplication.md)
