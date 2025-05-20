---
title: Get-EntraBetaApplicationProxyConnectorMemberOf
description: This article provides details on the Get-EntraBetaApplicationProxyConnectorMemberOf command.


ms.topic: reference
ms.date: 07/17/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Get-EntraBetaApplicationProxyConnectorMemberOf

schema: 2.0.0
---

# Get-EntraBetaApplicationProxyConnectorMemberOf

## Synopsis

The `Get-EntraBetaApplicationProxyConnectorMemberOf` command gets the ConnectorGroup that the specified Connector is a member of.

## Syntax

```powershell
Get-EntraBetaApplicationProxyConnectorMemberOf
 -OnPremisesPublishingProfileId <String>
 [<CommonParameters>]
```

## Description

The `Get-EntraBetaApplicationProxyConnectorMemberOf` command gets the ConnectorGroup that the specified Connector is a member of.
If no group is assigned to the connector, by default it is in 'Default.'

## Examples

### Example 1: Gets ConnectorGroup With Specified Connector ID

```powershell
Connect-Entra -Scopes 'Directory.ReadWrite.All'
Get-EntraBetaApplicationProxyConnectorMemberOf -OnPremisesPublishingProfileId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'
```

```Output
Id                                   ConnectorGroupType IsDefault Name                       Region
--                                   ------------------ --------- ----                       ------
bbbbbbbb-1111-2222-3333-cccccccccccc applicationProxy   False     Backup Application Servers
```

This example retrieves the ConnectorGroup With Specified Connector ID.  

- `-OnPremisesPublishingProfileId` parameter specifies the connector ID.

## Parameters

### -OnPremisesPublishingProfileId

The ID of the connector. You can find ID by running `Get-EntraBetaApplicationProxyConnector`.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: Id

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

### System.String

## Outputs

### System.Object

## Notes

## Related links

[Get-EntraBetaApplicationProxyConnector](Get-EntraBetaApplicationProxyConnector.md)
