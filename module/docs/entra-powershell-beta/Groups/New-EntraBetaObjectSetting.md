---
author: msewaweru
description: This article provides details on the New-EntraBetaObjectSetting command.
external help file: Microsoft.Entra.Beta.Groups-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 08/05/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/New-EntraBetaObjectSetting
schema: 2.0.0
title: New-EntraBetaObjectSetting
---

# New-EntraBetaObjectSetting

## Synopsis

Creates a settings object.

## Syntax

```powershell
New-EntraBetaObjectSetting
 -DirectorySetting <DirectorySetting>
 -TargetType <String>
 -TargetObjectId <String>
 [<CommonParameters>]
```

## Description

The `New-EntraBetaObjectSetting` cmdlet creates a settings object in Microsoft Entra ID.

## Examples

### Example 1: Creates a settings object

```powershell
Connect-Entra -Scopes 'Directory.ReadWrite.All'
$template = Get-EntraBetaDirectorySettingTemplate | Where-Object { $_.displayname -eq 'Group.Unified.Guest' }
$setting = $template.CreateDirectorySetting()
$setting['AllowToAddGuests'] = $False
$group = Get-EntraBetaGroup -Filter "DisplayName eq 'Sales and Marketing'"
New-EntraBetaObjectSetting -TargetType 'Groups' -TargetObjectId $group.Id -DirectorySetting $setting
```

```Output
Id                                   DisplayName TemplateId
--                                   ----------- ----------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb             22cc22cc-dd33-ee44-ff55-66aa66aa66aa
```

This command creates a new settings object.

- `-TargetType` Parameter specifies the type of the directory object.
- `-TargetObjectId` Parameter specifies the ID of directory object to which to assign settings.
- `-DirectorySetting` Parameter Create a new setting using templates from `DirectorySettingTemplates`

## Parameters

### -DirectorySetting

Specifies the new settings.

```yaml
Type: DirectorySetting
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -TargetObjectId

Specifies the ID of directory object to which to assign settings.

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

Specifies the type of the directory object to which to assign settings.

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

## Related links

[Get-EntraBetaObjectSetting](Get-EntraBetaObjectSetting.md)

[Remove-EntraBetaObjectSetting](Remove-EntraBetaObjectSetting.md)

[Set-EntraBetaObjectSetting](Set-EntraBetaObjectSetting.md)
