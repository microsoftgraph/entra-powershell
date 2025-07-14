---
author: msewaweru
description: This article provides details on the Remove-EntraBetaApplicationProxyConnectorGroup command.
external help file: Microsoft.Entra.Beta.Applications-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 07/18/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Remove-EntraBetaApplicationProxyConnectorGroup
schema: 2.0.0
title: Remove-EntraBetaApplicationProxyConnectorGroup
---

# Remove-EntraBetaApplicationProxyConnectorGroup

## SYNOPSIS

The `Remove-EntraBetaApplicationProxyConnectorGroup` cmdlet deletes an Application Proxy Connector group.

## SYNTAX

```powershell
Remove-EntraBetaApplicationProxyConnectorGroup
 -Id <String>
 [<CommonParameters>]
```

## DESCRIPTION

The `Remove-EntraBetaApplicationProxyConnectorGroup` cmdlet deletes an Application Proxy Connector Group.
It can only be used on an empty connector group, with no connectors assigned.

## EXAMPLES

### Example 1: Remove a specific Connector Group

```powershell
Connect-Entra -Scopes 'Directory.ReadWrite.All'
Remove-EntraBetaApplicationProxyConnectorGroup -Id 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'
```

This example removes a specific Connector Group.

- `Id` parameter specifies the connector group ID.

## PARAMETERS

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

## INPUTS

### System.String

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS

[New-EntraBetaApplicationProxyConnectorGroup](New-EntraBetaApplicationProxyConnectorGroup.md)

[Set-EntraBetaApplicationProxyConnectorGroup](Set-EntraBetaApplicationProxyConnectorGroup.md)

[Get-EntraBetaApplicationProxyConnectorGroup](Get-EntraBetaApplicationProxyConnectorGroup.md)
