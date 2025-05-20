---
title: Get-EntraBetaObjectByObjectId
description: This article provides details on the Get-EntraBetaObjectByObjectId.

ms.topic: reference
ms.date: 07/17/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Get-EntraBetaObjectByObjectId

schema: 2.0.0
---

# Get-EntraBetaObjectByObjectId

## Synopsis

Retrieves the objects specified by the ObjectIds parameter.

## Syntax

```powershell
Get-EntraBetaObjectByObjectId
 [-Types <System.Collections.Generic.List`1[System.String]>]
 -ObjectIds <System.Collections.Generic.List`1[System.String]>
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

The `Get-EntraBetaObjectByObjectId` cmdlet retrieves the objects specified by the ObjectIds parameter.

## Examples

### Example 1: Get an object One or more object IDs

```powershell
Connect-Entra -Scopes 'Directory.Read.All'
Get-EntraBetaObjectByObjectId -ObjectIds 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb', 'bbbbbbbb-1111-2222-3333-cccccccccccc'
```

```Output
Id                                   DeletedDateTime
--                                   ---------------
cccccccc-2222-3333-4444-dddddddddddd
```

This example demonstrates how to retrieve objects for a specified object Ids.

- `ObjectIds` parameter specifies the One or more object IDs.

### Example 2: Get an object by types

```powershell
Connect-Entra -Scopes 'Directory.Read.All'
Get-EntraBetaObjectByObjectId -ObjectIds 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb' -Types User
```

```Output
Id                                   DeletedDateTime
--                                   ---------------
bbbbbbbb-1111-2222-3333-cccccccccccc
```

This example demonstrates how to retrieve objects for a specified object type.

- `-ObjectIds` parameter specifies the One or more object IDs.
- `-Types` parameter specifies the type of object ID.

## Parameters

### -ObjectIds

One or more object IDs's, separated by commas, for which the objects are retrieved. The IDs are GUIDs, represented as strings. You can specify up to 1,000 IDs.

```yaml
Type: System.Collections.Generic.List`1[System.String]
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Types

Specifies the type of objects that the cmdlet returns. If not specified, the default is directoryObject, which includes all resource types defined in the directory. You can specify any object derived from directoryObject in the collection, such as user, group, and device objects.

```yaml
Type: System.Collections.Generic.List`1[System.String]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
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

### None

## Outputs

### System.Object

## Notes

## Related links
