---
title: Add-EntraDeviceRegisteredOwner
description: This article provides details on the Add-EntraDeviceRegisteredOwner command.

ms.service: entra
ms.topic: reference
ms.date: 03/16/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Add-EntraDeviceRegisteredOwner

## SYNOPSIS

Adds a registered owner for a device.

## SYNTAX

```powershell
Add-EntraDeviceRegisteredOwner 
 -ObjectId <String> 
 -RefObjectId <String> 
 [<CommonParameters>]
```

## DESCRIPTION

The `Add-EntraDeviceRegisteredOwner` cmdlet adds a registered owner for a Microsoft Entra ID device.

## EXAMPLES

### Example 1

```powershell
Connect-Entra -Scopes 'Device.ReadWrite.All'
$DeviceId = (Get-EntraDevice -top 1).ObjectId
$UserObjectId = (Get-EntraUser -Top 1).ObjectId
Add-EntraDeviceRegisteredOwner -ObjectId $DeviceId -RefObjectId $UserObjectId
```

This examples shows how to add a registered owner to a device.

`-ObjectId` - specifies the unique identifier (Object ID) of the device to which you want to add a registered owner. The $DeviceId variable should contain the Object ID of the device.

`-RefObjectId` - specifies the unique identifier (Object ID) of the user who will be added as a registered owner of the device. The $UserObjectId variable should contain the Object ID of the user.

## PARAMETERS

### -ObjectId

Specifies the object ID.

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

### -RefObjectId

Specifies the ID of the Active Directory object to add.

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

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraDeviceRegisteredOwner](Get-EntraDeviceRegisteredOwner.md)

[Remove-EntraDeviceRegisteredOwner](Remove-EntraDeviceRegisteredOwner.md)
