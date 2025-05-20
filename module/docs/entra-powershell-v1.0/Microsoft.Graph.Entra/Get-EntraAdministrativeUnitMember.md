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
 -AdministrativeUnitId <String>
 [-All]
 [-Top <Int32>]
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

The `Get-EntraAdministrativeUnitMember` cmdlet gets a member of a Microsoft Entra ID administrative unit. Specify `AdministrativeUnitId` parameters to retrieve an administrative unit member.

In delegated scenarios with work or school accounts, the signed-in user must either be a member user or be assigned a supported Microsoft Entra role, or a custom role with the necessary permissions. The following least privileged roles are supported for this operation:

- Directory Readers: Read basic properties on administrative units
- Global Reader: Read all properties of administrative units, including members
- Privileged Role Administrator: Create and manage administrative units (including members)

## Examples

### Example 1: Get an administrative unit member by AdministrativeUnitId

```powershell
Connect-Entra -Scopes 'AdministrativeUnit.ReadWrite.All'
$administrativeUnit = Get-EntraAdministrativeUnit -Filter "DisplayName eq '<administrativeunit-display-name>'"
Get-EntraAdministrativeUnitMember -AdministrativeUnitId $administrativeUnit.Id
```

```Output
Id                                   DeletedDateTime
--                                   ---------------
bbbbbbbb-1111-2222-3333-cccccccccccc
cccccccc-2222-3333-4444-dddddddddddd
dddddddd-3333-4444-5555-eeeeeeeeeeee
eeeeeeee-4444-5555-6666-ffffffffffff
ffffffff-5555-6666-7777-aaaaaaaaaaaa
```

This example returns the list of administrative unit members from specified administrative unit AdministrativeUnitId.

- `-AdministrativeUnitId` parameter specifies the ID of an administrative unit.

### Example 2: Get all administrative unit members by AdministrativeUnitId

```powershell
Connect-Entra -Scopes 'AdministrativeUnit.ReadWrite.All'
$administrativeUnit = Get-EntraAdministrativeUnit -Filter "DisplayName eq '<administrativeunit-display-name>'"
Get-EntraAdministrativeUnitMember -AdministrativeUnitId $administrativeUnit.Id -All
```

```Output
Id                                   DeletedDateTime
--                                   ---------------
bbbbbbbb-1111-2222-3333-cccccccccccc
cccccccc-2222-3333-4444-dddddddddddd
dddddddd-3333-4444-5555-eeeeeeeeeeee
eeeeeeee-4444-5555-6666-ffffffffffff
ffffffff-5555-6666-7777-aaaaaaaaaaaa
```

This example returns the list of all administrative unit members from specified administrative unit AdministrativeUnitId.

- `-AdministrativeUnitId` parameter specifies the ID of an administrative unit.

### Example 3: Get top three administrative unit members by AdministrativeUnitId

```powershell
Connect-Entra -Scopes 'AdministrativeUnit.ReadWrite.All'
$administrativeUnit = Get-EntraAdministrativeUnit -Filter "DisplayName eq '<administrativeunit-display-name>'"
Get-EntraAdministrativeUnitMember -AdministrativeUnitId $administrativeUnit.Id -Top 3
```

```Output
Id                                   DeletedDateTime
--                                   ---------------
bbbbbbbb-1111-2222-3333-cccccccccccc
cccccccc-2222-3333-4444-dddddddddddd
dddddddd-3333-4444-5555-eeeeeeeeeeee
```

This example returns top three administrative unit members from specified administrative unit AdministrativeUnitId.

- `-AdministrativeUnitId` parameter specifies the ID of an administrative unit.

## Parameters

### -AdministrativeUnitId

Specifies the ID of an administrative unit in Microsoft Entra ID.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: ObjectId

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

## Related links

[Add-EntraAdministrativeUnitMember](Add-EntraAdministrativeUnitMember.md)

[Remove-EntraAdministrativeUnitMember](Remove-EntraAdministrativeUnitMember.md)
