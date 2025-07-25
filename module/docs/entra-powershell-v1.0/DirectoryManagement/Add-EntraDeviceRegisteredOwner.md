---
description: This article provides details on the Add-EntraDeviceRegisteredOwner command.
external help file: Microsoft.Entra.DirectoryManagement-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra
ms.author: eunicewaweru
ms.date: 02/05/2025
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Add-EntraDeviceRegisteredOwner
schema: 2.0.0
title: Add-EntraDeviceRegisteredOwner
---

# Add-EntraDeviceRegisteredOwner

## SYNOPSIS

Adds a registered owner for a device.

## SYNTAX

```powershell
Add-EntraDeviceRegisteredOwner
 -DeviceId <String>
 -OwnerId <String>
 [<CommonParameters>]
```

## DESCRIPTION

The `Add-EntraDeviceRegisteredOwner` cmdlet adds a registered owner for a Microsoft Entra ID device.

In delegated scenarios involving work or school accounts, the signed-in user must have a supported Microsoft Entra role or a custom role with the required permissions. The following least privileged roles are supported for this operation:

- Intune Administrator
- Windows 365 Administrator

## EXAMPLES

### Example 1: Add a user as a registered owner

```powershell
Connect-Entra -Scopes 'Directory.AccessAsUser.All'
$user = Get-EntraUser -UserId 'SawyerM@contoso.com'
$device = Get-EntraDevice -SearchString '<device-display-name>'
Add-EntraDeviceRegisteredOwner -DeviceId $device.Id -OwnerId $user.Id
```

This example shows how to add a registered user to a device.

- `-DeviceId` parameter specifies the unique identifier (Object ID) of the device to which you want to add a registered user. You can use the command `Get-EntraDevice` to get device Id.
- `-OwnerId` parameter specifies the unique identifier (Object ID) of the user who will be added as a registered user of the device. You can use the command `Get-EntraUser` to get user Id.

## PARAMETERS

### -DeviceId

Specifies the object ID.

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

Specifies the ID of the Active Directory object to add.

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

[Get-EntraDeviceRegisteredOwner](Get-EntraDeviceRegisteredOwner.md)

[Remove-EntraDeviceRegisteredOwner](Remove-EntraDeviceRegisteredOwner.md)
