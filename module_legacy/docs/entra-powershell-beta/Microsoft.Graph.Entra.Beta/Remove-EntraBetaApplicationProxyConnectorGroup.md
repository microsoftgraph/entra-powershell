---
title: Remove-EntraBetaApplicationProxyConnectorGroup
description: This article provides details on the Remove-EntraBetaApplicationProxyConnectorGroup command.

ms.topic: reference
ms.date: 07/18/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: mwongerapk
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Remove-EntraBetaApplicationProxyConnectorGroup

schema: 2.0.0
---

# Remove-EntraBetaApplicationProxyConnectorGroup

## Synopsis

The `Remove-EntraBetaApplicationProxyConnectorGroup` cmdlet deletes an Application Proxy Connector group.

## Syntax

```powershell
Remove-EntraBetaApplicationProxyConnectorGroup
 -Id <String>
 [<CommonParameters>]
```

## Description

The `Remove-EntraBetaApplicationProxyConnectorGroup` cmdlet deletes an Application Proxy Connector Group.
It can only be used on an empty connector group, with no connectors assigned.

## Examples

### Example 1: Remove a specific Connector Group

```powershell
Connect-Entra -Scopes 'Directory.ReadWrite.All'
Remove-EntraBetaApplicationProxyConnectorGroup -Id 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'
```

This example removes a specific Connector Group.

- `Id` parameter specifies the connector group ID.

## Parameters

### -Id

The ID of the Connector group to delete.
You can find this value by running the `Get-EntraBetaApplicationProxyConnectorGroup` command.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

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

## Related Links

[New-EntraBetaApplicationProxyConnectorGroup](New-EntraBetaApplicationProxyConnectorGroup.md)

[Set-EntraBetaApplicationProxyConnectorGroup](Set-EntraBetaApplicationProxyConnectorGroup.md)

[Get-EntraBetaApplicationProxyConnectorGroup](Get-EntraBetaApplicationProxyConnectorGroup.md)
