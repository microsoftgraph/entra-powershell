---
title: Get-EntraUserOwnedDevice
description: This article provides details on the Get-EntraUserOwnedDevice command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/en-us/powershell/module/Microsoft.Graph.Entra/Get-EntraUserOwnedDevice

schema: 2.0.0
---

# Get-EntraUserOwnedDevice

## Synopsis

Get registered devices owned by a user.

## Syntax

```powershell
Get-EntraUserOwnedDevice
 -ObjectId <String>
 [-All ]
 [-Top <Int32>]
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

The Get-EntraUserOwnedDevice cmdlet gets registered devices owned by the specified user in Microsoft Entra ID.

## Examples

### Example 1: Get devices owned by a user

```powershell
Connect-Entra -Scopes 'User.Read'
Get-EntraUserOwnedDevice -ObjectId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'
```

```Output
ObjectId                             DeviceId                             DisplayName
--------                             --------                             -----------
cccccccc-2222-3333-4444-dddddddddddd aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb Device1
dddddddd-3333-4444-5555-eeeeeeeeeeee aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb Device2
```

This command gets the registered devices owned by the specified user.

### Example 2: Get all devices owned by a user

```powershell
Connect-Entra -Scopes 'User.Read'
Get-EntraUserOwnedDevice -ObjectId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb' -All
```

```output
ObjectId                             DeviceId                             DisplayName
--------                             --------                             -----------
cccccccc-2222-3333-4444-dddddddddddd aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb Device1
dddddddd-3333-4444-5555-eeeeeeeeeeee aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb Device2
```

This command gets all the registered devices owned by the specified user.

### Example 3: Get top one device owned by a user

```powershell
Connect-Entra -Scopes 'User.Read'
Get-EntraUserOwnedDevice -ObjectId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb' -Top 1
```

```Output
ObjectId                             DeviceId                             DisplayName
--------                             --------                             -----------
cccccccc-2222-3333-4444-dddddddddddd aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb Device1
```

This command gets top one registered device owned by the specified user.

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

### -ObjectId

Specifies the ID of a user (as a UPN or ObjectId) in Microsoft Entra ID.

```yaml
Type: System.String
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
Type: System.Int32
Parameter Sets: (All)
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
