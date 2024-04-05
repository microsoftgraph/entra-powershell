---
title: Get-EntraBetaApplicationProxyConnectorMemberOf
description: This article provides details on the Get-EntraBetaApplicationProxyConnectorMemberOf command.
ms.service: active-directory
ms.topic: reference
ms.date: 04/04/2023
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Get-EntraBetaApplicationProxyConnectorMemberOf

## SYNOPSIS
The Get-AzureADApplicationProxyConnectorMemberOf command gets the ConnectorGroup that the specified Connector is a member of.

## SYNTAX

```powershell
Get-EntraBetaApplicationProxyConnectorMemberOf
 -Id <String> 
 [<CommonParameters>]
```

## DESCRIPTION
The Get-EntraBetaApplicationProxyConnectorMemberOf command gets the ConnectorGroup that the specified Connector is a member of.
If no group is assigned to the connector, by default it is in 'Default.'

## EXAMPLES

### Example 1: Gets ConnectorGroup With Specified Connector ID.

```powershell
PS C:\> Get-EntraBetaApplicationProxyConnectorMemberOf -Id 147bd8b4-2134-4454-8f2a-1da81cf27917
```

```output
Name                           Value
----                           -----
id                             87ffe1e2-6313-4a22-93eb-da1eb8a2bf8d
region
connectorGroupType             applicationProxy
isDefault                      False
name                           test-group
```
This command gets the ConnectorGroup With Specified Connector ID.

## PARAMETERS

### -Id
The ID of the connector. You can find ID by running Get-EntraBetaApplicationProxyConnector.

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String
## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
[Get-EntraBetaApplicationProxyConnector](Get-EntraBetaApplicationProxyConnector.md)