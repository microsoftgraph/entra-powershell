---
title: Remove-EntraMSDeletedDirectoryObject.
description: This article provides details on the Remove-EntraMSDeletedDirectoryObject command.

ms.service: active-directory
ms.topic: reference
ms.date: 11/10/2023
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

## SYNOPSIS
This cmdlet is used to permanently delete a previously deleted directory object.

## SYNTAX

```
Remove-EntraMSDeletedDirectoryObject 
 -Id <String> 
 [<CommonParameters>]
```

## DESCRIPTION
This cmdlet is used to permanently delete a previously deleted directory object.
When a directory object is permanently deleted it can no longer be restored.

## EXAMPLES

### Example 1: Delete a previously deleted directory object
```
Remove-EntraMSDeletedDirectoryObject -Id aa644285-eb75-4389-885e-7233f096984c
```

This command shows how to permanently delete a previously deleted directory object with Id = aa644285-eb75-4389-885e-7233f096984c

## PARAMETERS

### -Id
The Id of the directory object that is permanently deleted

```yaml
Type: String
Parameter Sets: (All)
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

### System.String
## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
