---
author: msewaweru
description: This article provides details on the Set-EntraBetaApplicationProxyConnector command.
external help file: Microsoft.Entra.Beta.Applications-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 07/16/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Set-EntraBetaApplicationProxyConnector
schema: 2.0.0
title: Set-EntraBetaApplicationProxyConnector
---

# Set-EntraBetaApplicationProxyConnector

## SYNOPSIS

The `Set-EntraBetaApplicationProxyConnector` cmdlet allows reassignment of the connector to another connector group.

## SYNTAX

```powershell
Set-EntraBetaApplicationProxyConnector
 -OnPremisesPublishingProfileId <String>
 -ConnectorGroupId <String>
 [<CommonParameters>]
```

## DESCRIPTION

The `Set-EntraBetaApplicationProxyConnector` cmdlet allows reassignment of the connector to another connector group.

## EXAMPLES

### Example 1: Move a Connector to a different Connector Group

```powershell
Connect-Entra -Scopes 'Directory.ReadWrite.All'
$params = @{
    OnPremisesPublishingProfileId = 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb' 
    ConnectorGroupId = 'bbbbbbbb-1111-2222-3333-cccccccccccc'
}
Set-EntraBetaApplicationProxyConnector @params
```

This example demonstrates how to move a Connector to a different Connector Group.

- `-OnPremisesPublishingProfileId` parameter specifies the connector ID.
- `-ConnectorGroupId` parameter specifies the application proxy connector group ID.

## PARAMETERS

### -OnPremisesPublishingProfileId

The ID of the Connector being moved.
Use the `Get-EntraBetaApplicationProxyConnectorGroup` command to find the Connector Group ID.

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

### -ConnectorGroupId

The unique identifer of the target application proxy connector group in Microsoft Entra ID.
Find this value using the `Get-EntraBetaApplicationProxyConnectorGroup` command.

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

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraBetaApplicationProxyConnectorGroup](Get-EntraBetaApplicationProxyConnectorGroup.md)
[Get-EntraBetaApplicationProxyConnector](Get-EntraBetaApplicationProxyConnector.md)
