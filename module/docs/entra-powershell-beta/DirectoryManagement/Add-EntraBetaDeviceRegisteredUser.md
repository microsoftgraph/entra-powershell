---
author: msewaweru
description: This article provides details on the Add-EntraBetaDeviceRegisteredUser command.
external help file: Microsoft.Entra.Beta.DirectoryManagement-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.Beta.DirectoryManagement
ms.author: eunicewaweru
ms.date: 02/05/2025
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta.DirectoryManagement/Add-EntraBetaDeviceRegisteredUser
schema: 2.0.0
title: Add-EntraBetaDeviceRegisteredUser
---

# Add-EntraBetaDeviceRegisteredUser

## SYNOPSIS

Adds a registered user for a device.

## SYNTAX

```powershell
Add-EntraBetaDeviceRegisteredUser
 -DeviceId <String>
 -UserId <String>
 [<CommonParameters>]
```

## DESCRIPTION

The `Add-EntraBetaDeviceRegisteredUser` cmdlet adds a registered user for a Microsoft Entra ID device.

In delegated scenarios involving work or school accounts, the signed-in user must have a supported Microsoft Entra role or a custom role with the required permissions. The following least privileged roles are supported for this operation:

- Intune Administrator
- Windows 365 Administrator

## EXAMPLES

### Example 1: Add a user as a registered user

```powershell
Connect-Entra -Scopes 'Device.ReadWrite.All'
$user = Get-EntraBetaUser -UserId 'SawyerM@contoso.com'
$device = Get-EntraBetaDevice -SearchString '<device-display-name>'
Add-EntraBetaDeviceRegisteredUser -DeviceId $device.Id -UserId $user.Id
```

This example shows how to add a registered user to a device.

- `-DeviceId` parameter specifies the unique identifier (Object ID) of the device to which you want to add a registered user. You can use the command `Get-EntraBetaDevice` to get device Id.
- `-UserId` parameter specifies the unique identifier (Object ID) of the user who will be added as a registered user of the device. You can use the command `Get-EntraBetaUser` to get user Id.

## PARAMETERS

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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraBetaDeviceRegisteredUser](Get-EntraBetaDeviceRegisteredUser.md)

[Remove-EntraBetaDeviceRegisteredUser](Remove-EntraBetaDeviceRegisteredUser.md)
