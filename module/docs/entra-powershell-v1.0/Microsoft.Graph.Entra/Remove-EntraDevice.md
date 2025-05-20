---
title: Remove-EntraDevice
description: This article provides details on the Remove-EntraDevice command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Remove-EntraDevice

schema: 2.0.0
---

# Remove-EntraDevice

## Synopsis

Deletes a device.

## Syntax

```powershell
Remove-EntraDevice
 -DeviceId <String>
 [<CommonParameters>]
```

## Description

The `Remove-EntraDevice` cmdlet removes a device from Microsoft Entra ID.

In delegated scenarios with work or school accounts, the signed-in user must have a supported Microsoft Entra role or a custom role with the required permissions. The following least privileged roles are supported:

- Intune Administrator  
- Windows 365 Administrator  
- Cloud Device Administrator

## Examples

### Example 1: Remove a device

```powershell
Connect-Entra -Scopes 'Directory.AccessAsUser.All','Device.ReadWrite.All'
$device = Get-EntraDevice -Filter "DisplayName eq 'Woodgrove Desktop'"
Remove-EntraDevice -DeviceId $device.ObjectId
```

This command removes the specified device.

## Parameters

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

## Inputs

## Outputs

## Notes

## Related links

[Get-EntraDevice](Get-EntraDevice.md)

[New-EntraDevice](New-EntraDevice.md)

[Set-EntraDevice](Set-EntraDevice.md)
