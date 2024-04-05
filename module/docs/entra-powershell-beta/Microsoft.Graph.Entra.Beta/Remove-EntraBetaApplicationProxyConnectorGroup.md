---
title: Remove-EntraBetaApplicationProxyConnectorGroup.
description: This article provides details on the Remove-EntraBetaApplicationProxyConnectorGroup command.
ms.service: active-directory
ms.topic: reference
ms.date: 04/03/2023
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Remove-EntraBetaApplicationProxyConnectorGroup

## SYNOPSIS
The Remove-EntraBetaApplicationProxyConnectorGroup cmdlet deletes an Application Proxy Connector group.

## SYNTAX

```powershell
Remove-EntraBetaApplicationProxyConnectorGroup 
 -Id <String> 
 [<CommonParameters>]
```

## DESCRIPTION
The Remove-EntraBetaApplicationProxyConnectorGroup cmdlet deletes an Application Proxy Connector Group.
It can only be used on an empty connector group, with no connectors assigned.

## EXAMPLES

### Example 1: Remove a specific Connector Group
```powershell
PS C:\> Get-EntraBetaApplicationProxyConnectorGroup -Id 59462d3c-a1bc-40a0-9bed-be799357ebce
```
This command Remove a specific Connector Group.

## PARAMETERS

### -Id
The ID of the Connector group to delete.
You can find this value by running the Get-EntraBetaApplicationProxyConnectorGroup command.

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
[Get-EntraBetaApplicationProxyConnectorGroup](Get-EntraBetaApplicationProxyConnectorGroup.md)