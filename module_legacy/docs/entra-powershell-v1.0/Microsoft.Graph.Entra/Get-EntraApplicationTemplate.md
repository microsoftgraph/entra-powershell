---
title: Get-EntraApplicationTemplate
description: This article provides details on the Get-EntraApplicationTemplate command.


ms.topic: reference
ms.date: 07/17/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Get-EntraApplicationTemplate
schema: 2.0.0
---

# Get-EntraApplicationTemplate

## Synopsis

Retrieve a list of applicationTemplate objects.

## Syntax

### GetQuery (Default)

```powershell
Get-EntraApplicationTemplate
 [-Filter <String>]
 [-All]
 [-Top <Int32>]
 [-Property <String[]>]
 [<CommonParameters>]
```

### GetById

```powershell
Get-EntraApplicationTemplate
 -Id <String>
 [<CommonParameters>]
```

## Description

The `Get-EntraApplicationTemplate` cmdlet allows users to get a list of all the application templates or a specific application template.

## Examples

### Example 1. Gets a list of application template objects

```powershell
Connect-Entra -Scopes 'Application.Read.All'
Get-EntraApplicationTemplate
```

This command gets all the application template objects

### Example 2. Gets an application template object

```powershell
Connect-Entra -Scopes 'Application.Read.All'
Get-EntraApplicationTemplate -Id 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'
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

### -All

List all pages.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Filter

Specifies an OData v4.0 filter statement.
This parameter controls which objects are returned.

```yaml
Type: System.String
Parameter Sets: GetQuery
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Top

Specifies the maximum number of records to return.

```yaml
Type: System.Int32
Parameter Sets: GetQuery
Aliases:

Required: False
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
