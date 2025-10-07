---
author: msewaweru
description: This article provides details on the Get-EntraBetaDeviceRegisteredUser command.
external help file: Microsoft.Entra.Beta.DirectoryManagement-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.Beta.DirectoryManagement
ms.author: eunicewaweru
ms.date: 02/05/2025
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta.DirectoryManagement/Get-EntraBetaDeviceRegisteredUser
schema: 2.0.0
title: Get-EntraBetaDeviceRegisteredUser
---

# Get-EntraBetaDeviceRegisteredUser

## SYNOPSIS

Retrieve a list of users that are registered users of the device.

## SYNTAX

```powershell
Get-EntraBetaDeviceRegisteredUser
 -DeviceId <String>
 [-All]
 [-Top <Int32>]
 [-Property <String[]>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Get-EntraBetaDeviceRegisteredUser` cmdlet gets a registered user for a Microsoft Entra ID device. Specify `DeviceId` parameter to get a registered user for a Microsoft Entra ID device.

In delegated scenarios with work or school accounts, the signed-in user must have a supported Microsoft Entra role or a custom role with the necessary permissions. The following least privileged roles are supported:

- Directory Readers
- Global Reader
- Intune Administrator
- Windows 365 Administrator

## EXAMPLES

### Example 1: Retrieve the registered user of a device

```powershell
Connect-Entra -Scopes 'Device.Read.All'
$device = Get-EntraBetaDevice -SearchString '<device-display-name>'
Get-EntraBetaDeviceRegisteredUser -DeviceId $device.ObjectId |
Select-Object Id, displayName, UserPrincipalName, createdDateTime, userType, accountEnabled |
Format-Table -AutoSize
```

```Output
id                                   DisplayName      UserPrincipalName         CreatedDateTime       UserType AccountEnabled
--                                   -----------      -----------------         ---------------       -------- --------------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb Maria Sullivan  maria@contoso.com         10/7/2024 12:34:14 AM Member   True
cccccccc-2222-3333-4444-dddddddddddd Parker McLean   parker@contoso.com        10/7/2024 12:34:14 AM Member   True
```

This example demonstrates how to retrieve registered user for a specific Microsoft Entra ID device.

### Example 2: Get all registered users of a device

```powershell
Connect-Entra -Scopes 'Device.Read.All'
$device = Get-EntraBetaDevice -SearchString '<device-display-name>'
Get-EntraBetaDeviceRegisteredUser -DeviceId $device.ObjectId -All |
Select-Object Id, displayName, UserPrincipalName, createdDateTime, userType, accountEnabled |
Format-Table -AutoSize
```

```Output
id                                   DisplayName      UserPrincipalName         CreatedDateTime       UserType AccountEnabled
--                                   -----------      -----------------         ---------------       -------- --------------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb Maria Sullivan  maria@contoso.com         10/7/2024 12:34:14 AM Member   True
cccccccc-2222-3333-4444-dddddddddddd Parker McLean   parker@contoso.com        10/7/2024 12:34:14 AM Member   True
```

This example demonstrates how to retrieve all registered users for a specified device.

- `-DeviceId` parameter specifies an object ID of a device, which you want to retrieve.

### Example 3: Get top two registered users of a device

```powershell
Connect-Entra -Scopes 'Device.Read.All'
$device = Get-EntraBetaDevice -SearchString '<device-display-name>'
Get-EntraBetaDeviceRegisteredUser -DeviceId $device.ObjectId -Top 2 |
Select-Object Id, displayName, UserPrincipalName, createdDateTime, userType, accountEnabled |
Format-Table -AutoSize
```

```Output
id                                   DisplayName      UserPrincipalName         CreatedDateTime       UserType AccountEnabled
--                                   -----------      -----------------         ---------------       -------- --------------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb Maria Sullivan  maria@contoso.com         10/7/2024 12:34:14 AM Member   True
cccccccc-2222-3333-4444-dddddddddddd Parker McLean   parker@contoso.com        10/7/2024 12:34:14 AM Member   True
```

This example demonstrates how to retrieve top two registered users for the specified device. You can use `-Limit` as an alias for `-Top`.

- `-DeviceId` parameter specifies an object ID of a device, which you want to retrieve.

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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Add-EntraBetaDeviceRegisteredUser](Add-EntraBetaDeviceRegisteredUser.md)

[Remove-EntraBetaDeviceRegisteredUser](Remove-EntraBetaDeviceRegisteredUser.md)
