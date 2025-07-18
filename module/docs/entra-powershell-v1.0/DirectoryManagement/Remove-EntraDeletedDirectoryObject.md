---
author: msewaweru
description: This article provides details on the Remove-EntraDeletedDirectoryObject command.
external help file: Microsoft.Entra.Applications-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra
ms.author: eunicewaweru
ms.date: 06/26/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Remove-EntraDeletedDirectoryObject
schema: 2.0.0
title: Remove-EntraDeletedDirectoryObject
---

# Remove-EntraDeletedDirectoryObject

## SYNOPSIS

Permanently delete a previously deleted directory object.

## SYNTAX

```powershell
Remove-EntraDeletedDirectoryObject
 -DirectoryObjectId <String>
 [<CommonParameters>]
```

## DESCRIPTION

The `Remove-EntraDeletedDirectoryObject` cmdlet is used to permanently delete a previously deleted directory object.

When a directory object is permanently deleted, it can no longer be restored.

For delegated scenarios, the calling user needs to have at least one of the following Microsoft Entra roles.

- To permanently delete deleted applications or service principals: `Application Administrator`, `Cloud Application Administrator`, or `Hybrid Identity Administrator`.
- To permanently delete deleted users: `User Administrator`.
- To permanently delete deleted groups: `Groups Administrator`.

## EXAMPLES

### Example 1: Delete a previously deleted directory object

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All','Group.ReadWrite.All','Application.ReadWrite.All','User.ReadWrite.All'
$deletedApplication = Get-EntraDeletedApplication -SearchString 'My PowerShell Application'
Remove-EntraDeletedDirectoryObject -DirectoryObjectId $deletedApplication.Id
```

This example demonstrates how to permanently delete a previously deleted directory object by DirectoryObjectId.

- `-DirectoryObjectId` parameter specifies the Id of the directory object that is permanently deleted.

## PARAMETERS

### -DirectoryObjectId

The DirectoryObjectId of the directory object that is permanently deleted.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: Id

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS

[Get-EntraDeletedDirectoryObject](Get-EntraDeletedDirectoryObject.md)

[Restore-EntraDeletedDirectoryObject](Restore-EntraDeletedDirectoryObject.md)
