---
title: Remove-EntraDevice
description: This article provides details on the Remove-EntraDevice command.

ms.service: entra
ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Remove-EntraDevice

## Synopsis

deletes a device.

## Syntax

```powershell
Remove-EntraDevice 
 -ObjectId <String>
 [<CommonParameters>]
```

## Description

the `Remove-EntraDevice` cmdlet removes a device from Microsoft Entra ID.

## Examples

### Example 1: Remove a device

```powershell
Connect-Entra -Scopes 'Directory.AccessAsUser.All' #Delegated Permission
Connect-Entra -Scopes 'Device.ReadWrite.All' #Application Permission
Remove-EntraDevice -ObjectId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'
```

This command removes the specified device.

## Parameters

### -ObjectId

Specifies the object ID of a device in Microsoft Entra ID.

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

## Inputs

## Outputs

## Notes

## Related Links

[Get-EntraDevice](Get-EntraDevice.md)

[New-EntraDevice](New-EntraDevice.md)

[Set-EntraDevice](Set-EntraDevice.md)
