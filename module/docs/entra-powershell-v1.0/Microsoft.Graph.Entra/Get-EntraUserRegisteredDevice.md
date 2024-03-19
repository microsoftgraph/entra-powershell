---
title: Get-EntraUserRegisteredDevice.
description: This article provides details on the Get-EntraUserRegisteredDevice command.

ms.service: active-directory
ms.topic: reference
ms.date: 11/10/2023
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

```
Get-EntraUserRegisteredDevice
 -ObjectId <String>
 [-All <Boolean>]
 [-Top <Int32>]
 [<CommonParameters>]
```

## DESCRIPTION
The Get-EntraUserRegisteredDevice cmdlet gets devices registered by a user in Microsoft Entra ID.

## EXAMPLES

### Example 1: Get registered devices
```powershell
PS C:\>Get-EntraUserRegisteredDevice -ObjectId  "df19e8e6-2ad7-453e-87f5-037f6529ae16"
```
```output
Id                                   DeletedDateTime
--                                   ---------------
f3498322-cb19-4607-af4e-7f30b361dccc
1a27311c-97cb-4dc9-bff4-e56aa9968838
```

This example demonstrates how to retrieve devices registered by a user in Microsoft Entra ID.  
This command gets the devices that are registered to the specified user.

### Example 2: Get all registered devices
```powershell
PS C:\>Get-EntraUserRegisteredDevice -ObjectId  "df19e8e6-2ad7-453e-87f5-037f6529ae16" -All $true
```
```output
Id                                   DeletedDateTime
--                                   ---------------
f3498322-cb19-4607-af4e-7f30b361dccc
1a27311c-97cb-4dc9-bff4-e56aa9968838
```

This example demonstrates how to retrieve all devices registered by a user in Microsoft Entra ID.  
This command gets all the devices that are registered to the specified user.

### Example 3: Get top one registered device
```powershell
PS C:\>Get-EntraUserRegisteredDevice -ObjectId  "df19e8e6-2ad7-453e-87f5-037f6529ae16" -Top 1
```
```output
Id                                   DeletedDateTime
--                                   ---------------
f3498322-cb19-4607-af4e-7f30b361dccc
```

This example demonstrates how to retrieve top one device registered by a user in Microsoft Entra ID.  
This command gets the top one device that is registered to the specified user.

## PARAMETERS

### -All
If true, return all devices for this user.
If false, return the number of objects specified by the Top parameter.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -ObjectId
Specifies the ID of a user (as a UserPrincipalName or ObjectId) in Microsoft Entra ID.

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
