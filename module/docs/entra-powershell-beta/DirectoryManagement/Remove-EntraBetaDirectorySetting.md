---
author: msewaweru
description: This article provides details on the Remove-EntraBetaDirectorySetting command.
external help file: Microsoft.Entra.Beta.DirectoryManagement-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 07/29/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Remove-EntraBetaDirectorySetting
schema: 2.0.0
title: Remove-EntraBetaDirectorySetting
---

# Remove-EntraBetaDirectorySetting

## SYNOPSIS

Deletes a directory setting in  Microsoft Entra ID.

## SYNTAX

```powershell
Remove-EntraBetaDirectorySetting
 -Id <String>
 [<CommonParameters>]
```

## DESCRIPTION

The `Remove-EntraBetaDirectorySetting` cmdlet removes a directory setting from Microsoft Entra ID.

In delegated scenarios with work or school accounts, the signed-in user must be assigned a supported Microsoft Entra role or a custom role with the necessary permissions. The following least privileged roles are supported:

- Microsoft Entra Joined Device Local Administrator: Read basic properties on setting templates and settings.
- Directory Readers: Read basic properties on setting templates and settings.
- Global Reader: Read basic properties on setting templates and settings.
- Groups Administrator: Manage all group settings.
- Directory Writers: Manage all group settings.
- Authentication Policy Administrator: Update Password Rule Settings.
- User Administrator: Read basic properties on setting templates and settings.

## EXAMPLES

### Example 1: Removes a directory setting from Microsoft Entra ID

```powershell
Connect-Entra -Scopes 'RoleManagement.ReadWrite.Directory'
Remove-EntraBetaDirectorySetting -Id 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'
```

This command removes a directory setting from Microsoft Entra ID.

- `-Id` Specifies the object ID of a settings object.

## PARAMETERS

### -Id

Specifies the object ID of a settings object in Microsoft Entra ID.

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

[Set-EntraBetaDirectorySetting](Set-EntraBetaDirectorySetting.md)
