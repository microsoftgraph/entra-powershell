---
title: Get-EntraBetaApplicationTemplate
description: This article provides details on the Get-EntraBetaApplicationTemplate command.


ms.topic: reference
ms.date: 07/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: mwongerapk
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Get-EntraBetaApplicationTemplate

schema: 2.0.0
---

# Get-EntraBetaApplicationTemplate

## Synopsis

Retrieve a list of applicationTemplate objects.

## Syntax

### GetQuery (Default)

```powershell
Get-EntraBetaApplicationTemplate
 [-Property <String[]>]
 [<CommonParameters>]
```

### GetById

```powershell
Get-EntraBetaApplicationTemplate
 -Id <String>
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

The `Get-EntraBetaApplicationTemplate` cmdlet allows users to get a list of all the application templates or a specific application template.

## Examples

### Example 1. Gets a list of application template objects

```powershell
Connect-Entra -Scopes 'Application.Read.All'
Get-EntraBetaApplicationTemplate
```

This command gets all the application template objects

### Example 2. Gets an application template object

```powershell
Connect-Entra -Scopes 'Application.Read.All'
Get-EntraBetaApplicationTemplate -Id 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'
```

```Output
Id                                   Categories                                      Description
--                                   ----------                                      -----------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb {businessMgmt, productivity, projectManagement} Cube is perfect for businesses
```

This command gets an application template object for the given id.

- `-Id` Specifies the unique identifier of an application template.

## Parameters

### -Id

The unique identifier of an application template.

```yaml
Type: System.String
Parameter Sets: GetById
Aliases:

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

### Microsoft.Online.Administration.ApplicationTemplate

## Notes

## Related Links
