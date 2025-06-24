---
author: msewaweru
description: This article provides details on the Get-EntraBetaDeviceRegisteredOwner command.
external help file: Microsoft.Entra.Beta.DirectoryManagement-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 02/05/2025
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Get-EntraBetaDeviceRegisteredOwner
schema: 2.0.0
title: Get-EntraBetaDeviceRegisteredOwner
---

# Get-EntraBetaDeviceRegisteredOwner

## Synopsis

Gets the registered owner of a device.

## Syntax

```powershell
Get-EntraBetaDeviceRegisteredOwner
 -DeviceId <String>
 [-All]
 [-Top <Int32>]
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

The `Get-EntraBetaDeviceRegisteredOwner` cmdlet gets the registered owner of a device in Microsoft Entra ID. Specify `DeviceId` parameter gets the registered owner of a device.

In delegated scenarios with work or school accounts, the signed-in user must have a supported Microsoft Entra role or a custom role with the necessary permissions. The following least privileged roles are supported:

- Directory Readers
- Global Reader
- Intune Administrator
- Windows 365 Administrator

## Examples

### Example 1: Retrieve the registered owner of a device

```powershell
Connect-Entra -Scopes 'Device.Read.All'
$device = Get-EntraBetaDevice -SearchString '<device-display-name>'
Get-EntraBetaDeviceRegisteredOwner -DeviceId $device.Id |
Select-Object Id, displayName, UserPrincipalName, createdDateTime, userType, accountEnabled |
Format-Table -AutoSize
```

```Output
id                                   DisplayName      UserPrincipalName         CreatedDateTime       UserType AccountEnabled
--                                   -----------      -----------------         ---------------       -------- --------------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb Maria Sullivan  maria@contoso.com         10/7/2024 12:34:14 AM Member   True
cccccccc-2222-3333-4444-dddddddddddd Parker McLean   parker@contoso.com        10/7/2024 12:34:14 AM Member   True
```

This example shows how to find the registered owner of a device..

- `-DeviceId` parameter specifies the device's ID

### Example 2: Retrieve all the registered owners of a device

```powershell
Connect-Entra -Scopes 'Device.Read.All'
$device = Get-EntraBetaDevice -SearchString '<device-display-name>'
Get-EntraBetaDeviceRegisteredOwner -DeviceId $device.Id -All |
Select-Object Id, displayName, UserPrincipalName, createdDateTime, userType, accountEnabled |
Format-Table -AutoSize
```

```Output
id                                   DisplayName      UserPrincipalName         CreatedDateTime       UserType AccountEnabled
--                                   -----------      -----------------         ---------------       -------- --------------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb Maria Sullivan  maria@contoso.com         10/7/2024 12:34:14 AM Member   True
cccccccc-2222-3333-4444-dddddddddddd Parker McLean   parker@contoso.com        10/7/2024 12:34:14 AM Member   True
```

This command retrieves all the registered owners of a device.

- `-DeviceId` parameter specifies the device's ID.

### Example 3: Retrieve top one registered owner of a device

```powershell
Connect-Entra -Scopes 'Device.Read.All'
$device = Get-EntraBetaDevice -SearchString '<device-display-name>'
Get-EntraBetaDeviceRegisteredOwner -DeviceId $device.ObjectId -Top 1 |
Select-Object Id, displayName, UserPrincipalName, createdDateTime, userType, accountEnabled |
Format-Table -AutoSize
```

```Output
id                                   DisplayName      UserPrincipalName         CreatedDateTime       UserType AccountEnabled
--                                   -----------      -----------------         ---------------       -------- --------------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb Maria Sullivan  maria@contoso.com         10/7/2024 12:34:14 AM Member   True
```

This command retrieves all the registered owners of a device. You can use `-Limit` as an alias for `-Top`.

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
Aliases: Limit

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
Aliases: Select

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

## Related links

[Add-EntraBetaDeviceRegisteredOwner](Add-EntraBetaDeviceRegisteredOwner.md)

[Get-EntraBetaDevice](Get-EntraBetaDevice.md)

[Remove-EntraBetaDeviceRegisteredOwner](Remove-EntraBetaDeviceRegisteredOwner.md)
