---
author: msewaweru
description: This article provides details on the Get-EntraBetaDirectorySettingTemplate command.
external help file: Microsoft.Entra.Beta.DirectoryManagement-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.Beta.DirectoryManagement
ms.author: eunicewaweru
ms.date: 07/17/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta.DirectoryManagement/Get-EntraBetaDirectorySettingTemplate
schema: 2.0.0
title: Get-EntraBetaDirectorySettingTemplate
---

# Get-EntraBetaDirectorySettingTemplate

## SYNOPSIS

Gets a directory setting template.

## SYNTAX

### GetQuery (Default)

```powershell
Get-EntraBetaDirectorySettingTemplate
 [-Property <String[]>]
 [<CommonParameters>]
```

### GetById

```powershell
Get-EntraBetaDirectorySettingTemplate
 -Id <String>
 [-Property <String[]>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Get-EntraBetaDirectorySettingTemplate` cmdlet gets a directory setting template from A Microsoft Entra ID. Specify `Id` parameter to get a directory setting template.

## EXAMPLES

### Example 1: Get an all directory setting template

```powershell
Connect-Entra -Scopes 'Directory.ReadWrite.All'
Get-EntraBetaDirectorySettingTemplate
```

```Output
Id                                   DisplayName                          Description
--                                   -----------                          -----------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb Group.Unified.Guest                  Settings for a specific Unified Group
bbbbbbbb-1111-2222-3333-cccccccccccc Application                          ...
cccccccc-2222-3333-4444-dddddddddddd Password Rule Settings               ...
```

This example gets an all directory setting template.

### Example 2: Get a directory setting template

```powershell
Connect-Entra -Scopes 'Directory.ReadWrite.All'
Get-EntraBetaDirectorySettingTemplate -Id 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'
```

```Output
Id                                   DisplayName                          Description
--                                   -----------                          -----------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb Group.Unified.Guest                  Settings for a specific Unified Group
```

This example gets a directory setting template.

- `-Id` parameter specifies the ID of the settings template.

## PARAMETERS

### -Id

The ID of the settings template you want to retrieve.

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

### -Property

Specifies properties to be returned

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases: Select

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
