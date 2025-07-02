---
author: msewaweru
description: This article provides details on the Add-EntraBetaDeviceRegisteredOwner command.
external help file: Microsoft.Entra.Beta.DirectoryManagement-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 02/05/2025
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Add-EntraBetaDeviceRegisteredOwner
schema: 2.0.0
title: Add-EntraBetaDeviceRegisteredOwner
---

# Add-EntraBetaDeviceRegisteredOwner

## Synopsis

Adds a registered owner for a device.

## Syntax

```powershell
Add-EntraBetaDeviceRegisteredOwner
 -DeviceId <String>
 -OwnerId <String>
 [<CommonParameters>]
```

## Description

The `Add-EntraBetaDeviceRegisteredOwner` cmdlet adds a registered owner for a Microsoft Entra ID device.

In delegated scenarios involving work or school accounts, the signed-in user must have a supported Microsoft Entra role or a custom role with the required permissions. The following least privileged roles are supported for this operation:

- Intune Administrator
- Windows 365 Administrator

## Examples

### Example 1: Add a user as a registered owner

```powershell
Connect-Entra -Scopes 'Directory.AccessAsUser.All'
$user = Get-EntraBetaUser -UserId 'SawyerM@contoso.com'
$device = Get-EntraBetaDevice -SearchString '<device-display-name>'
Add-EntraBetaDeviceRegisteredOwner -DeviceId $device.Id -OwnerId $user.Id
```

This example shows how to add a registered owner to a device.

`-DeviceId` parameter specifies the unique identifier (Object ID) of the device to which you want to add a registered owner. You can use the command `Get-EntraBetaDevice` to get device Id.
`-OwnerId` parameter specifies the unique identifier (Object ID) of the user who will be added as a registered owner of the device. You can use the command `Get-EntraBetaUser` to get user Id.

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

### -OwnerId

Specifies the ID of the Microsoft Entra ID object to add.

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

[Get-EntraBetaDeviceRegisteredOwner](Get-EntraBetaDeviceRegisteredOwner.md)

[Remove-EntraBetaDeviceRegisteredOwner](Remove-EntraBetaDeviceRegisteredOwner.md)
