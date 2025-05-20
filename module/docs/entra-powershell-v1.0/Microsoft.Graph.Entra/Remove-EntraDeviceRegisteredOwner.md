---
title: Remove-EntraDeviceRegisteredOwner
description: This article provides details on the Remove-EntraDeviceRegisteredOwner command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Remove-EntraDeviceRegisteredOwner

schema: 2.0.0
---

# Remove-EntraDeviceRegisteredOwner

## Synopsis

Removes the registered owner of a device.

## Syntax

```powershell
Remove-EntraDeviceRegisteredOwner
 -OwnerId <String>
 -DeviceId <String>
 [<CommonParameters>]
```

## Description

The `Remove-EntraDeviceRegisteredOwner` cmdlet removes the registered owner of a device in Microsoft Entra ID.

In delegated scenarios involving work or school accounts, the signed-in user must have a supported Microsoft Entra role or a custom role with the required permissions. The following least privileged roles are supported for this operation:

- Intune Administrator  
- Windows 365 Administrator

## Examples

### Example 1: Remove an owner from a device

```powershell
Connect-Entra -Scopes 'Directory.AccessAsUser.All'
$device = Get-EntraDevice -Filter "DisplayName eq 'Woodgrove Desktop'"
$owner = Get-EntraDeviceRegisteredOwner -DeviceId $device.ObjectId
Remove-EntraDeviceRegisteredOwner -DeviceId $device.ObjectId -OwnerId $owner.Id
```

This examples shows how to remove the owner of a device.

## Parameters

### -DeviceId

Specifies an object ID.

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

Specifies an owner ID.

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

[Add-EntraDeviceRegisteredOwner](Add-EntraDeviceRegisteredOwner.md)

[Get-EntraDevice](Get-EntraDevice.md)

[Get-EntraDeviceRegisteredOwner](Get-EntraDeviceRegisteredOwner.md)
