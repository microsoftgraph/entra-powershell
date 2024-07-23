---
title: Restore-EntraDeletedDirectoryObject
description: This article provides details on the Restore-EntraDeletedDirectoryObject command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/en-us/powershell/module/Microsoft.Graph.Entra/Restore-EntraDeletedDirectoryObject

schema: 2.0.0
---

# Restore-EntraDeletedDirectoryObject

## Synopsis
This cmdlet is used to restore a previously deleted object.

## Syntax

```powershell
Restore-EntraDeletedDirectoryObject 
 -Id <String> 
 [<CommonParameters>]
```

## Description
This cmdlet is used to restore a previously deleted object.
Currently, only restoring Group and Application objects is supported. 
When a group or an application is deleted, it's initially soft deleted and can be recovered during the first 30 days after deletion.
After 30 days the deleted object is permanently deleted and can no longer be recovered.
Only Unified Groups (also known as
Office 365 Groups) can be restored.
Security groups can't be restored.

## Examples

### Example 1: Restore a deleted object with ID
```powershell
Restore-EntraDeletedDirectoryObject -Id aa644285-eb75-4389-885e-7233f096984c
```

```output
Id                                   DeletedDateTime
--                                   ---------------
aa644285-eb75-4389-885e-7233f096984c
```

This example shows how to restore a deleted object with Id aa644285-eb75-4389-885e-7233f096984c.

## Parameters

### -Id
The Id of the directory object to restore

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

### System.String
## Outputs

### System.Object
## Notes

## Related Links
