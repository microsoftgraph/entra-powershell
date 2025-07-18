---
title: Add-EntraBetaDeviceRegisteredUser
description: This article provides details on the Add-EntraBetaDeviceRegisteredUser command.


ms.topic: reference
ms.date: 08/14/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: mwongerapk
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Add-EntraBetaDeviceRegisteredUser

schema: 2.0.0
---

# Add-EntraBetaDeviceRegisteredUser

## Synopsis

Adds a registered user for a device.

## Syntax

```powershell
Add-EntraBetaDeviceRegisteredUser
 -DeviceId <String>
 -RefObjectId <String>
 [<CommonParameters>]
```

## Description

The `Add-EntraBetaDeviceRegisteredUser` cmdlet adds a registered user for a Microsoft Entra ID device.

## Examples

### Example 1: Add a user as a registered user

```powershell
Connect-Entra -Scopes 'Device.ReadWrite.All'
$User = Get-EntraBetaUser -UserId 'SawyerM@contoso.com'
$Device = Get-EntraBetaDevice -SearchString '<device-display-name>'
$params = @{
    DeviceId = $Device.ObjectId 
    RefObjectId = $User.ObjectId
}
Add-EntraBetaDeviceRegisteredUser @params
```

This example shows how to add a registered user to a device.

- `-DeviceId` parameter specifies the unique identifier (Object ID) of the device to which you want to add a registered user. The $Device.ObjectId variable should contain the Object ID of the device. You can use the command `Get-EntraBetaDevice` to get device Id.

- `-RefObjectId` parameter specifies the unique identifier (Object ID) of the user who will be added as a registered user of the device. The $User.ObjectId variable should contain the Object ID of the user. You can use the command `Get-EntraBetaUser` to get user Id.

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

Specifies the ID of the user.

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

[Get-EntraBetaDeviceRegisteredUser](Get-EntraBetaDeviceRegisteredUser.md)

[Remove-EntraBetaDeviceRegisteredUser](Remove-EntraBetaDeviceRegisteredUser.md)
