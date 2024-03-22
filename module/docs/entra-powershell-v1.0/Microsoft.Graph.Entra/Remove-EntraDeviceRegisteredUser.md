---
title: Remove-EntraDeviceRegisteredUser.
description: This article provides details on the Remove-EntraDeviceRegisteredUser command.

ms.service: active-directory
ms.topic: reference
ms.date: 03/22/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Remove-EntraDeviceRegisteredUser

## SYNOPSIS
Removes a registered user from a device.

## SYNTAX

```
Remove-EntraDeviceRegisteredUser 
-ObjectId <String> 
-UserId <String> 
[<CommonParameters>]
```

## DESCRIPTION
The Remove-EntraDeviceRegisteredUser cmdlet removes a registered user from a Microsoft Entra ID device.

## EXAMPLES

### Example 1: Remove a registered user from a device
```Powershell
PS C:\> $Device = Get-EntraDevice -Top 1
PS C:\> $User = Get-EntraDeviceRegisteredUser -ObjectId $Device.ObjectId
PS C:\> Remove-EntraDeviceRegisteredOwner -ObjectId $Device.ObjectId -OwnerId $Owner.ObjectId
```

This example demonstrates how to remove the registered user from device.  
The first command gets a device by using the Get-EntraDevice (./Get-EntraDevice.md) cmdlet, and then stores it in the $Device variable.  
The second command gets the registered user for the device in $Device by using the Get-EntraDeviceRegisteredUser
(./Get-EntraDeviceRegisteredUser.md) cmdlet.
The command stores it in the $User variable.  
The final command removes the user in $User from the device in $Device.

## PARAMETERS

### -ObjectId
Specifies the ID of an object.

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

### -UserId
Specifies the ID of a user.

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Add-EntraDeviceRegisteredUser](Add-EntraDeviceRegisteredUser.md)
[Get-EntraDeviceRegisteredUser](Get-EntraDeviceRegisteredUser.md)



