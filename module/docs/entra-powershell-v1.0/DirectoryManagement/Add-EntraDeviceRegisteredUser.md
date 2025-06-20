---
author: msewaweru
description: This article provides details on the Add-EntraDeviceRegisteredUser command.
external help file: Microsoft.Entra.DirectoryManagement-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra
ms.author: eunicewaweru
ms.date: 02/05/2025
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Add-EntraDeviceRegisteredUser
schema: 2.0.0
title: Add-EntraDeviceRegisteredUser
---

# Add-EntraDeviceRegisteredUser

## Synopsis

Adds a registered user for a device.

## Syntax

```powershell
Add-EntraDeviceRegisteredUser
 -DeviceId <String>
 -UserId <String>
 [<CommonParameters>]
```

## Description

The `Add-EntraDeviceRegisteredUser` cmdlet adds a registered user for a Microsoft Entra ID device.

In delegated scenarios involving work or school accounts, the signed-in user must have a supported Microsoft Entra role or a custom role with the required permissions. The following least privileged roles are supported for this operation:

- Intune Administrator
- Windows 365 Administrator

## Examples

### Example 1: Add a user as a registered user

```powershell
Connect-Entra -Scopes 'Device.ReadWrite.All'
$user = Get-EntraUser -UserId 'SawyerM@contoso.com'
$device = Get-EntraDevice -SearchString '<device-display-name>'
Add-EntraDeviceRegisteredUser -DeviceId $device.Id -UserId $user.Id
```

This example shows how to add a registered user to a device.

- `-DeviceId` parameter specifies the unique identifier (Object ID) of the device to which you want to add a registered user. You can use the command `Get-EntraDevice` to get device Id.
- `-UserId` parameter specifies the unique identifier (Object ID) of the user who will be added as a registered user of the device. You can use the command `Get-EntraUser` to get user Id.

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

### -UserId

Specifies the ID of the user.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: RefObjectId

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

[Get-EntraUser](../Users/Get-EntraUser.md)

[Remove-EntraDeviceRegisteredUser](Remove-EntraDeviceRegisteredUser.md)
