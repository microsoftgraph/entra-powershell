---
title: Add-EntraDeviceRegisteredUser
description: This article provides details on the Add-EntraDeviceRegisteredUser command.

ms.service: entra
ms.topic: reference
ms.date: 02/28/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Add-EntraDeviceRegisteredUser

## Synopsis
Adds a registered user for a device.

## Syntax

```powershell
Add-EntraDeviceRegisteredUser 
 -ObjectId <String> 
 -RefObjectId <String> 
 [<CommonParameters>]
```

## Description
The **Add-EntraDeviceRegisteredUser** cmdlet adds a registered user for a Microsoft Entra ID device.

## Examples

### Example 1: Add a user as a registered user

```powershell
Connect-Entra -Scopes 'Device.ReadWrite.All'
$User = Get-EntraUser -Top 1
$Device = Get-EntraDevice -Top 1
Add-EntraDeviceRegisteredUser -ObjectId $Device.ObjectId -RefObjectId $User.ObjectId
```

This example shows how to add a registered user to a device.

- `-ObjectId` - specifies the unique identifier (Object ID) of the device to which you want to add a registered user. The $Device.ObjectId variable should contain the Object ID of the device.

- `-RefObjectId` - specifies the unique identifier (Object ID) of the user who will be added as a registered user of the device. The $User.ObjectId variable should contain the Object ID of the user.

## Parameters

### -ObjectId

Specifies the ID of the device.

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

## Related LINKS

[Get-EntraDevice](Get-EntraDevice.md)

[Get-EntraDeviceRegisteredUser](Get-EntraDeviceRegisteredUser.md)

[Get-EntraUser](Get-EntraUser.md)

[Remove-EntraDeviceRegisteredUser](Remove-EntraDeviceRegisteredUser.md)
