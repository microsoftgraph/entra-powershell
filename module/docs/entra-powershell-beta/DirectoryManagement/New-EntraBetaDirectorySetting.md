---
author: msewaweru
description: This article provides details on the New-EntraBetaDirectorySetting command.
external help file: Microsoft.Entra.Beta.DirectoryManagement-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.Beta.DirectoryManagement
ms.author: eunicewaweru
ms.date: 07/29/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta.DirectoryManagement/New-EntraBetaDirectorySetting
schema: 2.0.0
title: New-EntraBetaDirectorySetting
---

# New-EntraBetaDirectorySetting

## SYNOPSIS

Creates a directory settings object.

## SYNTAX

```powershell
New-EntraBetaDirectorySetting
 -DirectorySetting <DirectorySetting>
 [<CommonParameters>]
```

## DESCRIPTION

The `New-EntraBetaDirectorySetting` cmdlet creates a directory settings object in Microsoft Entra ID.

## EXAMPLES

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

## PARAMETERS

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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraBetaDirectorySetting](Get-EntraBetaDirectorySetting.md)

[Remove-EntraBetaDirectorySetting](Remove-EntraBetaDirectorySetting.md)

[Set-EntraBetaDirectorySetting](Set-EntraBetaDirectorySetting.md)
