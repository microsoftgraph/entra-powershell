---
title: Get-EntraBetaUserOwnedDevice
description: This article provides details on the Get-EntraBetaUserOwnedDevice command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Get-EntraBetaUserOwnedDevice

## Synopsis
Get registered devices owned by a user.

## Syntax

```powershell
Get-EntraBetaUserOwnedDevice 
 -ObjectId <String> 
 [-Top <Int32>] 
 [-All] 
 [<CommonParameters>]
```

## Description
The Get-EntraBetaUserOwnedDevice cmdlet gets registered devices owned by the specified user in Microsoft Entra ID.

## Examples

### Example 1: Get devices owned by a user
```powershell
PS C:\>Get-EntraUserOwnedDevice -ObjectId "df19e8e6-2ad7-453e-87f5-037f6529ae16"
```

```output
ObjectId                             DeviceId                             DisplayName
--------                             --------                             -----------
74825acb-c984-4b54-ab65-d38347ea5e90 6e9d44e6-f191-4957-bb31-c52f33817204 Device1
8542ebd1-3d49-4073-9dce-30f197c67755 6e9d44e6-f191-4957-bb31-c62f33817204 Device2
```

This command gets the registered devices owned by the specified user.

### Example 2: Get all devices owned by a user
```powershell
PS C:\>Get-EntraUserOwnedDevice -ObjectId "df19e8e6-2ad7-453e-87f5-037f6529ae16" -All
```

```output
ObjectId                             DeviceId                             DisplayName
--------                             --------                             -----------
74825acb-c984-4b54-ab65-d38347ea5e90 6e9d44e6-f191-4957-bb31-c52f33817204 Device1
8542ebd1-3d49-4073-9dce-30f197c67755 6e9d44e6-f191-4957-bb31-c62f33817204 Device2
```

This command gets all the registered devices owned by the specified user.

### Example 3: Get top one device owned by a user
```powershell
PS C:\>Get-EntraUserOwnedDevice -ObjectId "df19e8e6-2ad7-453e-87f5-037f6529ae16" -Top 1
```

```output
ObjectId                             DeviceId                             DisplayName
--------                             --------                             -----------
74825acb-c984-4b54-ab65-d38347ea5e90 6e9d44e6-f191-4957-bb31-c52f33817204 Device1
```

This command gets top one registered device owned by the specified user.


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

### -ObjectId
Specifies the ID of a user (as a UPN or ObjectId) in Microsoft Entra ID.

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

### -Top
Specifies the maximum number of records to return.

```yaml
Type: Int32
Parameter Sets: (All)
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

## RELATED LINKS