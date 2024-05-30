---
title: Remove-EntraDeviceRegisteredOwner
description: This article provides details on the Remove-EntraDeviceRegisteredOwner command.

ms.service: active-directory
ms.topic: reference
ms.date: 02/28/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Remove-EntraDeviceRegisteredOwner

## SYNOPSIS

Removes the registered owner of a device.

## SYNTAX

```powershell
Remove-EntraDeviceRegisteredOwner 
 -OwnerId <String> 
 -ObjectId <String> 
 [<CommonParameters>]
```

## DESCRIPTION

The Remove-EntraDeviceRegisteredOwner cmdlet removes the registered owner of a device in Microsoft Entra ID.

## EXAMPLES

### Example 1: Remove an owner from a device

```powershell
Connect-Entra -Scopes 'Directory.AccessAsUser.All'
$Device = Get-EntraDevice -Top 1
$Owner = Get-EntraDeviceRegisteredOwner -ObjectId $Device.ObjectId
Remove-EntraDeviceRegisteredOwner -ObjectId $Device.ObjectId -OwnerId $Owner.ObjectId
```

The first command gets a device by using the [Get-EntraDevice](./Get-EntraDevice.md) cmdlet, and then stores it in the $Device variable.  

The second command gets the registered owner for the device in $Device by using the [Get-EntraDeviceRegisteredOwner](./Get-EntraDeviceRegisteredOwner.md) cmdlet.  

The command stores it in the $Owner variable.  

The final command removes the owner in $Owner from the device in $ Device.

## PARAMETERS

### -ObjectId

Specifies an object ID.

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

### -OwnerId

Specifies an owner ID.

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

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Add-EntraDeviceRegisteredOwner](Add-EntraDeviceRegisteredOwner.md)

[Get-EntraDevice](Get-EntraDevice.md)

[Get-EntraDeviceRegisteredOwner](Get-EntraDeviceRegisteredOwner.md)

