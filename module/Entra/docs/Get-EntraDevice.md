---
title: Get-EntraDevice.
description: This article provides details on the Get-EntraDevice command.

ms.service: active-directory
ms.topic: reference
ms.date: 11/10/2023
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

## SYNOPSIS
Gets a device from Microsoft Entra ID.

## SYNTAX

### GetQuery (Default)
```
Get-EntraDevice 
 [-Top <Int32>]
 [-All <Boolean>]
 [-Filter <String>]
 [<CommonParameters>]
```

### GetByValue
```
Get-EntraDevice 
 [-SearchString <String>]
 [-All <Boolean>]
 [<CommonParameters>]
```

### GetById
```
Get-EntraDevice 
 -ObjectId <String>
 [-All <Boolean>]
 [<CommonParameters>]
```

## DESCRIPTION
The Get-EntraDevice cmdlet gets a device from Microsoft Entra ID.

## EXAMPLES

### Example 1: Get a device by ID
```
PS C:\>Get-EntraDevice -ObjectId 74825acb-c984-4b54-ab65-d38347ea5e90

DeletedDateTime Id                                   AccountEnabled ApproximateLastSignInDateTime ComplianceExpirationDateTime DeviceCategory DeviceId                             DeviceMetadata DeviceOwnership
--------------- --                                   -------------- ----------------------------- ---------------------------- -------------- --------                             -------------- ---------------
                74825acb-c984-4b54-ab65-d38347ea5e90 True                                                                                     6e9d44e6-f191-4957-bb31-c52f33817204 MetaData
```

This command gets the specified device.

### Example 2: Get all devices
```
PS C:\>Get-EntraDevice

DeletedDateTime Id                                   AccountEnabled ApproximateLastSignInDateTime ComplianceExpirationDateTime DeviceCategory DeviceId                             DeviceMetadata DeviceOwnership
--------------- --                                   -------------- ----------------------------- ---------------------------- -------------- --------                             -------------- ---------------
                74825acb-c984-4b54-ab65-d38347ea5e90 True                                                                                     6e9d44e6-f191-4957-bb31-c52f33817204 MetaData
                8542ebd1-3d49-4073-9dce-30f197c67755 True                                                                                     6e9d44e6-f191-4957-bb31-c62f33817204 MetaData
```

This command gets all available devices.

### Example 3: Get two devices
```
PS C:\>Get-EntraDevice -Top 2

DeletedDateTime Id                                   AccountEnabled ApproximateLastSignInDateTime ComplianceExpirationDateTime DeviceCategory DeviceId                             DeviceMetadata DeviceOwnership
--------------- --                                   -------------- ----------------------------- ---------------------------- -------------- --------                             -------------- ---------------
                74825acb-c984-4b54-ab65-d38347ea5e90 True                                                                                     6e9d44e6-f191-4957-bb31-c52f33817204 MetaData
                8542ebd1-3d49-4073-9dce-30f197c67755 True                                                                                     6e9d44e6-f191-4957-bb31-c62f33817204 MetaData
```

This command gets the two devices from Microsoft Entra ID.

### Example 4: Get a device by display name
```
PS C:\>Get-EntraDevice -Filter "DisplayName eq 'AkshayLodha'"

DeletedDateTime Id                                   AccountEnabled ApproximateLastSignInDateTime ComplianceExpirationDateTime DeviceCategory DeviceId                             DeviceMetadata DeviceOwnership
--------------- --                                   -------------- ----------------------------- ---------------------------- -------------- --------                             -------------- ---------------
                74825acb-c984-4b54-ab65-d38347ea5e90 True                                                                                     6e9d44e6-f191-4957-bb31-c52f33817204 MetaData
```

This command gets the specified device.

### Example 5: Get a devices by display name
```
PS C:\>Get-EntraDevice -Filter "startswith(DisplayName,'Aksh')"

DeletedDateTime Id                                   AccountEnabled ApproximateLastSignInDateTime ComplianceExpirationDateTime DeviceCategory DeviceId                             DeviceMetadata DeviceOwnership
--------------- --                                   -------------- ----------------------------- ---------------------------- -------------- --------                             -------------- ---------------
                74825acb-c984-4b54-ab65-d38347ea5e90 True                                                                                     6e9d44e6-f191-4957-bb31-c52f33817204 MetaData
```

This command gets all the devices whos display name starts with Aksh.

### Example 6: Search among retrieved devices
```
PS C:\>Get-EntraDevice -SearchString "Ashwini"

DeletedDateTime Id                                   AccountEnabled ApproximateLastSignInDateTime ComplianceExpirationDateTime DeviceCategory DeviceId                             DeviceMetadata DeviceOwnership
--------------- --                                   -------------- ----------------------------- ---------------------------- -------------- --------                             -------------- ---------------
                8542ebd1-3d49-4073-9dce-30f197c67755 True                                                                                     6e9d44e6-f191-4957-bb31-c62f33817204 MetaData
```

This command gets all devices that match the value of SearchString against the first characters in DisplayName.

## PARAMETERS

### -All
If true, return all devices.
If false, return the number of objects specified by the Top parameter

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[New-EntraDevice]()

[Remove-EntraDevice]()

[Set-EntraDevice]()

