---
title: Get-EntraDeviceRegisteredOwner
description: This article provides details on the Get-EntraDeviceRegisteredOwner command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: mwongerapk
author: msewaweru

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Get-EntraDeviceRegisteredOwner

schema: 2.0.0
---

# Get-EntraDeviceRegisteredOwner

## Synopsis

Gets the registered owner of a device.

## Syntax

```powershell
Get-EntraDeviceRegisteredOwner
 -DeviceId <String>
 [-All]
 [-Top <Int32>]
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

The `Get-EntraDeviceRegisteredOwner` cmdlet gets the registered owner of a device in Microsoft Entra ID. Specify `DeviceId` parameter gets the registered owner of a device.

## Examples

### Example 1: Retrieve the registered owner of a device

```powershell
Connect-Entra -Scopes 'Device.Read.All'
$DevId = (Get-EntraDevice -Top 1).ObjectId
Get-EntraDeviceRegisteredOwner -DeviceId $DevId
```

```Output
Id                                   DeletedDateTime
--                                   ---------------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb
```

This example shows how to find the registered owner of a device..

- `-DeviceId` parameter specifies the device's ID.

### Example 2: Retrieve the registered owner of a device

```powershell
Connect-Entra -Scopes 'Device.Read.All'
Get-EntraDeviceRegisteredOwner -DeviceId 'bbbbbbbb-1111-2222-3333-cccccccccccc'
```

```Output
Id                                   DeletedDateTime
--                                   ---------------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb
cccccccc-2222-3333-4444-dddddddddddd
```

This command gets the registered owner of a device.

- `-DeviceId` parameter specifies the device's ID

### Example 3: Retrieve all the registered owners of a device

```powershell
Connect-Entra -Scopes 'Device.Read.All'
Get-EntraDeviceRegisteredOwner -DeviceId 'bbbbbbbb-1111-2222-3333-cccccccccccc' -All 
```

```Output
Id                                   DeletedDateTime
--                                   ---------------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb
cccccccc-2222-3333-4444-dddddddddddd
```

This command retrieves all the registered owners of a device.

- `-DeviceId` parameter specifies the device's ID.

### Example 4: Retrieve top one registered owner of a device

```powershell
Connect-Entra -Scopes 'Device.Read.All'
Get-EntraDeviceRegisteredOwner -DeviceId 'bbbbbbbb-1111-2222-3333-cccccccccccc' -Top 1
```

```Output
Id                                   DeletedDateTime
--                                   ---------------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb
```

This command retrieves all the registered owners of a device.

- `-DeviceId` parameter specifies the device's ID.

## Parameters

### -All

List all pages.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

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

### -Top

Specifies the maximum number of records to return.

```yaml
Type: System.Int32  
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Property

Specifies properties to be returned.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
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

[Remove-EntraDeviceRegisteredOwner](Remove-EntraDeviceRegisteredOwner.md)
