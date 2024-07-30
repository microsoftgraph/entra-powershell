---
title: Get-EntraBetaAdministrativeUnitMember.
description: This article provides details on the Get-EntraBetaAdministrativeUnitMember command.


ms.topic: reference
ms.date: 07/04/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Get-EntraBetaAdministrativeUnitMember

schema: 2.0.0
---

# Get-EntraBetaAdministrativeUnitMember

## Synopsis

Gets a member of an administrative unit.

## Syntax

```powershell
Get-EntraBetaAdministrativeUnitMember 
 -ObjectId <String> 
 [-All] 
 [-Top <Int32>]
 [<CommonParameters>]
```

## Description

The `Get-EntraBetaAdministrativeUnitMember` cmdlet gets a member of a Microsoft Entra ID administrative unit. Specify `ObjectId` parameters to retrieve an administrative unit member.

## Examples

### Example 1: Get an administrative unit member by ObjectId

```powershell
Connect-Entra -Scopes 'AdministrativeUnit.ReadWrite.All'
Get-EntraBetaAdministrativeUnitMember -ObjectId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'
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

This example returns the list of administrative unit members from specified administrative unit ObjectId.

### Example 2: Get all administrative unit members by ObjectId

```powershell
Connect-Entra -Scopes 'AdministrativeUnit.ReadWrite.All'
Get-EntraBetaAdministrativeUnitMember -ObjectId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'
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

This example returns the list of all administrative unit members from specified administrative unit ObjectId.

### Example 3: Get top three administrative unit members by ObjectId

```powershell
Connect-Entra -Scopes 'AdministrativeUnit.ReadWrite.All'
Get-EntraBetaAdministrativeUnitMember -ObjectId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb' -Top 3
```

```Output
Id                                   DeletedDateTime
--                                   ---------------
bbbbbbbb-1111-2222-3333-cccccccccccc
cccccccc-2222-3333-4444-dddddddddddd
dddddddd-3333-4444-5555-eeeeeeeeeeee
```

This example returns top three administrative unit members from specified administrative unit ObjectId.

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

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related Links

[Add-EntraBetaAdministrativeUnitMember](Add-EntraBetaAdministrativeUnitMember.md)

[New-EntraBetaAdministrativeUnitMember](New-EntraBetaAdministrativeUnitMember.md)

[Remove-EntraBetaAdministrativeUnitMember](Remove-EntraBetaAdministrativeUnitMember.md)
