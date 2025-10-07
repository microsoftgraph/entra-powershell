---
author: msewaweru
description: This article provides details on the Remove-EntraDeviceRegisteredUser command.
external help file: Microsoft.Entra.DirectoryManagement-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.DirectoryManagement
ms.author: eunicewaweru
ms.date: 02/05/2025
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.DirectoryManagement/Remove-EntraDeviceRegisteredUser
schema: 2.0.0
title: Remove-EntraDeviceRegisteredUser
---

# Remove-EntraDeviceRegisteredUser

## SYNOPSIS

Removes a registered user from a device.

## SYNTAX

```powershell
Remove-EntraDeviceRegisteredUser
 -DeviceId <String>
 -UserId <String>
 [<CommonParameters>]
```

## DESCRIPTION

The `Remove-EntraDeviceRegisteredUser` cmdlet removes a registered user from a Microsoft Entra ID device.

In delegated scenarios involving work or school accounts, the signed-in user must have a supported Microsoft Entra role or a custom role with the required permissions. The following least privileged roles are supported for this operation:

- Intune Administrator
- Windows 365 Administrator

## EXAMPLES

### Example 1: Remove a registered user from a device

```Powershell
Connect-Entra -Scopes 'Directory.AccessAsUser.All'
$device = Get-EntraDevice -Filter "DisplayName eq 'Woodgrove Desktop'"
$user = Get-EntraDeviceRegisteredUser -DeviceId $device.Id | Where-Object {$_.userPrincipalName -eq 'parker@contoso.com'}
Remove-EntraDeviceRegisteredUser -DeviceId $device.Id -UserId $user.Id
```

This example shows how to remove the registered user from device.

## PARAMETERS

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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Add-EntraDeviceRegisteredUser](Add-EntraDeviceRegisteredUser.md)

[Get-EntraDeviceRegisteredUser](Get-EntraDeviceRegisteredUser.md)
