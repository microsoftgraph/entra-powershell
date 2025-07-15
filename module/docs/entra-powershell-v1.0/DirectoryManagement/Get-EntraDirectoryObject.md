---
author: msewaweru
description: This article provides details on the Get-EntraDirectoryObject command.
external help file: Microsoft.Entra.DirectoryManagement-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra
ms.author: eunicewaweru
ms.date: 06/26/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Get-EntraDirectoryObject
schema: 2.0.0
title: Get-EntraDirectoryObject
---

# Get-EntraDirectoryObject

## SYNOPSIS

Retrieves directory objects based on a list of IDs.

## SYNTAX

```powershell
Get-EntraDirectoryObject
 -DirectoryObjectIds <System.Collections.Generic.List`1[String]>
 [-ObjectTypes <System.Collections.Generic.List`1[String]>]
 [-Property <String[]>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Get-EntraDirectoryObject` cmdlet retrieves directory objects based on a list of IDs (a list of up to 1000 GUIDs (as strings) to retrieve objects for).

## EXAMPLES

### Example 1: Get an object One or more object IDs

```powershell
Connect-Entra -Scopes 'Directory.Read.All'
$groups = Get-EntraGroup -Limit 4
Get-EntraDirectoryObject -DirectoryObjectIds $groups.Id | 
Select-Object Id, DisplayName, '@odata.type'
```

```Output
id                                   displayName    @odata.type            
--                                   -----------    -----------            
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb Adele Vance    #microsoft.graph.user  
bbbbbbbb-1111-2222-3333-cccccccccccc Contoso User   #microsoft.graph.user
```

This example demonstrates how to retrieve objects for a specified object Ids.

- `DirectoryObjectIds` parameter specifies a list of up to 1000 GUIDs (as strings) to retrieve objects for.

### Example 2: Get an object by types

```powershell
Connect-Entra -Scopes 'Directory.Read.All'
Get-EntraDirectoryObject -DirectoryObjectIds 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb', 'bbbbbbbb-1111-2222-3333-cccccccccccc' -ObjectTypes 'User' | 
Select-Object Id, DisplayName, '@odata.type'
```

```Output
id                                   displayName    @odata.type            
--                                   -----------    -----------            
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb Adele Vance    #microsoft.graph.user  
bbbbbbbb-1111-2222-3333-cccccccccccc Contoso User   #microsoft.graph.user
```

This example demonstrates how to retrieve objects for a specified object type.

- `-DirectoryObjectIds` parameter specifies a list of up to 1000 GUIDs (as strings) to retrieve objects for.
- `-ObjectTypes` parameter specifies the type of object ID.

## PARAMETERS

### -DirectoryObjectIds

One or more object IDs's, separated by commas, for which the objects are retrieved. The IDs are GUIDs, represented as strings. You can specify up to 1,000 IDs.

```yaml
Type: System.Collections.Generic.List`1[System.String]
Parameter Sets: (All)
Aliases: ObjectIds

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ObjectTypes

Specifies the type of objects that the cmdlet returns. If not specified, the default is directoryObject, which includes all resource types defined in the directory. You can specify any object derived from directoryObject in the collection, such as user, group, and device objects.

```yaml
Type: System.Collections.Generic.List`1[System.String]
Parameter Sets: (All)
Aliases: Types

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
Aliases: Select

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS
