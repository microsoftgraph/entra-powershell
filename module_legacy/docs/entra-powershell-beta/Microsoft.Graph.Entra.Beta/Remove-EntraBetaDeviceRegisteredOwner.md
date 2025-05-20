---
title: Remove-EntraBetaDeviceRegisteredOwner
description: This article provides details on the Remove-EntraBetaDeviceRegisteredOwner command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Remove-EntraBetaDeviceRegisteredOwner

schema: 2.0.0
---

# Remove-EntraBetaDeviceRegisteredOwner

## Synopsis

Removes the registered owner of a device.

## Syntax

```powershell
Remove-EntraBetaDeviceRegisteredOwner
 -OwnerId <String>
 -DeviceId <String>
 [<CommonParameters>]
```

## Description

The `Remove-EntraBetaDeviceRegisteredOwner` cmdlet removes the registered owner of a device in Microsoft Entra ID.

## Examples

### Example 1: Remove an owner from a device

```powershell
Connect-Entra -Scopes 'Directory.AccessAsUser.All'
$Device = Get-EntraBetaDevice -Top 1
$Owner = Get-EntraBetaDeviceRegisteredOwner -ObjectId $Device.ObjectId
Remove-EntraBetaDeviceRegisteredOwner -DeviceId $Device.ObjectId -OwnerId $Owner.ObjectId
```

This examples shows how to remove the owner of a device.

## Parameters

### -DeviceId

Specifies an object ID.

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

### -OwnerId

Specifies an owner ID.

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

## Outputs

## Notes

## Related links

[Add-EntraBetaDeviceRegisteredOwner](Add-EntraBetaDeviceRegisteredOwner.md)

[Get-EntraBetaDevice](Get-EntraBetaDevice.md)

[Get-EntraBetaDeviceRegisteredOwner](Get-EntraBetaDeviceRegisteredOwner.md)
