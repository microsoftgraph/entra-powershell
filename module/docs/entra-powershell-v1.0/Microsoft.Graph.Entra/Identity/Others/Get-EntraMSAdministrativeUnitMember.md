---
title: Get-EntraMSAdministrativeUnitMember
description: This article provides details on the Get-EntraMSAdministrativeUnitMember command.

ms.service: entra
ms.topic: reference
ms.date: 03/04/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraMSAdministrativeUnitMember

## Synopsis
Gets a member of an administrative unit.

## Syntax

```powershell
Get-EntraMSAdministrativeUnitMember
 -Id <String> 
 [-All] 
 [-Top <Int32>]
 [<CommonParameters>]
```

## Description
The Get-EntraMSAdministrativeUnitMember cmdlet gets a member of a Microsoft Entra ID administrative unit.

## Examples

### Example 1: Get an administrative unit member by ID

```powershell
Connect-Entra -Scopes 'AdministrativeUnit.Read.All'
Get-EntraMSAdministrativeUnitMember -Id 'ffffffff-5555-6666-7777-aaaaaaaaaaaa'
```

```Output
Id                                   OdataType
--                                   ---------
bbbbbbbb-7777-8888-9999-cccccccccccc #microsoft.graph.user
cccccccc-8888-9999-0000-dddddddddddd #microsoft.graph.user
dddddddd-9999-0000-1111-eeeeeeeeeeee #microsoft.graph.user
```

This example returns the list of administrative unit members from specified administrative unit ID.

### Example 2: Get all administrative unit members by ID

```powershell
Connect-Entra -Scopes 'AdministrativeUnit.Read.All'
Get-EntraMSAdministrativeUnitMember -Id 'ffffffff-5555-6666-7777-aaaaaaaaaaaa' -All
```

```Output
Id                                   OdataType
--                                   ---------
bbbbbbbb-7777-8888-9999-cccccccccccc #microsoft.graph.user
cccccccc-8888-9999-0000-dddddddddddd #microsoft.graph.user
dddddddd-9999-0000-1111-eeeeeeeeeeee #microsoft.graph.user
```

This example returns the list of administrative unit members from specified administrative unit ID.

### Example 3: Get top two administrative unit members by ID

```powershell
Connect-Entra -Scopes 'AdministrativeUnit.Read.All'
Get-EntraMSAdministrativeUnitMember -Id 'ffffffff-5555-6666-7777-aaaaaaaaaaaa' -Top 2
```

```Output
Id                                   OdataType
--                                   ---------
bbbbbbbb-7777-8888-9999-cccccccccccc #microsoft.graph.user
cccccccc-8888-9999-0000-dddddddddddd #microsoft.graph.user
```

This example returns top specified administrative unit members from specified administrative unit ID.

## Parameters

### -Id

Specifies the ID of an administrative unit in Microsoft Entra ID.

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

### -Top

Specifies the maximum number of records to return.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related LINKS

[Add-EntraMSAdministrativeUnitMember](Add-EntraMSAdministrativeUnitMember.md)

[Remove-EntraMSAdministrativeUnitMember](Remove-EntraMSAdministrativeUnitMember.md)
