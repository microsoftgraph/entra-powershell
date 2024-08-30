---
title: Get-EntraApplicationProxyConnectorMemberOf
description: This article provides details on the Get-EntraApplicationProxyConnectorMemberOf Command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Get-EntraApplicationProxyConnectorMemberOf

schema: 2.0.0
---

# Get-EntraApplicationProxyConnectorMemberOf.

## Synopsis
The Get-EntraApplicationProxyConnectorMemberOf command gets the ConnectorGroup that the specified Connector is a member of.

## Syntax

```powershell
Get-EntraApplicationProxyConnectorMemberOf 
 -Id <String> 
 [<CommonParameters>]
```

## Description
The Get-EntraApplicationProxyConnectorMemberOf command gets the ConnectorGroup that the specified Connector is a member of.
If no group is assigned to the connector, by default it is in 'Default.'

## Examples

### Example 1: Gets the ConnectorGroup

```powershell
PS C:\> Get-EntraApplicationProxyConnectorMemberOf -Id 4c8b06e7-9751-41d5-8e5e-48e9b9bc2c66
```
```output

Id                                   Name                ConnectorGroupType IsDefault
--                                   ----                ------------------ ---------
a39b9095-8dc8-4d3a-86c3-e7b5c3f0fb84 Application Servers applicationProxy       False
```
This example demonstrates how to retrieve the ConnectorGroup that the specified Connector is a member of.

## Parameters

### -Id
The ID of the connector.
You can find ID by running Get-EntraApplicationProxyConnector.

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

## Inputs

### System.String
## Outputs

### System.Object
## Notes

## Related Links
