---
title: Remove-EntraDeletedApplication.
description: This article provides details on the Remove-EntraDeletedApplication command.

ms.service: entra
ms.topic: reference
ms.date: 03/16/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Remove-EntraDeletedApplication

## Synopsis
Permanently delete a recently deleted application object from deleted items.

## Syntax

```powershell
Remove-EntraDeletedApplication 
 [-ObjectId] <String> 
 [<CommonParameters>]
```

## Description
Permanently delete a recently deleted application object from deleted items. After an item is permanently deleted, it can't be restored.


## Examples

### Example 1: Remove deleted application object
```powershell
PS C:\> $Id = Get-EntraDeletedApplication -SearchString "newtest10" 
PS C:\> Remove-EntraDeletedApplication -ObjectId $Id.id
```

This command removes recently deleted application.
- `ObjectId`:  The ObjectId of the deleted application.

## Parameters

### -ObjectId
The unique identifier of deleted application.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

### System.String

## Outputs

### System.Object
## Notes

## Related LINKS

[Get-EntraDeletedApplication](Get-EntraDeletedApplication.md)

[Restore-EntraDeletedApplication](Restore-EntraDeletedApplication.md)