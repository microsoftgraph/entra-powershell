---
title: Get-EntraUserRegisteredDevice.
description: This article provides details on the Get-EntraUserRegisteredDevice command.

ms.service: entra
ms.topic: reference
ms.date: 03/20/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraUserRegisteredDevice

## SYNOPSIS
Get devices registered by a user.

## SYNTAX

```powershell
Get-EntraUserRegisteredDevice
 -ObjectId <String>
 [-All]
 [-Top <Int32>]
 [<CommonParameters>]
```

## DESCRIPTION
The Get-EntraUserRegisteredDevice cmdlet gets devices registered by a user in Microsoft Entra ID.

## EXAMPLES

### Example 1: Get registered devices
```Powershell
PS C:\>Get-EntraUserRegisteredDevice -ObjectId  "67fa640a-b3fd-4e71-ace2-0e3eca798d9a"
```
```Output
Id                                   DeletedDateTime
--                                   ---------------
f3498322-cb19-4607-af4e-7f30b361dccc
1a27311c-97cb-4dc9-bff4-e56aa9968838
```
This command gets the devices that are registered to the specified user.

### Example 2: Get all registered devices
```Powershell
PS C:\>Get-EntraUserRegisteredDevice -ObjectId  "67fa640a-b3fd-4e71-ace2-0e3eca798d9a" -All 
```
```Output
Id                                   DeletedDateTime
--                                   ---------------
f3498322-cb19-4607-af4e-7f30b361dccc
1a27311c-97cb-4dc9-bff4-e56aa9968838
```
This command gets all the devices that are registered to the specified user.


### Example 3: Get two registered devices
```Powershell
PS C:\>Get-EntraUserRegisteredDevice -ObjectId  "67fa640a-b3fd-4e71-ace2-0e3eca798d9a" -Top 2
```
```Output
Id                                   DeletedDateTime
--                                   ---------------
f3498322-cb19-4607-af4e-7f30b361dccc
1a27311c-97cb-4dc9-bff4-e56aa9968838
```
This command gets the top two devices that are registered to the specified user.

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
Specifies the ID of a user (as a User Principle Name or ObjectId) in Microsoft Entra ID.

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
Specifies The maximum number of records to return.

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