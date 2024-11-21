---
title: New-EntraBetaDirectorySetting
description: This article provides details on the New-EntraBetaDirectorySetting command.


ms.topic: reference
ms.date: 07/29/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/New-EntraBetaDirectorySetting

schema: 2.0.0
---

# New-EntraBetaDirectorySetting

## Synopsis

Creates a directory settings object.

## Syntax

```powershell
New-EntraBetaDirectorySetting
 -DirectorySetting <DirectorySetting>
 [<CommonParameters>]
```

## Description

The `New-EntraBetaDirectorySetting` cmdlet creates a directory settings object in Microsoft Entra ID.

## Examples

### Example 1: Creates new settings object

```powershell
Connect-Entra -Scopes 'Directory.ReadWrite.All', 'Group.Read.All' , 'Group.ReadWrite.All'
$TemplateId = (Get-EntraBetaDirectorySettingTemplate | where { $_.DisplayName -eq "Group.Unified" }).Id
$Template = Get-EntraBetaDirectorySettingTemplate | where -Property Id -Value $TemplateId -EQ
$Setting = $Template.CreateDirectorySetting()
$Setting["UsageGuidelinesUrl"] = "https://guideline.example.com"
$Setting["EnableMIPLabels"] = "True"
New-EntraBetaDirectorySetting -DirectorySetting $Setting
```

```Output
Id                                   DisplayName TemplateId
--                                   ----------- ----------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb             00aa00aa-bb11-cc22-dd33-44ee44ee44ee
```

This example Creates new settings object in Microsoft Entra ID.

- `-DirectorySetting` Parameter Create a new setting using templates from `DirectorySettingTemplates`

## Parameters

### -DirectorySetting

Specifies directory settings.

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

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related Links

[Get-EntraBetaDirectorySetting](Get-EntraBetaDirectorySetting.md)

[Remove-EntraBetaDirectorySetting](Remove-EntraBetaDirectorySetting.md)

[Set-EntraBetaDirectorySetting](Set-EntraBetaDirectorySetting.md)
