---
author: msewaweru
description: This article provides details on the Get-EntraBetaApplicationProxyConnectorMemberOf command.
external help file: Microsoft.Entra.Beta.Applications-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 07/17/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Get-EntraBetaApplicationProxyConnectorMemberOf
schema: 2.0.0
title: Get-EntraBetaApplicationProxyConnectorMemberOf
---

# Get-EntraBetaApplicationProxyConnectorMemberOf

## SYNOPSIS

The `Get-EntraBetaApplicationProxyConnectorMemberOf` command gets the ConnectorGroup that the specified Connector is a member of.

## SYNTAX

```powershell
Get-EntraBetaApplicationProxyConnectorMemberOf
 -OnPremisesPublishingProfileId <String>
 [<CommonParameters>]
```

## DESCRIPTION

The `Get-EntraBetaApplicationProxyConnectorMemberOf` command gets the ConnectorGroup that the specified Connector is a member of.
If no group is assigned to the connector, by default it is in 'Default.'

## EXAMPLES

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

## PARAMETERS

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

## INPUTS

### System.String

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS

[Get-EntraBetaApplicationProxyConnector](Get-EntraBetaApplicationProxyConnector.md)
