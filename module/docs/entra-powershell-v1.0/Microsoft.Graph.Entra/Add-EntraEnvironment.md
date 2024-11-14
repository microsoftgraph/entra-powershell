---
title: Add-EntraEnvironment
description: This article provides details on the Add-EntraEnvironment command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Add-EntraEnvironment

schema: 2.0.0
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
$params = @{
    Name = 'Canary'
    GraphEndpoint = 'https://canary.graph.microsoft.com'
    AzureADEndpoint = 'https://login.microsoftonline.com'
}

Add-EntraEnvironment @params
```

```Output
Name     AzureADEndpoint                      GraphEndpoint                 Type
----     ---------------                      -------------                 ----
Canary    https://login.microsoftonline.com   https://microsoftgraph.com User-defined                                                                                    {}
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

## Related Links

[Get-EntraEnvironment](Get-EntraEnvironment.md)
