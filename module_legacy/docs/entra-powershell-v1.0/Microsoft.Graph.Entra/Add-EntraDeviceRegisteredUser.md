---
title: Add-EntraDeviceRegisteredUser
description: This article provides details on the Add-EntraDeviceRegisteredUser command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Add-EntraDeviceRegisteredUser

schema: 2.0.0
---

# Add-EntraDeviceRegisteredUser

## Synopsis

Adds a registered user for a device.

## Syntax

```powershell
Add-EntraDeviceRegisteredUser
 -DeviceId <String>
 -RefObjectId <String>
 [<CommonParameters>]
```

## Description

The `Add-EntraDeviceRegisteredUser` cmdlet adds a registered user for a Microsoft Entra ID device.

## Examples

### Example 1: Add a user as a registered user

```powershell
Connect-Entra -Scopes 'Device.ReadWrite.All'
$User = Get-EntraUser -UserId 'SawyerM@contoso.com'
$Device = Get-EntraDevice -SearchString '<device-display-name>'
$params = @{
    DeviceId = $Device.ObjectId 
    RefObjectId = $User.ObjectId
}
Add-EntraDeviceRegisteredUser @params
```

This example shows how to add a registered user to a device.

- `-DeviceId` parameter specifies the unique identifier (Object ID) of the device to which you want to add a registered user. The $Device.ObjectId variable should contain the Object ID of the device. You can use the command `Get-EntraDevice` to get device Id.

- `-RefObjectId` parameter specifies the unique identifier (Object ID) of the user who will be added as a registered user of the device. The $User.ObjectId variable should contain the Object ID of the user. You can use the command `Get-EntraUser` to get user Id.

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

## Related links

[Get-EntraDevice](Get-EntraDevice.md)

[Get-EntraDeviceRegisteredUser](Get-EntraDeviceRegisteredUser.md)

[Get-EntraUser](Get-EntraUser.md)

[Remove-EntraDeviceRegisteredUser](Remove-EntraDeviceRegisteredUser.md)
