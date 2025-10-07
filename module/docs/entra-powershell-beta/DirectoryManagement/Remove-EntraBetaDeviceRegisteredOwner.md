---
author: msewaweru
description: This article provides details on the Remove-EntraBetaDeviceRegisteredOwner command.
external help file: Microsoft.Entra.Beta.DirectoryManagement-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.Beta.DirectoryManagement
ms.author: eunicewaweru
ms.date: 02/05/2025
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta.DirectoryManagement/Remove-EntraBetaDeviceRegisteredOwner
schema: 2.0.0
title: Remove-EntraBetaDeviceRegisteredOwner
---

# Remove-EntraBetaDeviceRegisteredOwner

## SYNOPSIS

Removes the registered owner of a device.

## SYNTAX

```powershell
Remove-EntraBetaDeviceRegisteredOwner
 -OwnerId <String>
 -DeviceId <String>
 [<CommonParameters>]
```

## DESCRIPTION

The `Remove-EntraBetaDeviceRegisteredOwner` cmdlet removes the registered owner of a device in Microsoft Entra ID.

In delegated scenarios involving work or school accounts, the signed-in user must have a supported Microsoft Entra role or a custom role with the required permissions. The following least privileged roles are supported for this operation:

- Intune Administrator
- Windows 365 Administrator

## EXAMPLES

### Example 1: Remove an owner from a device

```powershell
Connect-Entra -Scopes 'Directory.AccessAsUser.All'
$device = Get-EntraBetaDevice -Filter "DisplayName eq 'Woodgrove Desktop'"
$owner = Get-EntraBetaDeviceRegisteredOwner -DeviceId $device.Id | Where-Object {$_.userPrincipalName -eq 'parker@contoso.com'}
Remove-EntraBetaDeviceRegisteredOwner -DeviceId $device.Id -OwnerId $owner.Id
```

This examples shows how to remove the owner of a device.

## PARAMETERS

### -DeviceId

Specifies an object ID.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: ObjectId

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

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Add-EntraBetaDeviceRegisteredOwner](Add-EntraBetaDeviceRegisteredOwner.md)

[Get-EntraBetaDevice](Get-EntraBetaDevice.md)

[Get-EntraBetaDeviceRegisteredOwner](Get-EntraBetaDeviceRegisteredOwner.md)
