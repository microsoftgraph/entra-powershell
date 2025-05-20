---
title: Set-EntraBetaApplicationProxyConnectorGroup
description: This article provides details on the Set-EntraBetaApplicationProxyConnectorGroup command.

ms.topic: reference
ms.date: 07/18/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Entra.Beta.Applications-Help.xml
Module Name: Microsoft.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Set-EntraBetaApplicationProxyConnectorGroup

schema: 2.0.0
---

# Set-EntraBetaApplicationProxyConnectorGroup

## Synopsis

The `Set-EntraBetaApplicationProxyConnectorGroup` cmdlet allows you to change the name of a given Application Proxy connector group.

## Syntax

```powershell
Set-EntraBetaApplicationProxyConnectorGroup
 -Id <String>
 -Name <Name>
 [<CommonParameters>]
```

## Description

The `Set-EntraBetaApplicationProxyConnectorGroup` cmdlet allows you to change the name of a given Application Proxy connector group. Specify `Id` and `Name` parameters to updates an connector group.

## Examples

### Example 1: Rename a Connector Group to "Offsite Application Servers"

```powershell
Connect-Entra -Scopes 'Directory.ReadWrite.All'
Set-EntraBetaApplicationProxyConnectorGroup -Id 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb' -Name 'Offsite Application Servers'
```

This example rename a Connector Group to "Offsite Application Servers"

- `Id` parameter specifies the connector group ID.
- `Name` parameter specifies the name for connector group.

## Parameters

### -Id

The unique identifier of the Connector group that should be renamed.
You can find the ID using the `Get-EntraBetaApplicationProxyConnectorGroup` command.

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

### -Name

The new name for the Connector group.

```yaml
Type: System.Name
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

## Outputs

## Notes

## Related links

[New-EntraBetaApplicationProxyConnectorGroup](New-EntraBetaApplicationProxyConnectorGroup.md)

[Get-EntraBetaApplicationProxyConnectorGroup](Get-EntraBetaApplicationProxyConnectorGroup.md)

[Remove-EntraBetaApplicationProxyConnectorGroup](Remove-EntraBetaApplicationProxyConnectorGroup.md)
