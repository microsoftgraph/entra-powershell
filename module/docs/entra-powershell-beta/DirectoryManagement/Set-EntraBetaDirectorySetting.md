---
author: msewaweru
description: This article provides details on the Set-EntraBetaDirectorySetting command.
external help file: Microsoft.Entra.Beta.DirectoryManagement-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.Beta.DirectoryManagement
ms.author: eunicewaweru
ms.date: 08/05/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta.DirectoryManagement/Set-EntraBetaDirectorySetting
schema: 2.0.0
title: Set-EntraBetaDirectorySetting
---

# Set-EntraBetaDirectorySetting

## SYNOPSIS

Updates a directory setting in Microsoft Entra ID.

## SYNTAX

```powershell
Set-EntraBetaDirectorySetting
 -DirectorySetting <DirectorySetting>
 -Id <String>
 [<CommonParameters>]
```

## DESCRIPTION

The `Set-EntraBetaDirectorySetting` cmdlet updates a directory setting in Microsoft Entra ID.

## EXAMPLES

### Example 1: updates a directory setting

```powershell
Connect-Entra -Scopes 'Directory.ReadWrite.All', 'Policy.ReadWrite.Authorization'
$TemplateId = (Get-EntraBetaDirectorySettingTemplate | where { $_.DisplayName -eq 'Group.Unified' }).Id
$Template = Get-EntraBetaDirectorySettingTemplate | where -Property Id -Value $TemplateId -EQ
$Setting = $Template.CreateDirectorySetting()
$Setting["EnableMIPLabels"] = 'False'
$params = @{
    Id = 'aaaaaaaa-1111-1111-1111-000000000000'
    DirectorySetting = $Setting
}
Set-EntraBetaDirectorySetting @params
```

This example updates directory settings object in Microsoft Entra ID.

- `-DirectorySetting` Parameter updates the property of directory settings.
- `-Id` Parameter specifies the ID of a setting object

## PARAMETERS

### -DirectorySetting

Specifies the directory settings.

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

Specifies the ID of a settings object in Microsoft Entra ID.

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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraBetaDirectorySetting](Get-EntraBetaDirectorySetting.md)

[New-EntraBetaDirectorySetting](New-EntraBetaDirectorySetting.md)

[Remove-EntraBetaDirectorySetting](Remove-EntraBetaDirectorySetting.md)
