---
title: Add-EntraDeviceRegisteredOwner
description: This article provides details on the Add-EntraDeviceRegisteredOwner command.

ms.service: active-directory
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
The **Add-EntraDeviceRegisteredOwner** cmdlet adds a registered owner for a Microsoft Entra ID device.

## EXAMPLES

### Example 1
```powershell
PS C:\> $DeviceId = (Get-EntraDevice -top 1).ObjectId
PS C:\> $UserObjectId = (Get-EntraUser -Top 1).ObjectId
PS C:\> Add-EntraDeviceRegisteredOwner -ObjectId $DeviceId -RefObjectId $UserObjectId
```

The first command gets a device using [Get-EntraDevice](./Get-EntraDevice.md) cmdlet, and stores 
the ObjectId property value in $DeviceId variable.  

The second command gets a user using [Get-EntraUser](./Get-EntraUser.md) cmdlet, and stores 
the ObjectId property value in $UserObjectId variable.  

This final command adds an owner in $UserObjectId to a device in $DeviceId.  

This command adds an owner to a device.

## PARAMETERS

### -ObjectId
Specifies the object ID.

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

### -RefObjectId
Specifies the ID of the Active Directory object to add.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraDeviceRegisteredOwner](Get-EntraDeviceRegisteredOwner.md)

[Remove-EntraDeviceRegisteredOwner](Remove-EntraDeviceRegisteredOwner.md)

