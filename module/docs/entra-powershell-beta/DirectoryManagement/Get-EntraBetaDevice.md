---
author: msewaweru
description: This article provides details on the Get-EntraBetaDevice command.
external help file: Microsoft.Entra.Beta.DirectoryManagement-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.Beta.DirectoryManagement
ms.author: eunicewaweru
ms.date: 06/17/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta.DirectoryManagement/Get-EntraBetaDevice
schema: 2.0.0
title: Get-EntraBetaDevice
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

## DESCRIPTION

The `Get-EntraBetaDevice` cmdlet gets a device from Microsoft Entra ID. Specify the `DeviceId` parameter to get a specific device.

In delegated scenarios with work or school accounts, the signed-in user must have a supported Microsoft Entra role or a custom role with the required permissions. The following least privileged roles are supported:

- Cloud Device Administrator
- Intune Administrator
- Windows 365 Administrator
- Compliance Administrator
- Device Managers

## EXAMPLES

### Example 1: Get a device by ID

```powershell
Connect-Entra -Scopes 'Device.Read.All'
$device = Get-EntraBetaDevice -SearchString '<device-display-name>'
Get-EntraBetaDevice -DeviceId $device.ObjectId
```

```Output
DeletedDateTime Id                                   AccountEnabled ApproximateLastSignInDateTime ComplianceExpirationDateTime DeviceCategory DeviceId                             DeviceMetada
                                                                                                                                                                                   ta
--------------- --                                   -------------- ----------------------------- ---------------------------- -------------- --------                             ------------
                bbbbbbbb-1111-1111-1111-cccccccccccc True                                                                                     dddddddd-9999-0000-1111-eeeeeeeeeeee MetaData
```

This example shows how to retrieve a device using its ID.

### Example 2: Get a device by DeviceID

```powershell
Connect-Entra -Scopes 'Device.Read.All'
Get-EntraBetaDevice -Filter "DeviceId eq 'eeeeeeee-4444-5555-6666-ffffffffffff'" 
```

```Output
DeletedDateTime Id                                   AccountEnabled ApproximateLastSignInDateTime ComplianceExpirationDateTime DeviceCategory DeviceId                             DeviceMetadata DeviceOwnership
--------------- --                                   -------------- ----------------------------- ---------------------------- -------------- --------                             -------------- ---------------
                bbbbbbbb-1111-2222-3333-cccccccccccc True                                                                                     eeeeeeee-4444-5555-6666-ffffffffffff MetaData
```

This example shows how to retrieve a device using the DeviceID.

### Example 3: Get all devices

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

### Example 4: Get top two devices

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

This example demonstrates how to retrieve top two devices from Microsoft Entra ID. You can use `-Limit` as an alias for `-Top`.

### Example 5: Get a device by display name

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

### Example 6: Get a device using display name

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

### Example 7: Search among retrieved devices

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

### Example 8: List duplicate devices

```powershell
Connect-Entra -Scopes 'Device.Read.All'
Get-EntraBetaDevice -All -Select DisplayName, OperatingSystem |
Group-Object DisplayName |
Where-Object { $_.Count -gt 1 } |
Select-Object Name, @{Name = "OperatingSystem"; Expression = { ($_.Group | Select-Object -First 1).OperatingSystem } }, Count | Sort-Object Count -Descending |
Format-Table Name, OperatingSystem, Count -AutoSize
```

```Output
Name                       OperatingSystem Count
----                       --------------- -----
iPhone                     iOS               175
samsungSM-S928B            Android            15
woodgrove-win11-client     Windows             2
```

The output lists duplicate devices by display name, operating system, and count.

### Example 9: List non-compliant devices

```powershell
Connect-Entra -Scopes 'Device.Read.All'
Get-EntraBetaDevice -Filter "isCompliant eq false"
```

### Example 10: List jail broken devices

```powershell
Connect-Entra -Scopes 'Device.Read.All'
Get-EntraBetaDevice -All | Where-Object { $_.isRooted -eq $true }
```

### Example 11: List managed devices

```powershell
Connect-Entra -Scopes 'Device.Read.All'
Get-EntraBetaDevice -Filter "isManaged eq true"
```

### Example 12: List enabled devices

```powershell
Connect-Entra -Scopes 'Device.Read.All'
Get-EntraBetaDevice -Filter "accountEnabled eq true" -All
```

### Example 13: List devices with specific operating system and version

```powershell
Connect-Entra -Scopes 'Device.Read.All'
Get-EntraBetaDevice -Filter "operatingSystem eq 'Windows Server' and operatingSystemVersion eq '10.0.20348.3091'"
```

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
Aliases: Limit

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

[New-EntraBetaDevice](New-EntraBetaDevice.md)

[Remove-EntraBetaDevice](Remove-EntraBetaDevice.md)

[Set-EntraBetaDevice](Set-EntraBetaDevice.md)
