---
title: Get-EntraDevice.
description: This article provides details on the Get-EntraDevice command.

ms.service: entra
ms.topic: reference
ms.date: 03/15/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
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
 [<CommonParameters>]
```

### GetByValue
```powershell
Get-EntraDevice 
 [-SearchString <String>]
 [-All]
 [<CommonParameters>]
```

### GetById
```powershell
Get-EntraDevice 
 -ObjectId <String>
 [-All]
 [<CommonParameters>]
```

## Description
The Get-EntraDevice cmdlet gets a device from Microsoft Entra ID.

## Examples

### Example 1: Get a device by ID
```powershell
PS C:\>Get-EntraDevice -ObjectId "74825acb-c984-4b54-ab65-d38347ea5e90"
```
```output
DeletedDateTime Id                                   AccountEnabled ApproximateLastSignInDateTime ComplianceExpirationDateTime DeviceCategory DeviceId                             DeviceMetadata DeviceOwnership
--------------- --                                   -------------- ----------------------------- ---------------------------- -------------- --------                             -------------- ---------------
                74825acb-c984-4b54-ab65-d38347ea5e90 True                                                                                     6e9d44e6-f191-4957-bb31-c52f33817204 MetaData
```

This example demonstrates how to retrieve specific device by providing ID.  
This command gets the specified device.

### Example 2: Get all devices
```powershell
PS C:\>Get-EntraDevice
```
```output    
DeletedDateTime Id                                   AccountEnabled ApproximateLastSignInDateTime ComplianceExpirationDateTime DeviceCategory DeviceId                             DeviceMetadata DeviceOwnership
--------------- --                                   -------------- ----------------------------- ---------------------------- -------------- --------                             -------------- ---------------
                74825acb-c984-4b54-ab65-d38347ea5e90 True                                                                                     6e9d44e6-f191-4957-bb31-c52f33817204 MetaData
                8542ebd1-3d49-4073-9dce-30f197c67755 True                                                                                     6e9d44e6-f191-4957-bb31-c62f33817204 MetaData
```

This example demonstrates how to retrieve all devices from Microsoft Entra ID.  
This command gets all available devices.

### Example 3: Get top two devices
```powershell
PS C:\>Get-EntraDevice -Top 2
```
```output
DeletedDateTime Id                                   AccountEnabled ApproximateLastSignInDateTime ComplianceExpirationDateTime DeviceCategory DeviceId                             DeviceMetadata DeviceOwnership
--------------- --                                   -------------- ----------------------------- ---------------------------- -------------- --------                             -------------- ---------------
                74825acb-c984-4b54-ab65-d38347ea5e90 True                                                                                     6e9d44e6-f191-4957-bb31-c52f33817204 MetaData
                8542ebd1-3d49-4073-9dce-30f197c67755 True                                                                                     6e9d44e6-f191-4957-bb31-c62f33817204 MetaData
```

This example demonstrates how to retrieve top two devices from Microsoft Entra ID.  
This command gets the two devices from Microsoft Entra ID.

### Example 4: Get a device by display name
```powershell
PS C:\>Get-EntraDevice -Filter "DisplayName eq 'AkshayLodha'"
```
```output
DeletedDateTime Id                                   AccountEnabled ApproximateLastSignInDateTime ComplianceExpirationDateTime DeviceCategory DeviceId                             DeviceMetadata DeviceOwnership
--------------- --                                   -------------- ----------------------------- ---------------------------- -------------- --------                             -------------- ---------------
                74825acb-c984-4b54-ab65-d38347ea5e90 True                                                                                     6e9d44e6-f191-4957-bb31-c52f33817204 MetaData
```

This example demonstrates how to retrieve device by display name from Microsoft Entra ID.  
This command gets the specified device.

### Example 5: Get a device by display name
```powershell
PS C:\>Get-EntraDevice -Filter "startswith(DisplayName,'Aksh')"
```
```output
DeletedDateTime Id                                   AccountEnabled ApproximateLastSignInDateTime ComplianceExpirationDateTime DeviceCategory DeviceId                             DeviceMetadata DeviceOwnership
--------------- --                                   -------------- ----------------------------- ---------------------------- -------------- --------                             -------------- ---------------
                74825acb-c984-4b54-ab65-d38347ea5e90 True                                                                                     6e9d44e6-f191-4957-bb31-c52f33817204 MetaData
```

This example demonstrates how to retrieve all the devices whose display name starts with Aksh from Microsoft Entra ID.  

### Example 6: Search among retrieved devices
```powershell
PS C:\>Get-EntraDevice -SearchString "Ashwini"
```
```output
DeletedDateTime Id                                   AccountEnabled ApproximateLastSignInDateTime ComplianceExpirationDateTime DeviceCategory DeviceId                             DeviceMetadata DeviceOwnership
--------------- --                                   -------------- ----------------------------- ---------------------------- -------------- --------                             -------------- ---------------
                8542ebd1-3d49-4073-9dce-30f197c67755 True                                                                                     6e9d44e6-f191-4957-bb31-c62f33817204 MetaData
```

This example demonstrates how to retrieve devices by search string from Microsoft Entra ID.  
This command gets all devices that match the value of SearchString against the first characters in DisplayName.

## Parameters

### -All
List all pages.

```yaml
Type: SwitchParameter
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
Type: String
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
Type: String
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
Type: String
Parameter Sets: GetVague
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
Type: Int32
Parameter Sets: GetQuery
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related LINKS

[New-EntraDevice](New-EntraDevice.md)

[Remove-EntraDevice](Remove-EntraDevice.md)

[Set-EntraDevice](Set-EntraDevice.md)

