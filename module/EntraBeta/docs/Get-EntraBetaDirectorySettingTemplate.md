---
title: Get-EntraBetaDirectorySettingTemplate.
description: This article provides details on the Get-EntraBetaDirectorySettingTemplate command.

ms.service: active-directory
ms.topic: reference
ms.date: 10/25/2023
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Get-EntraBetaDirectorySettingTemplate

## SYNOPSIS
Gets a directory setting template.

## SYNTAX

### GetQuery (Default)
```
Get-EntraBetaDirectorySettingTemplate 
 [-InformationAction <ActionPreference>] 
 [-InformationVariable <String>]
 [<CommonParameters>]
```

### GetById
```
Get-EntraBetaDirectorySettingTemplate 
 -Id <String> 
 [-InformationAction <ActionPreference>]
 [-InformationVariable <String>] 
 [<CommonParameters>]
```

## DESCRIPTION
The Get-EntraBetaDirectorySettingTemplate cmdlet gets a directory setting template from Microsoft Entra ID.

## EXAMPLES

### Example 1: Get all templates
```
PS C:\> Get-EntraBetaDirectorySettingTemplate

Id                                   DisplayName                          Description
--                                   -----------                          -----------
08d542b9-071f-4e16-94b0-74abb372e3d9 Group.Unified.Guest                  Settings for a specific Unified Group
4bc7f740-180e-4586-adb6-38b2e9024e6b Application                          ...
5cf42378-d67d-4f36-ba46-e8b86229381d Password Rule Settings               ...
62375ab9-6b52-47ed-826b-58e47e0e304b Group.Unified                        ...
80661d51-be2f-4d46-9713-98a2fcaec5bc Prohibited Names Settings            ...
898f1161-d651-43d1-805c-3b0b388a9fc2 Custom Policy Settings               ...
aad3907d-1d1a-448b-b3ef-7bf7f63db63b Prohibited Names Restricted Settings ...
dffd5d46-495d-40a9-8e21-954ff55e198a Consent Policy Settings              ...
```

This command gets all directory setting templates.

### Example 2: Get template by Id
```
PS C:\> Get-EntraBetaDirectorySettingTemplate -Id 4bc7f740-180e-4586-adb6-38b2e9024e6b

Id                                   DisplayName Description
--                                   ----------- -----------
4bc7f740-180e-4586-adb6-38b2e9024e6b Application ...
```

This command gets the specific directory setting template.

## PARAMETERS

### -InformationAction
Specifies how this cmdlet responds to an information event.
The acceptable values for this parameter are:

- Continue
- Ignore
- Inquire
- SilentlyContinue
- Stop
- Suspend

```yaml
Type: ActionPreference
Parameter Sets: (All)
Aliases: infa

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InformationVariable
Specifies an information variable.

```yaml
Type: String
Parameter Sets: (All)
Aliases: iv

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Id
The ID of the settings template you want to retrieve

```yaml
Type: String
Parameter Sets: GetById
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
