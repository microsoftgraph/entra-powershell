---
title: Add-EntraBetaDeviceRegisteredOwner
description: This article provides details on the Add-EntraBetaDeviceRegisteredOwner command.


ms.topic: reference
ms.date: 08/14/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Add-EntraBetaDeviceRegisteredOwner

schema: 2.0.0
---

# Add-EntraBetaDeviceRegisteredOwner

## Synopsis

Adds a registered owner for a device.

## Syntax

```powershell
Add-EntraBetaDeviceRegisteredOwner
 -DeviceId <String>
 -RefObjectId <String>
 [<CommonParameters>]
```

## Description

The `Add-EntraBetaDeviceRegisteredOwner` cmdlet adds a registered owner for a Microsoft Entra ID device.

## Examples

### Example 1: Add a user as a registered owner

```powershell
Connect-Entra -Scopes 'Device.ReadWrite.All'
$User = Get-EntraBetaUser -UserId 'SawyerM@contoso.com'
$Device = Get-EntraBetaDevice -SearchString '<device-display-name>'
$params = @{
    DeviceId = $Device.ObjectId 
    RefObjectId = $User.ObjectId
}
Add-EntraBetaDeviceRegisteredOwner  @params
```

This example shows how to add a registered owner to a device.

`-DeviceId` parameter specifies the unique identifier (Object ID) of the device to which you want to add a registered owner. The $Device.ObjectId variable should contain the Object ID of the device. You can use the command `Get-EntraBetaDevice` to get device Id.

`-RefObjectId` parameter specifies the unique identifier (Object ID) of the user who will be added as a registered owner of the device. The $User.ObjectId variable should contain the Object ID of the user. You can use the command `Get-EntraBetaUser` to get user Id.

## Parameters

### -DeviceId

Specifies the ID of the device.

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

### -RefObjectId

Specifies the ID of the Microsoft Entra ID object to add.

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

[Get-EntraBetaDeviceRegisteredOwner](Get-EntraBetaDeviceRegisteredOwner.md)

[Remove-EntraBetaDeviceRegisteredOwner](Remove-EntraBetaDeviceRegisteredOwner.md)
