---
title: Get-EntraBetaDevice
description: This article provides details on the Get-EntraBetaDevice command.


ms.topic: reference
ms.date: 06/17/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: mwongerapk
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Get-EntraBetaDevice

schema: 2.0.0
---

# Get-EntraBetaDevice

## Synopsis

Gets a device from Microsoft Entra ID.

## Syntax

### GetQuery (Default)

```powershell
Get-EntraBetaDevice
 [-Filter <String>]
 [-All]
 [-Top <Int32>]
 [-Property <String[]>]
 [<CommonParameters>]
```

### GetByValue

```powershell
Get-EntraBetaDevice
 [-SearchString <String>]
 [-All]
 [-Property <String[]>]
 [<CommonParameters>]
```

### GetById

```powershell
Get-EntraBetaDevice
 -DeviceId <String>
 [-All]
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

The `Get-EntraBetaDevice` cmdlet gets a device from Microsoft Entra ID. Specify the `DeviceId` parameter to get a specific device.

## Examples

### Example 1: Get a device by ID

```powershell
Connect-Entra -Scopes 'Device.Read.All'
Get-EntraBetaDevice -DeviceId 'bbbbbbbb-1111-1111-1111-cccccccccccc'
```

```Output
DeletedDateTime Id                                   AccountEnabled ApproximateLastSignInDateTime ComplianceExpirationDateTime DeviceCategory DeviceId                             DeviceMetada
                                                                                                                                                                                   ta
--------------- --                                   -------------- ----------------------------- ---------------------------- -------------- --------                             ------------
                bbbbbbbb-1111-1111-1111-cccccccccccc True                                                                                     dddddddd-9999-0000-1111-eeeeeeeeeeee MetaData
```

This example shows how to retrieve a device using its ID.

### Example 2: Get all devices

```powershell
Connect-Entra -Scopes 'Device.Read.All'
Get-EntraBetaDevice
```

```Output
DeletedDateTime Id                                   AccountEnabled ApproximateLastSignInDateTime ComplianceExpirationDateTime DeviceCategory DeviceId                             DeviceMetada
                                                                                                                                                                                   ta
--------------- --                                   -------------- ----------------------------- ---------------------------- -------------- --------                             ------------
                aaaaaaaa-1111-1111-1111-bbbbbbbbbbbb True                                                                                     aaaaaaaa-6666-7777-8888-bbbbbbbbbbbb MetaData
                bbbbbbbb-1111-1111-1111-cccccccccccc True                                                                                     aaaaaaaa-6666-7777-8888-bbbbbbbbbbbb MetaData
```

This example demonstrates how to retrieve all devices from Microsoft Entra ID.

### Example 3: Get top two devices

```powershell
Connect-Entra -Scopes 'Device.Read.All'
Get-EntraBetaDevice -Top 2
```

```Output
DeletedDateTime Id                                   AccountEnabled ApproximateLastSignInDateTime ComplianceExpirationDateTime DeviceCategory DeviceId                             DeviceMetada
                                                                                                                                                                                   ta
--------------- --                                   -------------- ----------------------------- ---------------------------- -------------- --------                             ------------
                aaaaaaaa-1111-1111-1111-bbbbbbbbbbbb True                                                                                     aaaaaaaa-6666-7777-8888-bbbbbbbbbbbb MetaData
                bbbbbbbb-1111-1111-1111-cccccccccccc True                                                                                     aaaaaaaa-6666-7777-8888-bbbbbbbbbbbb MetaData
```

This example demonstrates how to retrieve top two devices from Microsoft Entra ID.

### Example 4: Get a device by display name

```powershell
Connect-Entra -Scopes 'Device.Read.All'
Get-EntraBetaDevice -Filter "DisplayName eq 'Woodgrove Desktop'"
```

```Output
DeletedDateTime Id                                   AccountEnabled ApproximateLastSignInDateTime ComplianceExpirationDateTime DeviceCategory DeviceId                             DeviceMetada
                                                                                                                                                                                   ta
--------------- --                                   -------------- ----------------------------- ---------------------------- -------------- --------                             ------------
                bbbbbbbb-1111-1111-1111-cccccccccccc True                                                                                     dddddddd-9999-0000-1111-eeeeeeeeeeee MetaData
```

This example demonstrates how to retrieve device using the display name.

### Example 5: Get a device using display name

```powershell
Connect-Entra -Scopes 'Device.Read.All'
Get-EntraBetaDevice -Filter "startsWith(DisplayName,'Woodgrove')"
```

```Output
DeletedDateTime Id                                   AccountEnabled ApproximateLastSignInDateTime ComplianceExpirationDateTime DeviceCategory DeviceId                             DeviceMetada
                                                                                                                                                                                   ta
--------------- --                                   -------------- ----------------------------- ---------------------------- -------------- --------                             ------------
                bbbbbbbb-1111-1111-1111-cccccccccccc True                                                                                     dddddddd-9999-0000-1111-eeeeeeeeeeee MetaData
```

This example demonstrates how to retrieve all the devices whose display name starts with the word `Woodgrove`.

### Example 6: Search among retrieved devices

```powershell
Connect-Entra -Scopes 'Device.Read.All'
Get-EntraBetaDevice -SearchString 'DESKTOP'
```

```Output
DeletedDateTime Id                                   AccountEnabled ApproximateLastSignInDateTime ComplianceExpirationDateTime DeviceCategory DeviceId                             DeviceMetada
                                                                                                                                                                                   ta
--------------- --                                   -------------- ----------------------------- ---------------------------- -------------- --------                             ------------
                bbbbbbbb-1111-1111-1111-cccccccccccc True                                                                                     dddddddd-9999-0000-1111-eeeeeeeeeeee MetaData
```

This example shows how to retrieve devices containing the word 'DESKTOP.'

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

### -Filter

Specifies the OData v4.0 filter statement.
This parameter controls which objects are returned.

```yaml
Type: System.String
Parameter Sets: GetQuery
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -DeviceId

Specifies the ID of a device in Microsoft Entra ID.

```yaml
Type: System.String
Parameter Sets: GetById
Aliases: ObjectId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -SearchString

Specifies a search string.

```yaml
Type: System.String
Parameter Sets: GetValue
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Top

Specifies the maximum number of records to return.

```yaml
Type: System.Int32
Parameter Sets: GetQuery
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Property

Specifies properties to be returned

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

[New-EntraBetaDevice](New-EntraBetaDevice.md)

[Remove-EntraBetaDevice](Remove-EntraBetaDevice.md)

[Set-EntraBetaDevice](Set-EntraBetaDevice.md)
