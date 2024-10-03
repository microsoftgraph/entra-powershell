---
title: Remove-EntraDeviceRegisteredUser
description: This article provides details on the Remove-EntraDeviceRegisteredUser command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Remove-EntraDeviceRegisteredUser

schema: 2.0.0
---

# Remove-EntraDeviceRegisteredUser

## Synopsis

Removes a registered user from a device.

## Syntax

```powershell
Remove-EntraDeviceRegisteredUser
 -DeviceId <String>
 -UserId <String>
 [<CommonParameters>]
```

## Description

The `Remove-EntraDeviceRegisteredUser` cmdlet removes a registered user from a Microsoft Entra ID device.

## Examples

### Example 1: Remove a registered user from a device

```Powershell
Connect-Entra -Scopes 'Directory.AccessAsUser.All'
$Device = Get-EntraDevice -Top 1
$User = Get-EntraDeviceRegisteredUser -DeviceId $Device.ObjectId
Remove-EntraDeviceRegisteredUser -DeviceId $Device.ObjectId -UserId $User.ObjectId
```

This example shows how to remove the registered user from device.

## Parameters

### -DeviceId

Specifies the ID of an object.

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

### -UserId

Specifies the ID of a user.

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

[Add-EntraDeviceRegisteredUser](Add-EntraDeviceRegisteredUser.md)

[Get-EntraDeviceRegisteredUser](Get-EntraDeviceRegisteredUser.md)
