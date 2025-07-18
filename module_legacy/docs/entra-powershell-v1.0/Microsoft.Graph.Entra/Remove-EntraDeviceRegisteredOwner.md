---
title: Remove-EntraDeviceRegisteredOwner
description: This article provides details on the Remove-EntraDeviceRegisteredOwner command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: mwongerapk

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Remove-EntraDeviceRegisteredOwner

schema: 2.0.0
---

# Remove-EntraDeviceRegisteredOwner

## Synopsis

Removes the registered owner of a device.

## Syntax

```powershell
Remove-EntraDeviceRegisteredOwner
 -OwnerId <String>
 -DeviceId <String>
 [<CommonParameters>]
```

## Description

The `Remove-EntraDeviceRegisteredOwner` cmdlet removes the registered owner of a device in Microsoft Entra ID.

## Examples

### Example 1: Remove an owner from a device

```powershell
Connect-Entra -Scopes 'Directory.AccessAsUser.All'
$Device = Get-EntraDevice -Top 1
$Owner = Get-EntraDeviceRegisteredOwner -DeviceId $Device.ObjectId
Remove-EntraDeviceRegisteredOwner -DeviceId $Device.ObjectId -OwnerId $Owner.ObjectId
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

## Related Links

[Add-EntraDeviceRegisteredOwner](Add-EntraDeviceRegisteredOwner.md)

[Get-EntraDevice](Get-EntraDevice.md)

[Get-EntraDeviceRegisteredOwner](Get-EntraDeviceRegisteredOwner.md)
