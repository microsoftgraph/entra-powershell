---
title: Get-EntraDevice
description: This article provides details on the Get-EntraDevice command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Get-EntraDevice

schema: 2.0.0
---

# Get-EntraDevice

## Synopsis

Gets a device from Microsoft Entra ID.

## Syntax

### GetQuery (Default)

```powershell
Get-EntraDevice
 [-Top <Int32>]
 [-All]
 [-Filter <String>]
 [-Property <String[]>]
 [<CommonParameters>]
```

### GetByValue

```powershell
Get-EntraDevice
 [-SearchString <String>]
 [-All]
 [-Property <String[]>]
 [<CommonParameters>]
```

### GetById

```powershell
Get-EntraDevice
 -DeviceId <String>
 [-All]
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

The `Get-EntraDevice` cmdlet gets a device from Microsoft Entra ID. Specify the `DeviceId` parameter to get a specific device.

## Examples

### Example 1: Get a device by ID

```powershell
Connect-Entra -Scopes 'Device.Read.All'
Get-EntraDevice -DeviceId 'bbbbbbbb-1111-2222-3333-cccccccccccc'
```

```Output
DeletedDateTime Id                                   AccountEnabled ApproximateLastSignInDateTime ComplianceExpirationDateTime DeviceCategory DeviceId                             DeviceMetadata DeviceOwnership
--------------- --                                   -------------- ----------------------------- ---------------------------- -------------- --------                             -------------- ---------------
                bbbbbbbb-1111-2222-3333-cccccccccccc True                                                                                     eeeeeeee-4444-5555-6666-ffffffffffff MetaData
```

This example shows how to retrieve a device using its ID.

### Example 2: Get all devices

```powershell
Connect-Entra -Scopes 'Device.Read.All'
Get-EntraDevice
```

```Output
DeletedDateTime Id                                   AccountEnabled ApproximateLastSignInDateTime ComplianceExpirationDateTime DeviceCategory DeviceId                             DeviceMetadata DeviceOwnership
--------------- --                                   -------------- ----------------------------- ---------------------------- -------------- --------                             -------------- ---------------
                bbbbbbbb-1111-2222-3333-cccccccccccc True                                                                                     eeeeeeee-4444-5555-6666-ffffffffffff MetaData
                cccccccc-2222-3333-4444-dddddddddddd True                                                                                     eeeeeeee-4444-5555-6666-ffffffffffff MetaData
```

This example demonstrates how to retrieve all devices from Microsoft Entra ID.

### Example 3: Get top two devices

```powershell
Connect-Entra -Scopes 'Device.Read.All'
Get-EntraDevice -Top 2
```

```Output
DeletedDateTime Id                                   AccountEnabled ApproximateLastSignInDateTime ComplianceExpirationDateTime DeviceCategory DeviceId                             DeviceMetadata DeviceOwnership
--------------- --                                   -------------- ----------------------------- ---------------------------- -------------- --------                             -------------- ---------------
                bbbbbbbb-1111-2222-3333-cccccccccccc True                                                                                     eeeeeeee-4444-5555-6666-ffffffffffff MetaData
                cccccccc-2222-3333-4444-dddddddddddd True                                                                                     eeeeeeee-4444-5555-6666-ffffffffffff MetaData
```

This example demonstrates how to retrieve top two devices from Microsoft Entra ID.

### Example 4: Get a device by display name

```powershell
Connect-Entra -Scopes 'Device.Read.All'
Get-EntraDevice -Filter "DisplayName eq 'Woodgrove Desktop'"
```

```Output
DeletedDateTime Id                                   AccountEnabled ApproximateLastSignInDateTime ComplianceExpirationDateTime DeviceCategory DeviceId                             DeviceMetadata DeviceOwnership
--------------- --                                   -------------- ----------------------------- ---------------------------- -------------- --------                             -------------- ---------------
                bbbbbbbb-1111-2222-3333-cccccccccccc True                                                                                     eeeeeeee-4444-5555-6666-ffffffffffff MetaData
```

This example demonstrates how to retrieve device using the display name.

### Example 5: Get a device using display name

```powershell
Connect-Entra -Scopes 'Device.Read.All'
Get-EntraDevice -Filter "startsWith(DisplayName,'Woodgrove')"
```

```Output
DeletedDateTime Id                                   AccountEnabled ApproximateLastSignInDateTime ComplianceExpirationDateTime DeviceCategory DeviceId                             DeviceMetadata DeviceOwnership
--------------- --                                   -------------- ----------------------------- ---------------------------- -------------- --------                             -------------- ---------------
                bbbbbbbb-1111-2222-3333-cccccccccccc True                                                                                     eeeeeeee-4444-5555-6666-ffffffffffff MetaData
```

This example demonstrates how to retrieve all the devices whose display name starts with the word `Woodgrove`.

### Example 6: Search among retrieved devices

```powershell
Connect-Entra -Scopes 'Device.Read.All'
Get-EntraDevice -SearchString 'DESKTOP'
```

```Output
DeletedDateTime Id                                   AccountEnabled ApproximateLastSignInDateTime ComplianceExpirationDateTime DeviceCategory DeviceId                             DeviceMetadata DeviceOwnership
--------------- --                                   -------------- ----------------------------- ---------------------------- -------------- --------                             -------------- ---------------
                bbbbbbbb-1111-2222-3333-cccccccccccc True                                                                                     eeeeeeee-4444-5555-6666-ffffffffffff MetaData
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

[New-EntraDevice](New-EntraDevice.md)

[Remove-EntraDevice](Remove-EntraDevice.md)

[Set-EntraDevice](Set-EntraDevice.md)
