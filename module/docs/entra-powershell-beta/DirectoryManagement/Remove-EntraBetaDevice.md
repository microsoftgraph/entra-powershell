---
author: msewaweru
description: This article provides details on the Remove-EntraBetaDevice command.
external help file: Microsoft.Entra.Beta.DirectoryManagement-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.Beta.DirectoryManagement
ms.author: eunicewaweru
ms.date: 02/05/2025
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta.DirectoryManagement/Remove-EntraBetaDevice
schema: 2.0.0
title: Remove-EntraBetaDevice
---

# Remove-EntraBetaDevice

## SYNOPSIS

Deletes a device.

## SYNTAX

```powershell
Remove-EntraBetaDevice
 -DeviceId <String>
 [<CommonParameters>]
```

## DESCRIPTION

The `Remove-EntraBetaDevice` cmdlet removes a device from Microsoft Entra ID.

In delegated scenarios with work or school accounts, the signed-in user must have a supported Microsoft Entra role or a custom role with the required permissions. The following least privileged roles are supported:

- Intune Administrator
- Windows 365 Administrator
- Cloud Device Administrator

## EXAMPLES

### Example 1: Remove a device

```powershell
Connect-Entra -Scopes 'Directory.AccessAsUser.All', 'Device.ReadWrite.All'
$device = Get-EntraBetaDevice -Filter "DisplayName eq 'Woodgrove Desktop'"
Remove-EntraBetaDevice -DeviceId $device.Id
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

[Get-EntraBetaDevice](Get-EntraBetaDevice.md)

[New-EntraBetaDevice](New-EntraBetaDevice.md)

[Set-EntraBetaDevice](Set-EntraBetaDevice.md)
