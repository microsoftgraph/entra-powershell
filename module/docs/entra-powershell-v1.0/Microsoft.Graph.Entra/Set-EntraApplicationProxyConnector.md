---
title: Set-EntraApplicationProxyConnector
description: This article provides details on the Set-EntraApplicationProxyConnector command.

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

# Set-EntraApplicationProxyConnector

## SYNOPSIS
The Set-EntraApplicationProxyConnector cmdlet allows reassignment of the connector to another connector group.

## SYNTAX

```powershell
Set-EntraApplicationProxyConnector
 -Id <String>
 -ConnectorGroupId <String>
 [<CommonParameters>]
```

## DESCRIPTION
The Set-EntraApplicationProxyConnector cmdlet allows reassignment of the connector to another connector group.

## EXAMPLES

### Example 1: Move a Connector to a different Connector Group
```powershell
PS C:\> Set-EntraApplicationProxyConnector -Id 834c5dd6-f2e8-47ae-973a-9fc769289b3d -ConnectorGroupId a39b9095-8dc8-4d3a-86c3-e7b5c3f0fb84
```

This command moves a Connector to a different Connector Group.

## PARAMETERS

### -Id
The ID of the Connector being moved.
You can find this value using the [Get-EntraApplicationProxyConnector](./Get-EntraApplicationProxyConnector.md) command.

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

### -ConnectorGroupId
The unique identifer of the target application proxy connector group in Microsoft Entra ID.
You can find this value using the [Get-EntraApplicationProxyConnectorGroup](./Get-EntraApplicationProxyConnectorGroup.md) command.

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

## OUTPUTS

## NOTES

## RELATED LINKS