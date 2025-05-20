---
title: Get-EntraObjectSetting
description: This article provides details on the Get-EntraObjectSetting command.


ms.topic: reference
ms.date: 07/03/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Get-EntraObjectSetting
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

The `Get-EntraObjectSetting` cmdlet retrieves an object setting from Microsoft Entra ID.

## Examples

### Example 1: Retrieve object setting from Microsoft Entra ID

```powershell
Connect-Entra -Scopes 'Directory.Read.All'
$params = @{
    TargetType = 'Groups'
    TargetObjectId = 'aaaaaaaa-1111-1111-1111-000000000000'
}
Get-EntraObjectSetting @params
```

```Output
Id                                   DisplayName         TemplateId
--                                   -----------         ----------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb Group.Unified.Guest 22cc22cc-dd33-ee44-ff55-66aa66aa66aa
```

This command retrieves  object setting from Microsoft Entra ID.

- `-TargetType` Parameter specifies the target type.
- `-TargetObjectId` Parameter specifies the ID of the target object.

### Example 2: Retrieve a specific object setting from Microsoft Entra ID

```powershell
Connect-Entra -Scopes 'Directory.Read.All'
$params = @{
    TargetType = 'Groups'
    TargetObjectId = 'aaaaaaaa-1111-1111-1111-000000000000'
    Id ='aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'
}
Get-EntraObjectSetting @params
```

```Output
Id                                   DisplayName         TemplateId
--                                   -----------         ----------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb Group.Unified.Guest 22cc22cc-dd33-ee44-ff55-66aa66aa66aa
```

This command retrieves Specific object setting from Microsoft Entra ID.

- `-TargetType` Parameter specifies the target type.
- `-TargetObjectId` Parameter specifies the ID of the target object.
- `-Id` Parameter specifies the ID of a settings object.

### Example 3: Retrieve top one object setting from Microsoft Entra ID

```powershell
Connect-Entra -Scopes 'Directory.Read.All'
$params = @{
    TargetType = 'Groups'
    TargetObjectId = 'aaaaaaaa-1111-1111-1111-000000000000'
}
Get-EntraObjectSetting @params -Top 1
```

```Output
Id                                   DisplayName         TemplateId
--                                   -----------         ----------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb Group.Unified.Guest 22cc22cc-dd33-ee44-ff55-66aa66aa66aa
```

This command retrieves top one object setting from Microsoft Entra ID.

- `-TargetType` Parameter specifies the target type.
- `-TargetObjectId` Parameter specifies the ID of the target object.

### Example 4: Retrieve all object setting from Microsoft Entra ID

```powershell
Connect-Entra -Scopes 'Directory.Read.All'
$params = @{
    TargetType = 'Groups'
    TargetObjectId = 'aaaaaaaa-1111-1111-1111-000000000000'
}
Get-EntraObjectSetting @params -All
```

```Output
Id                                   DisplayName         TemplateId
--                                   -----------         ----------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb Group.Unified.Guest 22cc22cc-dd33-ee44-ff55-66aa66aa66aa
```

This command retrieves all records of object setting from Microsoft Entra ID.

- `-TargetType` Parameter specifies the target type.
- `-TargetObjectId` Parameter specifies the ID of the target object.

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

### -Property

Specifies properties to be returned.

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
