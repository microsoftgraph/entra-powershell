---
title: Remove-EntraBetaDeviceRegisteredUser
description: This article provides details on the Remove-EntraBetaDeviceRegisteredUser command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Entra.Beta.DirectoryManagement-Help.xml
Module Name: Microsoft.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Remove-EntraBetaDeviceRegisteredUser

schema: 2.0.0
---

# Remove-EntraBetaDeviceRegisteredUser

## Synopsis

Removes a registered user from a device.

## Syntax

```powershell
Remove-EntraBetaDeviceRegisteredUser
 -DeviceId <String>
 -UserId <String>
 [<CommonParameters>]
```

## Description

The `Remove-EntraBetaDeviceRegisteredUser` cmdlet removes a registered user from a Microsoft Entra ID device.

## Examples

### Example 1: Remove a registered user from a device

```Powershell
Connect-Entra -Scopes 'Directory.AccessAsUser.All'
$Device = Get-EntraBetaDevice -Top 1
$User = Get-EntraBetaDeviceRegisteredUser -DeviceId $Device.ObjectId
Remove-EntraBetaDeviceRegisteredUser -DeviceId $Device.ObjectId -UserId $User.ObjectId
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

[Add-EntraBetaDeviceRegisteredUser](Add-EntraBetaDeviceRegisteredUser.md)

[Get-EntraBetaDeviceRegisteredUser](Get-EntraBetaDeviceRegisteredUser.md)
