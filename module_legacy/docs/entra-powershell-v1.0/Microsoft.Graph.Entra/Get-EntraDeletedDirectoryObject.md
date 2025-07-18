---
title: Get-EntraDeletedDirectoryObject
description: This article provides details on the Get-EntraDeletedDirectoryObject command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: mwongerapk

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Get-EntraDeletedDirectoryObject

schema: 2.0.0
---

# Get-EntraDeletedDirectoryObject

## Synopsis

Retrieves a soft deleted directory object from the directory.

## Syntax

```powershell
Get-EntraDeletedDirectoryObject
 -DirectoryObjectId <String>
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

The `Get-EntraDeletedDirectoryObject` cmdlet retrieves a soft deleted directory object from the directory.
Note that soft delete for groups is currently only implemented for Unified Groups (also known as
Office 365 Groups).

## Examples

### Example 1: Retrieve a deleted directory object.

```powershell
Connect-Entra -Scopes 'AdministrativeUnit.Read.All', 'Application.Read.All','Group.Read.All','User.Read.All'
Get-EntraDeletedDirectoryObject -DirectoryObjectId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'
```

```Output
Id                                   DeletedDateTime
--                                   ---------------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb 2/2/2024 5:33:56 AM
```

This example shows how to retrieve the deleted directory object from the directory.

- `-DirectoryObjectId` parameter specifies the Id of the directory object to retrieve.

### Example 2: Retrieve a deleted directory object with more details.

```powershell
Connect-Entra -Scopes 'AdministrativeUnit.Read.All', 'Application.Read.All','Group.Read.All','User.Read.All'
Get-EntraDeletedDirectoryObject -Id 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb' | Format-Table -Property Id, displayName, '@odata.type' -AutoSize
```

```Output
Id                                   displayName           @odata.type
--                                   -----------           -----------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb Entra PowerShell App #microsoft.graph.application
```

This example shows how to retrieve the deleted directory object details from the directory.

- `-Id` parameter specifies the Id of the directory object to retrieve.

## Parameters

### -DirectoryObjectId

The Id of the directory object to retrieve.

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

### -Property

Specifies properties to be returned.

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

### System.Object

## Notes

## Related Links
