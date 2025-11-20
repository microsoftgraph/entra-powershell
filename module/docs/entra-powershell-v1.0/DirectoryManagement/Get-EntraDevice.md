---
author: msewaweru
description: This article provides details on the Get-EntraDevice command.
external help file: Microsoft.Entra.DirectoryManagement-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.DirectoryManagement
ms.author: eunicewaweru
ms.date: 06/26/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.DirectoryManagement/Get-EntraDevice
schema: 2.0.0
title: Get-EntraDevice
---

# Get-EntraDevice

## SYNOPSIS

Gets a device from Microsoft Entra ID.

## SYNTAX

### GetQuery (Default)

```powershell
Get-EntraDevice
 [-Top <Int32>]
 [-All]
 [-Filter <String>]
 [-Property <String[]>]
 [-LogonTimeBefore <DateTime>]
 [-Stale]
 [-NonCompliant]
 [-IsManaged <Boolean>]
 [-JoinType <String>]
 [<CommonParameters>]
```

### GetByValue

```powershell
Get-EntraDevice
 [-SearchString <String>]
 [-All]
 [-Property <String[]>]
 [-LogonTimeBefore <DateTime>]
 [-Stale]
 [-NonCompliant]
 [-IsManaged <Boolean>]
 [-JoinType <String>]
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

## DESCRIPTION

The `Get-EntraDevice` cmdlet gets a device from Microsoft Entra ID. Specify the `DeviceId` parameter to get a specific device.

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
$device = Get-EntraDevice -SearchString '<device-display-name>'
Get-EntraDevice -ObjectId $device.ObjectId
```

```Output
DeletedDateTime Id                                   AccountEnabled ApproximateLastSignInDateTime ComplianceExpirationDateTime DeviceCategory DeviceId                             DeviceMetadata DeviceOwnership
--------------- --                                   -------------- ----------------------------- ---------------------------- -------------- --------                             -------------- ---------------
                bbbbbbbb-1111-2222-3333-cccccccccccc True                                                                                     eeeeeeee-4444-5555-6666-ffffffffffff MetaData
```

This example shows how to retrieve a device using its ID.

### Example 2: Get a device by DeviceID

```powershell
Connect-Entra -Scopes 'Device.Read.All'
Get-EntraDevice -Filter "DeviceId eq 'eeeeeeee-4444-5555-6666-ffffffffffff'" 
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
Get-EntraDevice
```

```Output
DeletedDateTime Id                                   AccountEnabled ApproximateLastSignInDateTime ComplianceExpirationDateTime DeviceCategory DeviceId                             DeviceMetadata DeviceOwnership
--------------- --                                   -------------- ----------------------------- ---------------------------- -------------- --------                             -------------- ---------------
                bbbbbbbb-1111-2222-3333-cccccccccccc True                                                                                     eeeeeeee-4444-5555-6666-ffffffffffff MetaData
                cccccccc-2222-3333-4444-dddddddddddd True                                                                                     eeeeeeee-4444-5555-6666-ffffffffffff MetaData
```

This example demonstrates how to retrieve all devices from Microsoft Entra ID.

### Example 4: Get top two devices

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

This example demonstrates how to retrieve top two devices from Microsoft Entra ID. You can use `-Limit` as an alias for `-Top`.

### Example 5: Get a device by display name

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

### Example 6: Get a device using display name

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

### Example 7: Search among retrieved devices

```powershell
Connect-Entra -Scopes 'Device.Read.All'
Get-EntraDevice -SearchString 'DESKTOP'
```

```Output
DeletedDateTime Id                                   AccountEnabled ApproximateLastSignInDateTime ComplianceExpirationDateTime DeviceCategory DeviceId                             DeviceMetadata DeviceOwnership
--------------- --                                   -------------- ----------------------------- ---------------------------- -------------- --------                             -------------- ---------------
                bbbbbbbb-1111-2222-3333-cccccccccccc True                                                                                     eeeeeeee-4444-5555-6666-ffffffffffff MetaData
```

This example shows how to retrieve devices containing the word 'DESKTOP'.

### Example 8: List duplicate devices

```powershell
Connect-Entra -Scopes 'Device.Read.All'
Get-EntraDevice -All -Select DisplayName, OperatingSystem |
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
Get-EntraDevice -Filter "isCompliant eq false"
```

### Example 10: List jail broken devices

```powershell
Connect-Entra -Scopes 'Device.Read.All'
Get-EntraDevice -All | Where-Object { $_.isRooted -eq $true }
```

### Example 11: List managed devices

```powershell
Connect-Entra -Scopes 'Device.Read.All'
Get-EntraDevice -Filter "isManaged eq true"
```

### Example 12: List enabled devices

```powershell
Connect-Entra -Scopes 'Device.Read.All'
Get-EntraDevice -Filter "accountEnabled eq true" -All
```

### Example 13: List devices with specific operating system and version

```powershell
Connect-Entra -Scopes 'Device.Read.All'
Get-EntraDevice -Filter "operatingSystem eq 'Windows Server' and operatingSystemVersion eq '10.0.20348.3091'"
```

### Example 14: Get stale devices (inactive for 2+ months)

```powershell
Connect-Entra -Scopes 'Device.Read.All'
Get-EntraDevice -Stale
```

```Output
DeletedDateTime Id                                   AccountEnabled ApproximateLastSignInDateTime ComplianceExpirationDateTime DeviceCategory DeviceId                             DeviceMetadata DeviceOwnership
--------------- --                                   -------------- ----------------------------- ---------------------------- -------------- --------                             -------------- ---------------
                bbbbbbbb-1111-2222-3333-cccccccccccc True           2024-08-15T10:30:00Z                                                      eeeeeeee-4444-5555-6666-ffffffffffff MetaData
```

This example demonstrates how to retrieve devices that haven't signed in for 2 months or more.

### Example 15: Get devices that signed in before a specific date

```powershell
Connect-Entra -Scopes 'Device.Read.All'
$date = Get-Date "2024-09-01"
Get-EntraDevice -LogonTimeBefore $date
```

```Output
DeletedDateTime Id                                   AccountEnabled ApproximateLastSignInDateTime ComplianceExpirationDateTime DeviceCategory DeviceId                             DeviceMetadata DeviceOwnership
--------------- --                                   -------------- ----------------------------- ---------------------------- -------------- --------                             -------------- ---------------
                bbbbbbbb-1111-2222-3333-cccccccccccc True           2024-08-15T10:30:00Z                                                      eeeeeeee-4444-5555-6666-ffffffffffff MetaData
```

This example demonstrates how to retrieve devices with last sign-in before September 1, 2024.

### Example 16: Get non-compliant devices using NonCompliant parameter

```powershell
Connect-Entra -Scopes 'Device.Read.All'
Get-EntraDevice -NonCompliant
```

```Output
DeletedDateTime Id                                   AccountEnabled ApproximateLastSignInDateTime ComplianceExpirationDateTime DeviceCategory DeviceId                             DeviceMetadata DeviceOwnership
--------------- --                                   -------------- ----------------------------- ---------------------------- -------------- --------                             -------------- ---------------
                bbbbbbbb-1111-2222-3333-cccccccccccc True                                                                                     eeeeeeee-4444-5555-6666-ffffffffffff MetaData
```

This example demonstrates how to retrieve devices that are not compliant with organizational policies.

### Example 17: Get managed devices

```powershell
Connect-Entra -Scopes 'Device.Read.All'
Get-EntraDevice -IsManaged $true
```

```Output
DeletedDateTime Id                                   AccountEnabled ApproximateLastSignInDateTime ComplianceExpirationDateTime DeviceCategory DeviceId                             DeviceMetadata DeviceOwnership
--------------- --                                   -------------- ----------------------------- ---------------------------- -------------- --------                             -------------- ---------------
                bbbbbbbb-1111-2222-3333-cccccccccccc True                                                                                     eeeeeeee-4444-5555-6666-ffffffffffff MetaData
```

This example demonstrates how to retrieve devices managed by a Mobile Device Management (MDM) solution.

### Example 18: Get Microsoft Entra Joined devices

```powershell
Connect-Entra -Scopes 'Device.Read.All'
Get-EntraDevice -JoinType "MicrosoftEntraJoined"
```

```Output
DeletedDateTime Id                                   AccountEnabled ApproximateLastSignInDateTime ComplianceExpirationDateTime DeviceCategory DeviceId                             DeviceMetadata DeviceOwnership
--------------- --                                   -------------- ----------------------------- ---------------------------- -------------- --------                             -------------- ---------------
                bbbbbbbb-1111-2222-3333-cccccccccccc True                                                                                     eeeeeeee-4444-5555-6666-ffffffffffff MetaData
```

This example demonstrates how to retrieve devices that are Microsoft Entra Joined.

### Example 19: Get Microsoft Entra Hybrid Joined devices

```powershell
Connect-Entra -Scopes 'Device.Read.All'
Get-EntraDevice -JoinType "MicrosoftEntraHybridJoined"
```

This example demonstrates how to retrieve devices that are Microsoft Entra Hybrid Joined.

### Example 20: Combine multiple filter parameters

```powershell
Connect-Entra -Scopes 'Device.Read.All'
Get-EntraDevice -Stale -NonCompliant -IsManaged $true
```

```Output
DeletedDateTime Id                                   AccountEnabled ApproximateLastSignInDateTime ComplianceExpirationDateTime DeviceCategory DeviceId                             DeviceMetadata DeviceOwnership
--------------- --                                   -------------- ----------------------------- ---------------------------- -------------- --------                             -------------- ---------------
                bbbbbbbb-1111-2222-3333-cccccccccccc True           2024-08-15T10:30:00Z                                                      eeeeeeee-4444-5555-6666-ffffffffffff MetaData
```

This example demonstrates how to combine multiple filter parameters to find devices that are stale, non-compliant, and managed.

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

### -LogonTimeBefore

Filter devices with last sign-in before a specified date.

```yaml
Type: System.DateTime
Parameter Sets: GetQuery, GetVague
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Stale

Filter devices that haven't signed in for 2 months or more.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: GetQuery, GetVague
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -NonCompliant

Filter devices that are not compliant with organizational policies.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: GetQuery, GetVague
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -IsManaged

Filter devices based on whether they are managed by a Mobile Device Management (MDM) solution. Use `$true` for managed devices or `$false` for unmanaged devices.

```yaml
Type: System.Nullable`1[System.Boolean]
Parameter Sets: GetQuery, GetVague
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -JoinType

Filter devices by join type: MicrosoftEntraJoined, MicrosoftEntraHybridJoined, or MicrosoftEntraRegistered.

```yaml
Type: System.String
Parameter Sets: GetQuery, GetVague
Aliases:
Accepted values: MicrosoftEntraJoined, MicrosoftEntraHybridJoined, MicrosoftEntraRegistered

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[New-EntraDevice](New-EntraDevice.md)

[Remove-EntraDevice](Remove-EntraDevice.md)

[Set-EntraDevice](Set-EntraDevice.md)
