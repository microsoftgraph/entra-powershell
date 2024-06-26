---
title: Get-EntraBetaDevice.
description: This article provides details on the Get-EntraBetaDevice command.

ms.service: entra
ms.topic: reference
ms.date: 06/17/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Get-EntraBetaDevice

## SYNOPSIS

Gets a device from Microsoft Entra ID.

## SYNTAX

### GetQuery (Default)

```powershell
Get-EntraBetaDevice 
 [-Filter <String>] 
 [-All] 
 [-Top <Int32>] 
 [<CommonParameters>]
```

### GetByValue

```powershell
Get-EntraBetaDevice 
 [-SearchString <String>] 
 [-All] 
 [<CommonParameters>]
```

### GetById

```powershell
Get-EntraBetaDevice 
 -ObjectId <String> 
 [-All] 
 [<CommonParameters>]
```

## DESCRIPTION

The `Get-EntraBetaDevice` cmdlet gets a device from Microsoft Entra ID. Specify the `ObjectId` parameter to get a specific device.

## EXAMPLES

### Example 1: Get a device by ID

```powershell
Connect-Entra -Scopes 'Device.Read.All'
Get-EntraBetaDevice -ObjectId 'bbbbbbbb-1111-1111-1111-cccccccccccc'
```

```output
DeletedDateTime Id                                   AccountEnabled ApproximateLastSignInDateTime ComplianceExpirationDateTime DeviceCategory DeviceId                             DeviceMetada
                                                                                                                                                                                   ta
--------------- --                                   -------------- ----------------------------- ---------------------------- -------------- --------                             ------------
                bbbbbbbb-1111-1111-1111-cccccccccccc True                                                                                     dddddddd-9999-0000-1111-eeeeeeeeeeee MetaData
```

This example demonstrates how to retrieve specific device by providing ID. This command gets the specified device.

### Example 2: Get all devices

```powershell
Connect-Entra -Scopes 'Device.Read.All'
Get-EntraBetaDevice
```

```output
DeletedDateTime Id                                   AccountEnabled ApproximateLastSignInDateTime ComplianceExpirationDateTime DeviceCategory DeviceId                             DeviceMetada
                                                                                                                                                                                   ta
--------------- --                                   -------------- ----------------------------- ---------------------------- -------------- --------                             ------------
                aaaaaaaa-1111-1111-1111-bbbbbbbbbbbb True                                                                                     aaaaaaaa-6666-7777-8888-bbbbbbbbbbbb MetaData
                bbbbbbbb-1111-1111-1111-cccccccccccc True                                                                                     aaaaaaaa-6666-7777-8888-bbbbbbbbbbbb MetaData
```

This example demonstrates how to retrieve all devices from Microsoft Entra ID.  
This command gets all available devices.

### Example 3: Get top two devices

```powershell
Connect-Entra -Scopes 'Device.Read.All'
Get-EntraBetaDevice -Top 2
```

```output
DeletedDateTime Id                                   AccountEnabled ApproximateLastSignInDateTime ComplianceExpirationDateTime DeviceCategory DeviceId                             DeviceMetada
                                                                                                                                                                                   ta
--------------- --                                   -------------- ----------------------------- ---------------------------- -------------- --------                             ------------
                aaaaaaaa-1111-1111-1111-bbbbbbbbbbbb True                                                                                     aaaaaaaa-6666-7777-8888-bbbbbbbbbbbb MetaData
                bbbbbbbb-1111-1111-1111-cccccccccccc True                                                                                     aaaaaaaa-6666-7777-8888-bbbbbbbbbbbb MetaData
```

This example demonstrates how to retrieve top two devices from Microsoft Entra ID.  
This command gets the two devices from Microsoft Entra ID.

### Example 4: Get a device by display name

```powershell
Connect-Entra -Scopes 'Device.Read.All'
Get-EntraBetaDevice -Filter "DisplayName eq 'AkshayLodha'"
```

```output
DeletedDateTime Id                                   AccountEnabled ApproximateLastSignInDateTime ComplianceExpirationDateTime DeviceCategory DeviceId                             DeviceMetada
                                                                                                                                                                                   ta
--------------- --                                   -------------- ----------------------------- ---------------------------- -------------- --------                             ------------
                bbbbbbbb-1111-1111-1111-cccccccccccc True                                                                                     dddddddd-9999-0000-1111-eeeeeeeeeeee MetaData
```

This example demonstrates how to retrieve device by display name from Microsoft Entra ID.  
This command gets the specified device.

### Example 5: Get a device filter by display name

```powershell
Connect-Entra -Scopes 'Device.Read.All'
Get-EntraBetaDevice -Filter "startswith(DisplayName,'Aksh')"
```

```output
DeletedDateTime Id                                   AccountEnabled ApproximateLastSignInDateTime ComplianceExpirationDateTime DeviceCategory DeviceId                             DeviceMetada
                                                                                                                                                                                   ta
--------------- --                                   -------------- ----------------------------- ---------------------------- -------------- --------                             ------------
                bbbbbbbb-1111-1111-1111-cccccccccccc True                                                                                     dddddddd-9999-0000-1111-eeeeeeeeeeee MetaData
```

This example demonstrates how to retrieve all the devices whose display name starts with Aksh from Microsoft Entra ID.  

### Example 6: Search among retrieved devices

```powershell
Connect-Entra -Scopes 'Device.Read.All'
Get-EntraBetaDevice -SearchString 'Ashwini'
```

```output
DeletedDateTime Id                                   AccountEnabled ApproximateLastSignInDateTime ComplianceExpirationDateTime DeviceCategory DeviceId                             DeviceMetada
                                                                                                                                                                                   ta
--------------- --                                   -------------- ----------------------------- ---------------------------- -------------- --------                             ------------
                bbbbbbbb-1111-1111-1111-cccccccccccc True                                                                                     dddddddd-9999-0000-1111-eeeeeeeeeeee MetaData
```

This example demonstrates how to retrieve devices by search string from Microsoft Entra ID.  
This command gets all devices that match the value of SearchString against the first characters in DisplayName.

## PARAMETERS

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

Specifies the oData v3.0 filter statement.
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

### -ObjectId

Specifies the ID of a device in Microsoft Entra ID.

```yaml
Type: System.String
Parameter Sets: GetById
Aliases:

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

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[New-EntraBetaDevice](New-EntraBetaDevice.md)

[Remove-EntraBetaDevice](Remove-EntraBetaDevice.md)

[Set-EntraBetaDevice](Set-EntraBetaDevice.md)
