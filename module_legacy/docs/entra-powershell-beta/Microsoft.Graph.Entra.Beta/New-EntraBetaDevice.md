---
title: New-EntraBetaDevice
description: This article provides details on the New-EntraBetaDevice command.


ms.topic: reference
ms.date: 08/12/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/New-EntraBetaDevice

schema: 2.0.0
---

# New-EntraBetaDevice

## Synopsis

Creates a device.

## Syntax

```powershell
New-EntraBetaDevice
 -DisplayName <String>
 -DeviceOSType <String>
 -AccountEnabled <Boolean>
 -DeviceId <String>
 -DeviceOSVersion <String>
 -AlternativeSecurityIds <System.Collections.Generic.List`1[Microsoft.Open.AzureAD.Model.AlternativeSecurityId]>
 [-DevicePhysicalIds <System.Collections.Generic.List`1[System.String]>]
 [-DeviceTrustType <String>]
 [-DeviceMetadata <String>]
 [-ApproximateLastLogonTimeStamp <DateTime>]
 [-IsManaged <Boolean>]
 [-DeviceObjectVersion <Int32>]
 [-IsCompliant <Boolean>]
 [-ProfileType <String>]
 [-SystemLabels <System.Collections.Generic.List`1[System.String]>]
 [<CommonParameters>]
```

## Description

The `New-EntraBetaDevice` cmdlet creates a device in Microsoft Entra ID.

The calling user must be in one of the following Microsoft Entra roles: Intune Administrator or Windows 365 Administrator.

## Examples

### Example 1: Create a device

```powershell
Connect-Entra -Scopes 'Directory.AccessAsUser.All','Device.ReadWrite.All'

$params = @{
    AccountEnabled = $true
    DisplayName = 'My new device'
    AlternativeSecurityIds = $altsecid
    DeviceId = $guid
    DeviceOSType = 'OS/2'
    DeviceOSVersion = '9.3'
}

New-EntraBetaDevice @params
```

```Output
ObjectId                             DeviceId                             DisplayName
--------                             --------                             -----------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb dddddddd-3333-4444-5555-eeeeeeeeeeee My new device
```

This command creates a new device.

## Parameters

### -AccountEnabled

Indicates whether the account is enabled.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AlternativeSecurityIds

Specifies alternative security IDs.

```yaml
Type: System.Collections.Generic.List`1[Microsoft.Open.AzureAD.Model.AlternativeSecurityId]
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ApproximateLastLogonTimeStamp

Specifies last sign-in date time.

```yaml
Type: System.DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DeviceId

Specifies the ID of the device.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DeviceMetadata

The metadata for this device

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DeviceObjectVersion

Specifies the object version of the device.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DeviceOSType

Specifies the operating system type of the new device.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DeviceOSVersion

Specifies the operating system version of the new device.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DevicePhysicalIds

Specifies the physical ID.

```yaml
Type: System.Collections.Generic.List`1[System.String]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DeviceTrustType

The trust type for this device

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DisplayName

Specifies the display name of the new device.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IsCompliant

True if the device complies with Mobile Device Management (MDM) policies; otherwise, false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IsManaged

True if the device is managed by a Mobile Device Management (MDM) app such as Intune; otherwise, false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ProfileType

Specifies profile type of the device.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SystemLabels

Specifies labels for the device.

```yaml
Type: System.Collections.Generic.List`1[System.String]
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

[Get-EntraBetaDevice](Get-EntraBetaDevice.md)

[Remove-EntraBetaDevice](Remove-EntraBetaDevice.md)

[Set-EntraBetaDevice](Set-EntraBetaDevice.md)
