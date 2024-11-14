---
title: New-EntraApplicationProxyConnectorGroup
description: This article provides details on the New-EntraApplicationProxyConnectorGroup Command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/New-EntraApplicationProxyConnectorGroup

schema: 2.0.0
---

# New-EntraApplicationProxyConnectorGroup

## Synopsis
The New-EntraApplicationProxyConnectorGroup cmdlet creates a new Application Proxy Connector group.

## Syntax

```powershell
New-EntraApplicationProxyConnectorGroup 
 -Name <Name> 
 [<CommonParameters>]
```

## Description
The New-EntraApplicationProxyConnectorGroup cmdlet creates a new Application Proxy connector group.

## Examples

### Example 1: Create a new Connector Group
```powershell
PS C:\> New-EntraApplicationProxyConnectorGroup -Name "Backup Application Servers"
```
```outout
Id                                   Name                       ConnectorGroupType IsDefault
--                                   ----                       ------------------ ---------
d533d7b1-fd92-49e8-a200-3e7dcf7c2ab5 Backup Application Servers applicationProxy       False
```

This example demonstrated how to create a new Connector Group with the name "Backup Application Servers"

## Parameters

### -Name
The name of the new Connector Group.

```yaml
Type: Name
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

### Microsoft.Open.MSGraph.Model.Name
## Outputs

### System.Object
## Notes

## Related Links
