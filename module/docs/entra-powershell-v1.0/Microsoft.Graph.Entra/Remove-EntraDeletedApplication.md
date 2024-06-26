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

## SYNOPSIS

Permanently delete a recently deleted application object from deleted items.

## SYNTAX

```powershell
Remove-EntraDeletedApplication 
 [-ObjectId] <String> 
 [<CommonParameters>]
```

## DESCRIPTION

Permanently delete a recently deleted application object from deleted items. After an item is permanently deleted, it can't be restored.

For delegated scenarios, the calling user needs to have at least one of the following Microsoft Entra roles.

- To permanently delete deleted applications or service principals: Application Administrator, Cloud Application Administrator, or Hybrid Identity Administrator.

## EXAMPLES

### Example 1: Remove deleted application object

```powershell
 Connect-Entra -Scopes 'Application.ReadWrite.All'
 $Id = Get-EntraDeletedApplication -SearchString 'My Entra PowerShell Application' 
 Remove-EntraDeletedApplication -ObjectId $Id.id
```

This command removes recently deleted application.

- `ObjectId`:  The ObjectId of the deleted application.

## PARAMETERS

### -ObjectId

The unique identifier of deleted application.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
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

[Get-EntraDeletedApplication](Get-EntraDeletedApplication.md)

[Restore-EntraDeletedApplication](Restore-EntraDeletedApplication.md)
