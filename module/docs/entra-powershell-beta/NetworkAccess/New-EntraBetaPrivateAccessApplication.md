---
author: msewaweru
description: This article provides details on the New-EntraBetaPrivateAccessApplication command.
external help file: Microsoft.Entra.Beta.NetworkAccess-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 10/19/2024
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/New-EntraBetaPrivateAccessApplication
reviewer: andres-canello
schema: 2.0.0
title: New-EntraBetaPrivateAccessApplication
---

# New-EntraBetaPrivateAccessApplication

## Synopsis

Creates a Private Access application and assigns a connector group to it.

## Syntax

```powershell
New-EntraBetaPrivateAccessApplication
 -ApplicationName <String>
 [-ConnectorGroupId <String>]
 [<CommonParameters>]
```

## Description

The `New-EntraBetaPrivateAccessApplication` cmdlet creates a Private Access application and assigns a connector group to it.

## Examples

### Example 1: Create a new Private Access app and assign the default connector group

```powershell
Connect-Entra -Scopes 'NetworkAccessPolicy.ReadWrite.All', 'Application.ReadWrite.All', 'NetworkAccess.ReadWrite.All'
New-EntraBetaPrivateAccessApplication -ApplicationName 'Contoso GSA Application'
```

This example shows how to create a new Private Access application named `Contoso GSA Application` and assign it to the default connector group.

### Example 2: Create a new Private Access app and assign a specific connector group

```powershell
Connect-Entra -Scopes 'NetworkAccessPolicy.ReadWrite.All', 'Application.ReadWrite.All', 'NetworkAccess.ReadWrite.All'
$connectorGroup = Get-EntraBetaApplicationProxyConnectorGroup -Filter "Name eq 'Contoso GSA Group'"
New-EntraBetaPrivateAccessApplication -ApplicationName 'Contoso GSA Application' -ConnectorGroupId $connectorGroup.Id
```

This example shows how to create a new Private Access application named `Contoso GSA Application` and assign it to a specific connector group.

## Parameters

### -ApplicationName

The name of the new Private Access application.

```yaml
Type: System.String
Parameter Sets:
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ConnectorGroupId

Specifies a connector group to assign to the application. Use `Get-EntraBetaApplicationProxyConnectorGroup` to retrieve connector details or `New-EntraBetaApplicationProxyConnectorGroup` to create a new group.

```yaml
Type: System.String
Parameter Sets:
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

### System.String

System.Nullable\`1\[\[System. Boolean, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089\]\] System.Nullable\`1\[\[System.Int32, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089\]\]

## Outputs

### System.Object

## Notes

## RELATED LINKS

[Get-EntraBetaPrivateAccessApplication](Get-EntraBetaPrivateAccessApplication.md)
[Get-EntraBetaPrivateAccessApplicationSegment](Get-EntraBetaPrivateAccessApplicationSegment.md)
[Remove-EntraBetaPrivateAccessApplicationSegment](Remove-EntraBetaPrivateAccessApplicationSegment.md)
[New-EntraBetaPrivateAccessApplicationSegment](New-EntraBetaPrivateAccessApplicationSegment.md)
[New-EntraBetaApplicationProxyConnectorGroup](../Applications/New-EntraBetaApplicationProxyConnectorGroup.md)
