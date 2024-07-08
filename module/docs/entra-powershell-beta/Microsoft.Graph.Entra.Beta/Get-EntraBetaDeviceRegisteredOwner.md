---
title: Get-EntraBetaDeviceRegisteredOwner
description: This article provides details on the Get-EntraBetaDeviceRegisteredOwner command.

ms.service: active-directory
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

# Get-EntraBetaDeviceRegisteredOwner

## Synopsis
Gets the registered owner of a device.

## Syntax

```powershell
Get-EntraBetaDeviceRegisteredOwner 
    -ObjectId <String> 
    [-All] 
    [-Top <Int32>] 
 [<CommonParameters>]
```

## Description
The Get-EntraBetaDeviceRegisteredOwner cmdlet gets the registered owner of a device in Microsoft Entra ID.

## Examples

### Example 1: Retrieve the registered owner of a device
```powershell
PS C:\> $DevId = (Get-EntraBetaDevice -Top 1).ObjectId
PS C:\> Get-EntraBetaDeviceRegisteredOwner -ObjectId $DevId
```

```output
ObjectId                             DisplayName     UserPrincipalName     UserType
--------                             -----------    -----------------      --------
412be9d1-1460-4061-8eed-cca203fcb215 Mary kom       mary@contoso.com       Member
```

The first command gets the object ID of a device by using the [Get-EntraBetaDevice](./Get-EntraBetaDevice.md) cmdlet, and then stores it in the $DevId variable.  

The second command gets the registered owner of the device in $DevId.

### Example 2: Retrieve the registered owner of a device
```powershell
PS C:\> Get-EntraBetaDeviceRegisteredOwner -ObjectId 8542ebd1-3d49-4073-9dce-30f197c67755
```

```output
ObjectId                             DisplayName     UserPrincipalName     UserType
--------                             -----------    -----------------      --------
412be9d1-1460-4061-8eed-cca203fcb215 Mary kom       mary@contoso.com       Member
fd560167-ff1f-471a-8d74-3b0070abcea1 Peter Adams    peter@contoso.com      Member
```

This command gets the registered owner of a device.

### Example 3: Retrieve all the registered owners of a device
```powershell
PS C:\> Get-EntraBetaDeviceRegisteredOwner -ObjectId 8542ebd1-3d49-4073-9dce-30f197c67755 -All
```

```output
ObjectId                             DisplayName     UserPrincipalName     UserType
--------                             -----------    -----------------      --------
412be9d1-1460-4061-8eed-cca203fcb215 Mary kom       mary@contoso.com       Member
fd560167-ff1f-471a-8d74-3b0070abcea1 Peter Adams    peter@contoso.com      Member
```

This command retrieves all the registered owners of a device.

### Example 4: Retrieve top one registered owner of a device
```powershell
PS C:\> Get-EntraBetaDeviceRegisteredOwner -ObjectId 8542ebd1-3d49-4073-9dce-30f197c67755 -Top 1
```

```output
ObjectId                             DisplayName     UserPrincipalName     UserType
--------                             -----------    -----------------      --------
412be9d1-1460-4061-8eed-cca203fcb215 Mary kom       mary@contoso.com       Member
```

This command retrieves top one registered owner of a device.

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

## Related Links

[Add-EntraBetaDeviceRegisteredOwner](Add-EntraBetaDeviceRegisteredOwner.md)

[Get-EntraBetaDevice](Get-EntraBetaDevice.md)

[Remove-EntraBetaDeviceRegisteredOwner](Remove-EntraBetaDeviceRegisteredOwner.md)