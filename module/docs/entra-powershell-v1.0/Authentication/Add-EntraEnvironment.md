---
description: This article provides details on the Add-EntraEnvironment command.
external help file: Microsoft.Entra.Authentication-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra
ms.author: eunicewaweru
ms.date: 06/26/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Add-EntraEnvironment
schema: 2.0.0
title: Add-EntraEnvironment
---

# Add-EntraEnvironment

## Synopsis

Adds Microsoft Entra environment to the settings file.

## Syntax

### Add Entra Environment Name

```powershell
Add-EntraEnvironment
 [-Name] <String>
 [-AzureADEndpoint] <String>
 [-GraphEndpoint] <String>
 [-ProgressAction <ActionPreference>]
 [-WhatIf]
 [-Confirm]
 [<CommonParameters>]
```

## Description

Adds Microsoft Entra environment to the settings file.

## Examples

### Example 1: Add a user defined environment

```powershell
$name = 'Canary'
$graphEndpoint = 'https://canary.graph.microsoft.com'
$azureADEndpoint = 'https://login.microsoftonline.com'
Add-EntraEnvironment -Name $name -GraphEndpoint $graphEndpoint -AzureADEndpoint $azureADEndpoint
```

```Output
Name       AzureADEndpoint                      GraphEndpoint                 Type          
----       ---------------                      -------------                 ----          
Canary     https://login.microsoftonline.com    https://microsoftgraph.com    User-defined  
```

Adds a user-defined Entra environment to the settings file.

## Parameters

### -Name

Specifies the name of an environment

```yaml

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -GraphEndpoint

Specifies the GraphEndpoint URL of an environment

```yaml

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -AzueADEndpoint

Specifies the AzureADEndpoint URL of an environment

```yaml

Required: True
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

## Related links

[Get-EntraEnvironment](Get-EntraEnvironment.md)
