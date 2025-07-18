---
title: Get-EntraDeviceRegisteredUser
description: This article provides details on the Get-EntraDeviceRegisteredUser command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: mwongerapk
author: msewaweru

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Get-EntraDeviceRegisteredUser

schema: 2.0.0
---

# Get-EntraDeviceRegisteredUser

## Synopsis

Retrieve a list of users that are registered users of the device.

## Syntax

```powershell
Get-EntraDeviceRegisteredUser
 -DeviceId <String>
 [-All <Boolean>]
 [-Top <Int32 >]
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

The `Get-EntraDeviceRegisteredUser` cmdlet gets a registered user for a Microsoft Entra ID device. Specify `DeviceId` parameter to get a registered user for a Microsoft Entra ID device.

## Examples

### Example 1: Retrieve the registered user of a device

```powershell
Connect-Entra -Scopes 'Device.Read.All'
$DevId = (Get-EntraDevice -Top 1).ObjectId
Get-EntraDeviceRegisteredUser -DeviceId $DevId
```

```Output
Id                                   DeletedDateTime
--                                   ---------------
bbbbbbbb-1111-2222-3333-cccccccccccc
cccccccc-2222-3333-4444-dddddddddddd
dddddddd-3333-4444-5555-eeeeeeeeeeee
ffffffff-4444-5555-6666-gggggggggggg
```

This example demonstrates how to retrieve registered user for a specific Microsoft Entra ID device.

### Example 2: Get all registered users of a device

```powershell
Connect-Entra -Scopes 'Device.Read.All'
Get-EntraDeviceRegisteredUser -DeviceId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb' -All 
```

```Output
Id                                   DeletedDateTime
--                                   ---------------
bbbbbbbb-1111-2222-3333-cccccccccccc
cccccccc-2222-3333-4444-dddddddddddd
dddddddd-3333-4444-5555-eeeeeeeeeeee
ffffffff-4444-5555-6666-gggggggggggg
```

This example demonstrates how to retrieve all registered users for a specified device.

- `-DeviceId` parameter specifies an object ID of a device, which you want to retrieve.

### Example 3: Get top two registered users of a device

```powershell
Connect-Entra -Scopes 'Device.Read.All'
Get-EntraDeviceRegisteredUser -DeviceId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb' -Top 2
```

```Output
Id                                   DeletedDateTime
--                                   ---------------
bbbbbbbb-1111-2222-3333-cccccccccccc
cccccccc-2222-3333-4444-dddddddddddd
```

This example demonstrates how to retrieve top two registered users for the specified device.

- `-DeviceId` parameter specifies an object ID of a device, which you want to retrieve.

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

Specifies an object ID of a device.

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

[Add-EntraDeviceRegisteredUser](Add-EntraDeviceRegisteredUser.md)

[Remove-EntraDeviceRegisteredUser](Remove-EntraDeviceRegisteredUser.md)
