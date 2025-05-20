---
title: Get-EntraUserRegisteredDevice
description: This article provides details on the Get-EntraUserRegisteredDevice command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Get-EntraUserRegisteredDevice

schema: 2.0.0
---

# Get-EntraUserRegisteredDevice

## Synopsis

Get devices registered by a user.

## Syntax

```powershell
Get-EntraUserRegisteredDevice
 -UserId <String>
 [-All]
 [-Top <Int32>]
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

The `Get-EntraUserRegisteredDevice` cmdlet gets devices registered by a user in Microsoft Entra ID.

## Examples

### Example 1: Get registered devices

```Powershell
Connect-Entra -Scopes 'User.Read.All'
Get-EntraUserRegisteredDevice -UserId 'SawyerM@contoso.com'
```

```Output
Id                                   DeletedDateTime
--                                   ---------------
00aa00aa-bb11-cc22-dd33-44ee44ee44ee
11bb11bb-cc22-dd33-ee44-55ff55ff55ff
```

This command gets the devices that are registered to the specified user.

### Example 2: Get all registered devices

```Powershell
Connect-Entra -Scopes 'User.Read.All'
Get-EntraUserRegisteredDevice -UserId 'SawyerM@contoso.com' -All 
```

```Output
Id                                   DeletedDateTime
--                                   ---------------
00aa00aa-bb11-cc22-dd33-44ee44ee44ee
11bb11bb-cc22-dd33-ee44-55ff55ff55ff
```

This command gets all the devices that are registered to the specified user.

### Example 3: Get one registered device

```Powershell
Connect-Entra -Scopes 'User.Read.All'
Get-EntraUserRegisteredDevice -UserId 'SawyerM@contoso.com' -Top 1
```

```Output
Id                                   DeletedDateTime
--                                   ---------------
00aa00aa-bb11-cc22-dd33-44ee44ee44ee
```

This command gets the top one device that are registered to the specified user.

## Parameters

### -All

List all pages.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -UserId

Specifies the ID of a user (as a User Principal Name or UserId) in Microsoft Entra ID.

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

### -Top

Specifies The maximum number of records to return.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Property

Specifies properties to be returned

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related links
