---
author: msewaweru
description: This article provides details on the Remove-EntraBetaApplicationProxyApplicationConnectorGroup command.
external help file: Microsoft.Entra.Beta.Applications-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 07/15/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Remove-EntraBetaApplicationProxyApplicationConnectorGroup
schema: 2.0.0
title: Remove-EntraBetaApplicationProxyApplicationConnectorGroup
---

# Remove-EntraBetaApplicationProxyApplicationConnectorGroup

## SYNOPSIS

The `Remove-EntraBetaApplicationProxyApplicationConnectorGroupcmdlet` sets the connector group assigned for the specified application to 'Default' and removes the current assignment.

## SYNTAX

```powershell
Remove-EntraBetaApplicationProxyApplicationConnectorGroup
 -OnPremisesPublishingProfileId <String>
 [<CommonParameters>]
```

## DESCRIPTION

If your application is already in the 'Default' group, you see an error because the application can't be removed from the 'Default' group unless it's being added to another group.
The application must be configured for Application Proxy in Microsoft Entra ID.

## EXAMPLES

### Example 1: Remove the Connector Group associated with an application, setting the group to 'Default'

```POWERSHELL
Connect-Entra -Scopes 'Directory.ReadWrite.All'
Remove-EntraBetaApplicationProxyApplicationConnectorGroup -OnPremisesPublishingProfileId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'
```

This example removes the Connector Group associated with an application, setting the group to 'Default.'

- `OnPremisesPublishingProfileId` parameter specifies the application ID.

## PARAMETERS

### -OnPremisesPublishingProfileId

The unique application ID of the application.
The application ID can be found using the `Get-EntraBetaApplication` command.
You can also find objectId  in the Microsoft Entra Admin Center by navigating to Microsoft Entra ID > App registrations > All applications. Select your application. From the application overview page, copy the ObjectId.

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

## INPUTS

### System.String

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS

[Set-EntraBetaApplicationProxyApplicationConnectorGroup](Set-EntraBetaApplicationProxyApplicationConnectorGroup.md)

[Get-EntraBetaApplicationProxyApplicationConnectorGroup](Get-EntraBetaApplicationProxyApplicationConnectorGroup.md)
