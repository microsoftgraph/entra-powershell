---
title: Set-EntraDevice.
description: This article provides details on the Set-EntraDevice command.

ms.service: entra
ms.topic: reference
ms.date: 03/18/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Set-EntraDevice

## Synopsis
Updates a device.

## Syntax

```powershell
Set-EntraDevice
 -ObjectId <String> 
 [-DevicePhysicalIds <System.Collections.Generic.List`1[System.String]>]
 [-DeviceOSType <String>] 
 [-DeviceTrustType <String>] 
 [-DisplayName <String>] 
 [-DeviceMetadata <String>]
 [-ApproximateLastLogonTimeStamp <DateTime>] 
 [-AccountEnabled <Boolean>]
 [-IsManaged <Boolean>] 
 [-DeviceId <String>] 
 [-DeviceObjectVersion <Int32>] 
 [-IsCompliant <Boolean>]
 [-DeviceOSVersion <String>]
 [-AlternativeSecurityIds <System.Collections.Generic.List`1[Microsoft.Open.AzureAD.Model.AlternativeSecurityId]>]
 [-ProfileType <String>] 
 [-SystemLabels <System.Collections.Generic.List`1[System.String]>]
 [<CommonParameters>]
```

## Description
The Set-EntraDevice cmdlet updates a device in Microsoft Entra ID.

## Examples

### Example 1: Update a device display name
```powershell
PS C:\>Set-EntraDevice -ObjectId "99a1915d-298f-42d1-93ae-71646b85e2fa" -DisplayName "My OS/2 computer"
```
This example demonstrates how to update a display name of a specified device in Microsoft Entra ID.    
This command updates the display name of a specified device.

### Example 2: Update a device alternative security Id
```powershell
PS C:\> $NewId= New-Object Microsoft.Open.AzureAD.Model.AlternativeSecurityId
$NewId.Key =[System.Text.Encoding]::UTF8.GetBytes("test")
$NewId.type = 2
PS C:\> Set-EntraDevice -ObjectId "2d3a1947-4e0f-4136-9be5-9721f12bd887" -AlternativeSecurityIds $NewId
```

This example demonstrates how to update an alternative security Id of a specified device in Microsoft Entra ID.    
This command updates the alternative security Id of a specified device.

### Example 3: Update a device account enabled
```powershell
PS C:\>Set-EntraDevice -ObjectId "00c3df15-a322-4b60-8887-a8830316c6b5" -AccountEnabled $true
```

This example demonstrates how to update an account enabled of a specified device in Microsoft Entra ID.  
This command updates the account enabled of a specified device.

### Example 4: Update a device OS type
```powershell
PS C:\>Set-EntraDevice -ObjectId "2d3a1947-4e0f-4136-9be5-9721f12bd887" -DeviceOSType Windows
```

This example demonstrates how to update an OS type of a specified device in Microsoft Entra ID.  
This command updates the OS type of a specified device.

### Example 5: Update a device
```powershell
PS C:\>Set-EntraDevice -ObjectId "2d3a1947-4e0f-4136-9be5-9721f12bd887" -DeviceMetadata "Testdeivce" -DeviceObjectVersion 4 -DevicePhysicalIds "[GID]:g:6966518641169131" -IsCompliant $false
```

This example demonstrates how to update a multiple properties of a specified device in Microsoft Entra ID.    
This command updates the specified properties of a specified device.

## Parameters

### -AccountEnabled
Indicates whether the account is enabled.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
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

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ApproximateLastLogonTimeStamp
The timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z. Read-only. Supports $filter (eq, ne, not, ge, le, and eq on null values) and $orderby.

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DeviceId
Specifies the device ID.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DeviceMetadata
The device metadata for this device.

```yaml
Type: String
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
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DeviceOSType
Specifies the operating system.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DeviceOSVersion
Specifies the operating system version.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
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
Specifies the device trust type.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DisplayName
Specifies the display name.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IsCompliant
Indicates whether the device is compliant.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IsManaged
Indicates whether the device is managed.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ObjectId
Specifies the object ID of a device in Microsoft Entra ID.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -ProfileType
Specifies the profile type of the device. Possible values: RegisteredDevice (default), SecureVM, Printer, Shared, IoT.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SystemLabels
Specifies list of labels applied to the device by the system.

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related LINKS

[Get-EntraDevice](Get-EntraDevice.md)

[New-EntraDevice](New-EntraDevice.md)

[Remove-EntraDevice](Remove-EntraDevice.md)

