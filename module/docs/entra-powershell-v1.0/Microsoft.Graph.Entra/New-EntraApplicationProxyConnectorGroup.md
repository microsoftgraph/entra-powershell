---
title: New-EntraApplicationProxyConnectorGroup.
description: This article provides details on the New-EntraApplicationProxyConnectorGroup Command.

ms.service: entra
ms.topic: reference
ms.date: 03/28/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# New-EntraApplicationProxyConnectorGroup

## SYNOPSIS
The New-EntraApplicationProxyConnectorGroup cmdlet creates a new Application Proxy Connector group.

## SYNTAX

```powershell
New-EntraApplicationProxyConnectorGroup 
 -Name <Name> 
 [<CommonParameters>]
```

## DESCRIPTION
The New-EntraApplicationProxyConnectorGroup cmdlet creates a new Application Proxy connector group.

## EXAMPLES

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

## PARAMETERS

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

## INPUTS

### Microsoft.Open.MSGraph.Model.Name
## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
