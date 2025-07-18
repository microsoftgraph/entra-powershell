---
description: This article provides details on the Get-EntraEnvironment command.
external help file: Microsoft.Entra.Authentication-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra
ms.author: eunicewaweru
ms.date: 06/26/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Get-EntraEnvironment
schema: 2.0.0
title: Get-EntraEnvironment
---

# Get-EntraEnvironment

## SYNOPSIS

Gets global public Environments.

## SYNTAX

### GetQuery (Default)

```powershell
Get-EntraEnvironment
 [<CommonParameters>]
```

### GetByName

```powershell
Get-EntraEnvironment
 -Name <String>
 [<CommonParameters>]
```

## DESCRIPTION

When you use `Connect-Entra`, you can choose to target other environments. By default, `Connect-Entra` targets the global public cloud.

## EXAMPLES

### Example 1: Get a list of public cloud environments

```powershell
Get-EntraEnvironment
```

```Output
Name     AzureADEndpoint                   GraphEndpoint                           Type
----     ---------------                   -------------                           ----
Global   https://login.microsoftonline.com https://graph.microsoft.com             Built-in
China    https://login.chinacloudapi.cn    https://microsoftgraph.chinacloudapi.cn Built-in
USGovDoD https://login.microsoftonline.us  https://dod-graph.microsoft.us          Built-in
USGov    https://login.microsoftonline.us  https://graph.microsoft.us              Built-in
Germany  https://login.microsoftonline.de  https://graph.microsoft.de              Built-in
Canary   https://login.microsoftonline.com https://canary.graph.microsoft.com      User-defined
```

This command retrieves a list of global public Environments.

### Example 2: Get a specific environment created

```powershell
Get-EntraEnvironment -Name 'Global'
```

```Output
Name   AzureADEndpoint                   GraphEndpoint               Type
----   ---------------                   -------------               ----
Global https://login.microsoftonline.com https://graph.microsoft.com Built-in
```

This command retrieves an environment with the specified name.

## PARAMETERS

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

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Add-EntraEnvironment](Add-EntraEnvironment.md)
