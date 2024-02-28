---
title: Get-EntraDeviceRegisteredUser.
description: This article provides details on the Get-EntraDeviceRegisteredUser command.

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

# Get-EntraDeviceRegisteredUser

## SYNOPSIS
Gets a registered user.

## SYNTAX

```
Get-EntraDeviceRegisteredUser 
 -ObjectId <String> 
 [-All <Boolean>] 
 [-Top <Int32>] 
 [<CommonParameters>]
```

## DESCRIPTION
The Get-EntraDeviceRegisteredUser cmdlet gets a registered user for a Microsoft Entra ID device.

## EXAMPLES

### Example 1: Retrieve the registered users of a device
```
PS C:\> $DevId = (Get-EntraDevice -Top 1).ObjectId
PS C:\> Get-EntraDeviceRegisteredUser -ObjectId $DevId
```

The first command gets the object ID of a device by using the Get-EntraDevice (./Get-EntraDevice.md)cmdlet, and then stores it in the $DevId variable.
The second command gets the registered users of the device in $DevId.

### Example 2: Retrieve the registered users of a device
```
PS C:\> Get-EntraDeviceRegisteredUser -ObjectId "74825acb-c984-4b54-ab65-d38347ea5e90"
```

This command gets the registered users of the specified device.

### Example 3: Get all registered users of a device
```
PS C:\> Get-EntraDeviceRegisteredUser -ObjectId "74825acb-c984-4b54-ab65-d38347ea5e90" -All $true
```

This command gets the all registered users of the specified device.

### Example 4: Get five registered users of a device
```
PS C:\> Get-EntraDeviceRegisteredUser -ObjectId "74825acb-c984-4b54-ab65-d38347ea5e90" -Top 5
```

This command gets five registered users of the specified device.

## PARAMETERS

### -All
If true, return all registered users.
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

### -ObjectId
Specifies an object ID.

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
@{Text=}

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Add-EntraDeviceRegisteredUser]()

[Remove-EntraDeviceRegisteredUser]()

