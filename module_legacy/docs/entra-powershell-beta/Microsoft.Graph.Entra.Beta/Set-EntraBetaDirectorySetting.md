---
title: Set-EntraBetaDirectorySetting
description: This article provides details on the Set-EntraBetaDirectorySetting command.


ms.topic: reference
ms.date: 08/05/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: mwongerapk
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Set-EntraBetaDirectorySetting

schema: 2.0.0
---

# Set-EntraBetaDirectorySetting

## Synopsis

Updates a directory setting in Microsoft Entra ID.

## Syntax

```powershell
Set-EntraBetaDirectorySetting
 -DirectorySetting <DirectorySetting>
 -Id <String>
 [<CommonParameters>]
```

## Description

The `Set-EntraBetaDirectorySetting` cmdlet updates a directory setting in Microsoft Entra ID.

## Examples

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

## Parameters

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

## Inputs

## Outputs

## Notes

## Related Links

[Get-EntraBetaDirectorySetting](Get-EntraBetaDirectorySetting.md)

[New-EntraBetaDirectorySetting](New-EntraBetaDirectorySetting.md)

[Remove-EntraBetaDirectorySetting](Remove-EntraBetaDirectorySetting.md)
