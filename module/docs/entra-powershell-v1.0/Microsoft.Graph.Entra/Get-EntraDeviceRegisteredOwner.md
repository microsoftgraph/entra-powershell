---
title: Get-EntraDeviceRegisteredOwner
description: This article provides details on the Get-EntraDeviceRegisteredOwner command.

ms.service: entra
ms.topic: reference
ms.date: 02/28/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraDeviceRegisteredOwner

## SYNOPSIS
Gets the registered owner of a device.

## SYNTAX

```powershell
Get-EntraDeviceRegisteredOwner 
 -ObjectId <String> 
 [-All] 
 [-Top <Int32>] 
 [<CommonParameters>]
```

## DESCRIPTION
The Get-EntraDeviceRegisteredOwner cmdlet gets the registered owner of a device in Microsoft Entra ID.

## EXAMPLES

### Example 1: Retrieve the registered owner of a device
```powershell
PS C:\> $DevId = (Get-EntraDevice -Top 1).ObjectId
PS C:\> Get-EntraDeviceRegisteredOwner -ObjectId $DevId
```

```output
ObjectId                             DisplayName     UserPrincipalName     UserType
--------                             -----------    -----------------      --------
412be9d1-1460-4061-8eed-cca203fcb215 Mary kom       mary@contoso.com       Member
```

The first command gets the object ID of a device by using the [Get-EntraDevice](./Get-EntraDevice.md) cmdlet, and then stores it in the $DevId variable.  

The second command gets the registered owner of the device in $DevId.

### Example 2: Retrieve the registered owner of a device
```powershell
PS C:\> Get-EntraDeviceRegisteredOwner -ObjectId 8542ebd1-3d49-4073-9dce-30f197c67755
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
PS C:\> Get-EntraDeviceRegisteredOwner -ObjectId 8542ebd1-3d49-4073-9dce-30f197c67755 -All 
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
PS C:\> Get-EntraDeviceRegisteredOwner -ObjectId 8542ebd1-3d49-4073-9dce-30f197c67755 -Top 1
```

```output
ObjectId                             DisplayName     UserPrincipalName     UserType
--------                             -----------    -----------------      --------
412be9d1-1460-4061-8eed-cca203fcb215 Mary kom       mary@contoso.com       Member
```

This command retrieves top one registered owner of a device.

## PARAMETERS

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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Add-EntraDeviceRegisteredOwner](Add-EntraDeviceRegisteredOwner.md)

[Get-EntraDevice](Get-EntraDevice.md)

[Remove-EntraDeviceRegisteredOwner](Remove-EntraDeviceRegisteredOwner.md)