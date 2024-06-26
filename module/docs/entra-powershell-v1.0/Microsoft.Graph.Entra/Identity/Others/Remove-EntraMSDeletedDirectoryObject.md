---
title: Remove-EntraMSDeletedDirectoryObject.
description: This article provides details on the Remove-EntraMSDeletedDirectoryObject command.

ms.service: entra
ms.topic: reference
ms.date: 03/15/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Remove-EntraMSDeletedDirectoryObject

## Synopsis
This cmdlet is used to permanently delete a previously deleted directory object.

## Syntax

```powershell
Remove-EntraMSDeletedDirectoryObject 
 -Id <String> 
 [<CommonParameters>]
```

## Description
This cmdlet is used to permanently delete a previously deleted directory object.

When a directory object is permanently deleted, it can no longer be restored.

## Examples

### Example 1: Delete a previously deleted directory object

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All' #Application resource type
Connect-Entra -Scopes 'Group.ReadWrite.All' #Group resource type
Connect-Entra -Scopes 'Application.ReadWrite.All' #Service Principal resource type
Connect-Entra -Scopes 'User.ReadWrite.All' #User resource type

Remove-EntraMSDeletedDirectoryObject -Id 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'
```

This example demonstrates how to permanently delete a previously deleted directory object by Id.

## Parameters

### -Id

The Id of the directory object that is permanently deleted.

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

## Related LINKS

[Get-EntraMSDeletedDirectoryObject](Get-EntraMSDeletedDirectoryObject.md)

[Restore-EntraMSDeletedDirectoryObject](Restore-EntraMSDeletedDirectoryObject.md)
