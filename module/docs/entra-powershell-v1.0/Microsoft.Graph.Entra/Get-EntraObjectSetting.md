---
title: Get-EntraObjectSetting.
description: This article provides details on the Get-EntraObjectSetting command.
ms.service: entra
ms.topic: reference
ms.date: 07/03/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraObjectSetting

## Synopsis

Gets an object setting.

## Syntax

### GetQuery (Default)

```powershell
Get-EntraObjectSetting 
 [-Top <Int32>] 
 [-All] 
 -TargetType <String> 
 -TargetObjectId <String>
 [<CommonParameters>]
```

### GetById

```powershell
Get-EntraObjectSetting 
 -Id <String> [-All] 
 -TargetType <String> 
 -TargetObjectId <String>
 [<CommonParameters>]
```

## Description

The `Get-EntraObjectSetting` cmdlet gets an object setting from Microsoft Entra ID. Specify `TargetType` and `TargetObjectId` parameter to get an object setting

## Examples

### Example 1: Get an object setting

```powershell
 Get-EntraObjectSetting -TargetType 'Groups' -TargetObjectId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'
```

```Output
id                                   templateId                           displayName         values
--                                   ----------                           -----------         ------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb bbbbcccc-1111-dddd-2222-eeee3333ffff Group.Unified.Guest {@{name=AllowToAddGuests; value=false}}
```

This command gets an object setting.

### Example 2: Get an object setting with ID parameter

```powershell
 Get-EntraObjectSetting -TargetType 'Groups' -TargetObjectId 'eeeeeeee-4444-5555-6666-ffffffffffff' -Id 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'
```

```Output
id                                   templateId                           displayName         values
--                                   ----------                           -----------         ------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb bbbbcccc-1111-dddd-2222-eeee3333ffff Group.Unified.Guest {@{name=AllowToAddGuests; value=false}}
```

This command gets an object setting with ID parameter.

### Example 3: Get a top one object setting

```powershell
 Get-EntraObjectSetting -TargetType 'Groups' -TargetObjectId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb' -Top 1
```

```Output
id                                   templateId                           displayName         values
--                                   ----------                           -----------         ------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb bbbbcccc-1111-dddd-2222-eeee3333ffff Group.Unified.Guest {@{name=AllowToAddGuests; value=false}}
```

This command gets a top one object setting.

### Example 4: Get an all object setting

```powershell
 Get-EntraObjectSetting -TargetType 'Groups' -TargetObjectId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb' -All
```

```Output
id                                   templateId                           displayName         values
--                                   ----------                           -----------         ------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb bbbbcccc-1111-dddd-2222-eeee3333ffff Group.Unified.Guest {@{name=AllowToAddGuests; value=false}}
```

This command gets an all object setting.

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

### -Id

Specifies the ID of a settings object.

```yaml
Type: System.String
Parameter Sets: GetById
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -TargetObjectId

Specifies the ID of the target object.

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

### -TargetType

Specifies the target type.

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

### -Top

Specifies the maximum number of records to return.

```yaml
Type: System.Int32
Parameter Sets: GetQuery
Aliases:

Required: False
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
