---
title: Add-EntraBetaDeviceRegisteredUser
description: This article provides details on the Add-EntraBetaDeviceRegisteredUser command.

ms.service: active-directory
ms.topic: reference
ms.date: 02/28/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Add-EntraBetaDeviceRegisteredUser

## SYNOPSIS
Adds a registered user for a device.

## SYNTAX

```powershell
Add-EntraBetaDeviceRegisteredUser 
    -ObjectId <String> 
    -RefObjectId <String> 
    [<CommonParameters>]
```

## DESCRIPTION
The **Add-EntraBetaDeviceRegisteredUser** cmdlet adds a registered user for a Microsoft Entra ID device.

## EXAMPLES

### Example 1: Add a user as a registered user
```powershell
PS C:\> $User = Get-EntraBetaUser -Top 1
PS C:\> $Device = Get-EntraBetaDevice -Top 1
PS C:\> Add-EntraBetaDeviceRegisteredUser -ObjectId $Device.ObjectId -RefObjectId $User.ObjectId
```

The first command gets a user by using the [Get-EntraBetaUser](./Get-EntraBetaUser.md) cmdlet, and then stores it in the $User variable.  

The second command gets a device by using the [Get-EntraBetaDevice](./Get-EntraBetaDevice.md) cmdlet, and then stores it in the $Device variable.  

The final command adds the user in $User as the registered user for the device in $Device. 

Both parameters use the ObjectId property of specified object.

## PARAMETERS

### -ObjectId
Specifies the ID of the device.

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
Specifies the ID of the user.

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

[Get-EntraBetaDevice](Get-EntraBetaDevice.md)

[Get-EntraBetaDeviceRegisteredUser](Get-EntraBetaDeviceRegisteredUser.md)

[Get-EntraBetaUser](Get-EntraBetaUser.md)

[Remove-EntraBetaDeviceRegisteredUser](Remove-EntraBetaDeviceRegisteredUser.md)

