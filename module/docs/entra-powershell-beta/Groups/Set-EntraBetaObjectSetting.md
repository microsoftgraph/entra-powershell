---
title: Set-EntraBetaObjectSetting
description: This article provides details on the Set-EntraBetaObjectSetting command.


ms.topic: reference
ms.date: 08/13/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Entra.Beta.Groups-Help.xml
Module Name: Microsoft.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Set-EntraBetaObjectSetting

schema: 2.0.0
---

# Set-EntraBetaObjectSetting

## Synopsis

Updates object settings.

## Syntax

```powershell
Set-EntraBetaObjectSetting
 -Id <String>
 -DirectorySetting <DirectorySetting>
 -TargetType <String>
 -TargetObjectId <String>
 [<CommonParameters>]
```

## Description

The `Set-EntraBetaObjectSetting` cmdlet updates the settings for an object in Microsoft Entra ID.

## Examples

### Example 1: Updates the settings

```powershell
Connect-Entra -Scopes 'Directory.ReadWrite.All'
$template= Get-EntraBetaDirectorySettingTemplate | ? {$_.displayname -eq "Group.Unified.Guest"}
$settingsCopy = $template.CreateDirectorySetting()
$settingsCopy["AllowToAddGuests"]=$True
$params = @{
    TargetType = 'groups'
    TargetObjectId = '22cc22cc-dd33-ee44-ff55-66aa66aa66aa'
    DirectorySetting = $settingsCopy
    Id = 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb' 
}
Set-EntraBetaObjectSetting @params
```

This command updated the settings object.

- `-TargetType` Parameter specifies the type of the directory object.
- `-TargetObjectId` Parameter specifies the ID of directory object to which to assign settings.
- `-DirectorySetting` Parameter Create a new setting using templates from `DirectorySettingTemplates`
- `-Id` Parameter specifies the ID of a settings object.

## Parameters

### -DirectorySetting

Specifies a DirectorySetting object.

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

### -Id

Specifies the ID of a settings object.

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

### -TargetObjectId

Specifies the object ID of directory object.

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

Specifies the target type of a directory object.

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

[New-EntraBetaObjectSetting](New-EntraBetaObjectSetting.md)

[Remove-EntraBetaObjectSetting](Remove-EntraBetaObjectSetting.md)
