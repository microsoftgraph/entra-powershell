---
author: msewaweru
description: This article provides details on the Get-EntraBetaDirectorySetting command.
external help file: Microsoft.Entra.Beta.DirectoryManagement-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.Beta.DirectoryManagement
ms.author: eunicewaweru
ms.date: 07/17/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta.DirectoryManagement/Get-EntraBetaDirectorySetting
schema: 2.0.0
title: Get-EntraBetaDirectorySetting
---

# Get-EntraBetaDirectorySetting

## SYNOPSIS

Gets a directory setting.

## SYNTAX

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

## DESCRIPTION

The `Get-EntraBetaDirectorySetting` cmdlet gets a directory setting from Microsoft Entra ID. Specify `Id` parameter to get a directory setting.

In delegated scenarios with work or school accounts, the signed-in user must be assigned a supported [Microsoft Entra role](https://learn.microsoft.com/entra/identity/role-based-access-control/permissions-reference) or a custom role with a supported role permission. The following least privileged roles are supported:

- Microsoft Entra Joined Device Local Administrator (Read basic properties on setting templates and settings)
- Directory Readers (Read basic properties on setting templates and settings)
- Global Reader (Read basic properties on setting templates and settings)
- Groups Administrator (Manage all group settings)
- Directory Writers (Manage all group settings)
- Authentication Policy Administrator (Update Password Rule Settings)
- User Administrator (Read basic properties on setting templates and settings)

## EXAMPLES

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

This example gets top two directory setting. You can use `-Limit` as an alias for `-Top`.

## PARAMETERS

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
Aliases: Limit

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

[New-EntraBetaDirectorySetting](New-EntraBetaDirectorySetting.md)

[Remove-EntraBetaDirectorySetting](Remove-EntraBetaDirectorySetting.md)

[Set-EntraBetaDirectorySetting](Set-EntraBetaDirectorySetting.md)
