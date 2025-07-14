---
description: This article provides details on the Remove-EntraDevice command.
external help file: Microsoft.Entra.DirectoryManagement-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra
ms.author: eunicewaweru
ms.date: 02/05/2025
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Remove-EntraDevice
schema: 2.0.0
title: Remove-EntraDevice
---

# Remove-EntraDevice

## SYNOPSIS

Deletes a device.

## SYNTAX

```powershell
Remove-EntraDevice
 -DeviceId <String>
 [<CommonParameters>]
```

## DESCRIPTION

The `Remove-EntraDevice` cmdlet removes a device from Microsoft Entra ID.

In delegated scenarios with work or school accounts, the signed-in user must have a supported Microsoft Entra role or a custom role with the required permissions. The following least privileged roles are supported:

- Intune Administrator
- Windows 365 Administrator
- Cloud Device Administrator

## EXAMPLES

### Example 1: Remove a device

```powershell
Connect-Entra -Scopes 'Directory.AccessAsUser.All', 'Device.ReadWrite.All'
$device = Get-EntraDevice -Filter "DisplayName eq 'Woodgrove Desktop'"
Remove-EntraDevice -DeviceId $device.Id
```

This command removes the specified device.

## PARAMETERS

### -DeviceId

Specifies the object ID of a device in Microsoft Entra ID.

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

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraDevice](Get-EntraDevice.md)

[New-EntraDevice](New-EntraDevice.md)

[Set-EntraDevice](Set-EntraDevice.md)
