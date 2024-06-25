---
title: Get-EntraEnvironment
description: This article provides details on the Get-EntraEnvironment command.

ms.service: entra
ms.topic: reference
ms.date: 05/07/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraEnvironment

## Synopsis

Gets global public Environments.

## Syntax

### GetQuery (Default)

```powershell
Get-EntraEnvironment 
 [<CommonParameters>]
```

### GetByName

```powershell
PS C:\>Get-EntraEnvironment 
 -Name <String> 
 [<CommonParameters>]
```

## Description

When you use Connect-Entra, you can choose to target other environments. By default, Connect-Entra targets the global public cloud.

## Examples

### Example 1: Get a list of public cloud environments

```powershell
PS C:\>Get-EntraEnvironment
```

```output
Name , AzureADEndpoint, GraphEndpoint, Type
---------         ------------------------------ --------------------------- ---------------
China    https://login.chinacloudapi.cn    https://microsoftgraph.chinacloudapi.cn Built-in
Global   https://login.microsoftonline.com https://graph.microsoft.com             Built-in
USGov    https://login.microsoftonline.us  https://graph.microsoft.us              Built-in
USGovDoD https://login.microsoftonline.us  https://dod-graph.microsoft.us          Built-in
Germany  https://login.microsoftonline.de  https://graph.microsoft.de              Built-in                                                                                      {}
```

This command retrieves a list of global public Environments.

### Example 2: Get a specific environment created.

```powershell
PS C:\>Get-EntraEnvironment -Name "Global"
```

```output
Name , AzureADEndpoint, GraphEndpoint, Type

--------         ------------------ ------------------ --------
Global   https://login.microsoftonline.com https://graph.microsoft.com             Built-in                                                                                  {}
```

This command retrieves an environment with the specified name.

## Parameters

### -Name

Specifies the name of an environment

```yaml

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

## Related LINKS

[Add-EntraEnvironment](Add-EntraEnvironment.md)
