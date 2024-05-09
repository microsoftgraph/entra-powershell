---
title: Add-EntraEnvironment
description: This article provides details on the Add-EntraEnvironment command.

ms.service: active-directory
ms.topic: reference
ms.date: 03/16/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Add-EntraEnvironment

## SYNOPSIS

Adds Microsoft Entra environment to the settings file.

## SYNTAX


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

## DESCRIPTION

Adds Microsoft Entra environment to the settings file.

## EXAMPLES

### Example 1: Get a list of public cloud environments

```powershell
Add-EntraEnvironment -Name "Canary" -GraphEndpoint "https://canary.graph.microsoft.com" -AzureADEndpoint "https://login.microsoftonline.com"
Name     AzureADEndpoint                      GraphEndpoint                 Type
----     ---------------                      -------------                 ----
Canary    https://login.microsoftonline.com   https://microsoftgraph.com User-defined                                                                                    {}
```

## PARAMETERS

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

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraEnvironment](Get-EntraEnvironment.md)
