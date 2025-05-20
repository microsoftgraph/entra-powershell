---
title: Set-EntraBetaApplicationProxyApplicationConnectorGroup
description: This article provides details on the Set-EntraBetaApplicationProxyApplicationConnectorGroup command.

ms.topic: reference
ms.date: 07/16/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Entra.Beta.Applications-Help.xml
Module Name: Microsoft.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Set-EntraBetaApplicationProxyApplicationConnectorGroup

schema: 2.0.0
---

# Set-EntraBetaApplicationProxyApplicationConnectorGroup

## Synopsis

The `Set-EntraBetaApplicationProxyApplicationConnectorGroup` cmdlet assigns the given connector group to a specified application.

## Syntax

```powershell
Set-EntraBetaApplicationProxyApplicationConnectorGroup
 -OnPremisesPublishingProfileId <String>
 -ConnectorGroupId <String>
 [<CommonParameters>]
```

## Description

The `Set-EntraBetaApplicationProxyApplicationConnectorGroup` cmdlet sets the connector group assigned for the specified application. Specify `OnPremisesPublishingProfileId` and `ConnectorGroupId` parameter to assign the given connector group to a specified application.

The application must be configured for Application Proxy in Microsoft Entra ID.

## Examples

### Example 1: Set a new Connector Group for a specific application

```powershell
Connect-Entra -Scopes 'Directory.ReadWrite.All'
$params = @{
    OnPremisesPublishingProfileId = 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb' 
    ConnectorGroupId = 'bbbbbbbb-1111-2222-3333-cccccccccccc'
}
Set-EntraBetaApplicationProxyApplicationConnectorGroup @params
```

This example set a new Connector Group for a specific application.

- `OnPremisesPublishingProfileId` parameter specifies the application ID.
- `ConnectorGroupId` parameter specifies the connector group ID that assign to the application.

## Parameters

### -ConnectorGroupId

The ID of the Connector group that should be assigned to the application.
Use the `Get-EntraBetaApplicationProxyConnectorGroup` command to find the Connector Group ID.

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

### -OnPremisesPublishingProfileId

The unique application ID for the application the Connector group assigns to.
The application ID can be found using the `Get-EntraBetaApplication` command.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: ObjectId

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

[Get-EntraBetaApplicationProxyApplicationConnectorGroup](Get-EntraBetaApplicationProxyApplicationConnectorGroup.md)

[Remove-EntraBetaApplicationProxyApplicationConnectorGroup](Remove-EntraBetaApplicationProxyApplicationConnectorGroup.md)
