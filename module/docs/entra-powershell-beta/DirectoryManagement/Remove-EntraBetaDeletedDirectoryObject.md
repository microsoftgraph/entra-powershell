---
author: msewaweru
description: This article provides details on the Remove-EntraBetaDeletedDirectoryObject command.
external help file: Microsoft.Entra.Beta.Applications-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 08/07/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Remove-EntraBetaDeletedDirectoryObject
schema: 2.0.0
title: Remove-EntraBetaDeletedDirectoryObject
---

# Remove-EntraBetaDeletedDirectoryObject

## Synopsis

Permanently delete a previously deleted directory object.

## Syntax

```powershell
Remove-EntraBetaDeletedDirectoryObject
 -Id <String>
 [<CommonParameters>]
```

## Description

The `Remove-EntraBetaDeletedDirectoryObject` cmdlet is used to permanently delete a previously deleted directory object.

When a directory object is permanently deleted, it can no longer be restored.

For delegated scenarios, the calling user needs to have at least one of the following Microsoft Entra roles.

- To permanently delete applications or service principals: `Application Administrator`, `Cloud Application Administrator`, or `Hybrid Identity Administrator`.
- To permanently delete users: `User Administrator`.
- To permanently delete groups: `Groups Administrator`.

## Examples

### Example 1: Delete a previously deleted directory object

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All','Group.ReadWrite.All','Application.ReadWrite.All','User.ReadWrite.All'
$deletedApplication = Get-EntraBetaDeletedApplication -SearchString 'My PowerShell Application'
Remove-EntraBetaDeletedDirectoryObject -DirectoryObjectId $deletedApplication.Id
```

This example demonstrates how to permanently delete a previously deleted directory object by ID.

- `-Id` parameter specifies the ID of the directory object that is permanently deleted.

## Parameters

### -Id

The ID of the directory object that is permanently deleted.

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

### System.String

## Outputs

### System.Object

## Notes

## Related links

[Get-EntraBetaDeletedDirectoryObject](Get-EntraBetaDeletedDirectoryObject.md)

[Restore-EntraBetaDeletedDirectoryObject](Restore-EntraBetaDeletedDirectoryObject.md)
