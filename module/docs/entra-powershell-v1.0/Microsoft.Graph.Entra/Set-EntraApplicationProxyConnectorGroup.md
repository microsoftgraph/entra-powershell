---
title: Set-EntraApplicationProxyConnectorGroup
description: This article provides details on the Set-EntraApplicationProxyConnectorGroup command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Set-EntraApplicationProxyConnectorGroup

schema: 2.0.0
---

# Set-EntraApplicationProxyConnectorGroup

## Synopsis
The Set-EntraApplicationProxyConnectorGroup cmdlet allows you to change the name of a given Application Proxy connector group.

## Syntax

```powershell
Set-EntraApplicationProxyConnectorGroup
 -Id <String>
 -Name <Name>
 [<CommonParameters>]
```

## Description
The Set-EntraApplicationProxyConnectorGroup cmdlet allows you to change the name of a given Application Proxy connector group.

## Examples

### Example 1: Rename a Connector Group to "Offsite Application Servers"
```powershell
PS C:\> Set-EntraApplicationProxyConnectorGroup -Id d533d7b1-fd92-49e8-a200-3e7dcf7c2ab5 -Name "Offsite Application Servers"
```

This command renames a Connector Group to "Offsite Application Servers".

## Parameters

### -Id
The unique identifier of the Connector group that is renamed.
You can find the ID using the [Get-EntraApplicationProxyConnectorGroup](./Get-EntraApplicationProxyConnectorGroup.md) command.

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

### -Name
The new name for the Connector group.

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

### System.String
### Microsoft.Open.MSGraph.Model.Name

## Outputs

### System.Object
## Notes

## RELATED LINKS