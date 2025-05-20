---
title: Get-EntraBetaDirectorySetting
description: This article provides details on the Get-EntraBetaDirectorySetting command.

ms.topic: reference
ms.date: 07/17/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Get-EntraBetaDirectorySetting

schema: 2.0.0
---

# Get-EntraBetaDirectorySetting

## Synopsis

Gets a directory setting.

## Syntax

### GetQuery (Default)

```powershell
Get-EntraBetaDirectorySetting
 [-All]
 [-Top <Int32>]
 [-Property <String[]>]
 [<CommonParameters>]
```

### GetById

```powershell
Get-EntraBetaDirectorySetting
 -Id <String>
 [-All]
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

The `Get-EntraBetaDirectorySetting` cmdlet gets a directory setting from Microsoft Entra ID. Specify `Id` parameter to get a directory setting.

In delegated scenarios with work or school accounts, the signed-in user must be assigned a supported [Microsoft Entra role](https://learn.microsoft.com/entra/identity/role-based-access-control/permissions-reference) or a custom role with a supported role permission. The following least privileged roles are supported:

- Microsoft Entra Joined Device Local Administrator (Read basic properties on setting templates and settings)
- Directory Readers (Read basic properties on setting templates and settings)
- Global Reader (Read basic properties on setting templates and settings)
- Groups Administrator (Manage all group settings)
- Directory Writers (Manage all group settings)
- Authentication Policy Administrator (Update Password Rule Settings)
- User Administrator (Read basic properties on setting templates and settings)

## Examples

### Example 1: Get a directory setting

```powershell
Connect-Entra -Scopes 'Directory.ReadWrite.All, Group.Read.All, Group.ReadWrite.All'
Get-EntraBetaDirectorySetting -Id 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'
```

```Output
Id                                   DisplayName            TemplateId
--                                   -----------            ----------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb Application            00001111-aaaa-2222-bbbb-3333cccc4444
```

This example gets a directory setting.

- `-Id` parameter specifies the ID of a directory.

### Example 2: Get all directory setting

```powershell
Connect-Entra -Scopes 'Directory.ReadWrite.All, Group.Read.All, Group.ReadWrite.All'
Get-EntraBetaDirectorySetting -All
```

```Output
Id                                   DisplayName            TemplateId
--                                   -----------            ----------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb Application            00001111-aaaa-2222-bbbb-3333cccc4444
bbbbbbbb-1111-2222-3333-cccccccccccc Password Rule Settings 11112222-bbbb-3333-cccc-4444dddd5555
```

This example gets all directory setting.

### Example 3: Get top n directory setting

```powershell
Connect-Entra -Scopes 'Directory.ReadWrite.All, Group.Read.All, Group.ReadWrite.All'
Get-EntraBetaDirectorySetting -Top 2
```

```Output
Id                                   DisplayName            TemplateId
--                                   -----------            ----------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb Application            00001111-aaaa-2222-bbbb-3333cccc4444
bbbbbbbb-1111-2222-3333-cccccccccccc Password Rule Settings 11112222-bbbb-3333-cccc-4444dddd5555
```

This example gets top two directory setting.

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

Specifies the ID of a directory in Microsoft Entra ID.

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

Specifies properties to be returned

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

[New-EntraBetaDirectorySetting](New-EntraBetaDirectorySetting.md)

[Remove-EntraBetaDirectorySetting](Remove-EntraBetaDirectorySetting.md)

[Set-EntraBetaDirectorySetting](Set-EntraBetaDirectorySetting.md)
