---
title: Remove-EntraDeviceRegisteredOwner
description: This article provides details on the Remove-EntraDeviceRegisteredOwner command.

ms.service: entra
ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Remove-EntraDeviceRegisteredOwner

## Synopsis

removes the registered owner of a device.

## Syntax

```powershell
Remove-EntraDeviceRegisteredOwner 
 -OwnerId <String> 
 -ObjectId <String> 
 [<CommonParameters>]
```

## Description

the `Remove-EntraDeviceRegisteredOwner` cmdlet removes the registered owner of a device in Microsoft Entra ID.

## Examples

### Example 1: Remove an owner from a device

```powershell
Connect-Entra -Scopes 'Directory.AccessAsUser.All'
$Device = Get-EntraDevice -Top 1
$Owner = Get-EntraDeviceRegisteredOwner -ObjectId $Device.ObjectId
Remove-EntraDeviceRegisteredOwner -ObjectId $Device.ObjectId -OwnerId $Owner.ObjectId
```

This examples shows how to remove the owner of a device.

- The first command gets a device by using the [Get-EntraDevice](./Get-EntraDevice.md) cmdlet, and then stores it in the `$Device` variable.  

- The second command retrieves the registered owner of the device in `$Device` by using the [Get-EntraDeviceRegisteredOwner](./Get-EntraDeviceRegisteredOwner.md) cmdlet.  

- The command stores the details in the `$Owner` variable.  

- The final command removes the owner in `$Owner` from the device in `$Device`.

## Parameters

### -ObjectId

Specifies an object ID.

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

## Related Links

[Add-EntraDeviceRegisteredOwner](Add-EntraDeviceRegisteredOwner.md)

[Get-EntraDevice](Get-EntraDevice.md)

[Get-EntraDeviceRegisteredOwner](Get-EntraDeviceRegisteredOwner.md)
