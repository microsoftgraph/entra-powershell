---
title: Remove-EntraApplicationProxyConnectorGroup.
description: This article provides details on the Remove-EntraApplicationProxyConnectorGroup Command.

ms.service: active-directory
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

# Remove-EntraApplicationProxyConnectorGroup

## SYNOPSIS
The Remove-EntraApplicationProxyConnectorGroup cmdlet deletes an Application Proxy Connector group.

## SYNTAX

```
Remove-EntraApplicationProxyConnectorGroup 
-Id <String> 
[<CommonParameters>]
```

## DESCRIPTION
The Remove-EntraApplicationProxyConnectorGroup cmdlet deletes an Application Proxy Connector Group.
It can only be used on an empty connector group, with no connectors assigned.

## EXAMPLES

### Example 1: Remove a specific Connector Group
```powershell
PS C:\> Remove-EntraApplicationProxyConnectorGroup -Id 59462d3c-a1bc-40a0-9bed-be799357ebce
```

This example demonstrates how to Remove a specific Connector Group.

## PARAMETERS

### -Id
The ID of the Connector group to delete.
You can find this value by running the Get-EntraApplicationProxyConnectorGroup command.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String
## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
