---
author: msewaweru
description: This article provides details on the New-EntraBetaApplicationProxyConnectorGroupcommand.
external help file: Microsoft.Entra.Beta.Applications-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 07/16/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/New-EntraBetaApplicationProxyConnectorGroup
schema: 2.0.0
title: New-EntraBetaApplicationProxyConnectorGroup
---

# New-EntraBetaApplicationProxyConnectorGroup

## SYNOPSIS

The `New-EntraBetaApplicationProxyConnectorGroup` cmdlet creates a new Application Proxy Connector group.

## SYNTAX

```powershell
New-EntraBetaApplicationProxyConnectorGroup
 -Name <Name>
 [<CommonParameters>]
```

## DESCRIPTION

The `New-EntraBetaApplicationProxyConnectorGroup` cmdlet creates a new Application Proxy connector group.

## EXAMPLES

### Example 1: Create a new Connector Group

```powershell
Connect-Entra -Scopes 'Directory.ReadWrite.All'
New-EntraBetaApplicationProxyConnectorGroup -Name 'Backup Application Servers'
```

```Output
Name                           Value
----                           -----
id                             aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb
@odata.context                 https://graph.microsoft.com/beta/$metadata#onPremisesPublishingProfiles('applicationProxy')/connectorGroups/$entity
isDefault                      False
name                           Backup Application Servers
region                         eur
connectorGroupType             applicationProxy
```

This example creates a new Connector Group using specified name.

- `-Name` parameter specifies the new connector group name.

## PARAMETERS

### -Name

The name of the new Connector Group.

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

## INPUTS

### Microsoft.Open.MSGraph.Model.Name

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS

[Set-EntraBetaApplicationProxyConnectorGroup](Set-EntraBetaApplicationProxyConnectorGroup.md)

[Get-EntraBetaApplicationProxyConnectorGroup](Get-EntraBetaApplicationProxyConnectorGroup.md)

[Remove-EntraBetaApplicationProxyConnectorGroup](Remove-EntraBetaApplicationProxyConnectorGroup.md)
