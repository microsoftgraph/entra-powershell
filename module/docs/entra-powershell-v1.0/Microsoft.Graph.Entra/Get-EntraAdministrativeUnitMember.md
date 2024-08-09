---
title: Get-EntraAdministrativeUnitMember
description: This article provides details on the Get-EntraAdministrativeUnitMember command.


ms.topic: reference
ms.date: 07/30/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Get-EntraAdministrativeUnitMember

schema: 2.0.0
---

# Get-EntraAdministrativeUnitMember

## Synopsis

Gets a member of an administrative unit.

## Syntax

```powershell
Get-EntraAdministrativeUnitMember
 -ObjectId <String> 
 [-All]
 [-Top <Int32>]
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

The `Get-EntraAdministrativeUnitMember` cmdlet gets a member of a Microsoft Entra ID administrative unit. Specify `ObjectId` parameter to get a member.

## Examples

### Example 1: Get an administrative unit member by ObjectId

```powershell
Connect-Entra -Scopes 'AdministrativeUnit.Read.All'
Get-EntraAdministrativeUnitMember -ObjectId 'bbbbbbbb-1111-1111-1111-cccccccccccc'
```

```Output
Id                                   DeletedDateTime
--                                   ---------------
bbbbbbbb-1111-1111-1111-cccccccccccc
```

This example returns the list of administrative unit members from specified administrative unit ObjectID.

- `-ObjectId` Specifies the ID of an administrative unit.

### Example 2: Get all administrative unit members by ObjectId

```powershell
Connect-Entra -Scopes 'AdministrativeUnit.Read.All'
Get-EntraAdministrativeUnitMember -ObjectId 'bbbbbbbb-1111-1111-1111-cccccccccccc' -All
```

```Output
Id                                   DeletedDateTime
--                                   ---------------
bbbbbbbb-1111-1111-1111-cccccccccccc
aaaabbbb-0000-cccc-1111-dddd2222eeee
```

This example returns the list of administrative unit members from specified administrative unit ObjectID.

`-ObjectId` Specifies the ID of an administrative unit.

### Example 3: Get top one administrative unit member by ObjectId

```powershell
Connect-Entra -Scopes 'AdministrativeUnit.Read.All'
Get-EntraAdministrativeUnitMember -ObjectId 'bbbbbbbb-1111-1111-1111-cccccccccccc' -Top 1
```

```Output
Id                                   DeletedDateTime
--                                   ---------------
bbbbbbbb-1111-1111-1111-cccccccccccc
```

This example returns top specified administrative unit members from specified administrative unit ObjectID.

`-ObjectId` Specifies the ID of an administrative unit.

## Parameters

### -ObjectId

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

## Notes

## Related Links

[Add-EntraAdministrativeUnitMember](Add-EntraAdministrativeUnitMember.md)

[Remove-EntraAdministrativeUnitMember](Remove-EntraAdministrativeUnitMember.md)
