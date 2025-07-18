---
description: This article provides details on the Get-EntraAdministrativeUnit command.
external help file: Microsoft.Entra.DirectoryManagement-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra
ms.author: eunicewaweru
ms.date: 06/26/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Get-EntraAdministrativeUnit
schema: 2.0.0
title: Get-EntraAdministrativeUnit
---

# Get-EntraAdministrativeUnit

## SYNOPSIS

Gets an administrative unit.

## SYNTAX

### GetQuery (Default)

```powershell
Get-EntraAdministrativeUnit
 [-Top <Int32>]
 [-All]
 [-Filter <String>]
 [-Property <String[]>]
 [<CommonParameters>]
```

### GetById

```powershell
Get-EntraAdministrativeUnit
 -AdministrativeUnitId <String>
 [-All]
 [-Property <String[]>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Get-EntraAdministrativeUnit` cmdlet gets a Microsoft Entra ID administrative unit. Specify `AdministrativeUnitId` parameter to get a specific administrative unit.

## EXAMPLES

### Example 1: Get all administrative units

```powershell
Connect-Entra -Scopes 'AdministrativeUnit.Read.All'
Get-EntraAdministrativeUnit
```

```Output
DeletedDateTime Id                                   Description            DisplayName             Visibility
--------------- --                                   -----------            -----------             ----------
                dddddddd-3333-4444-5555-eeeeeeeeeeee  Updated Description    Updated DisplayName
                cccccccc-2222-3333-4444-dddddddddddd  testdemo               test1
                bbbbbbbb-1111-2222-3333-cccccccccccc                         TestAU
                aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb                         test_130624_09
                aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb  demotest               test111
```

This command gets all the administrative units.

### Example 2: Get all administrative units using '-All' parameter

```powershell
Connect-Entra -Scopes 'AdministrativeUnit.Read.All'
Get-EntraAdministrativeUnit -All
```

```Output
DeletedDateTime Id                                   Description            DisplayName             Visibility
--------------- --                                   -----------            -----------             ----------
                dddddddd-3333-4444-5555-eeeeeeeeeeee  Updated Description    Updated DisplayName
                cccccccc-2222-3333-4444-dddddddddddd  testdemo               test1
                bbbbbbbb-1111-2222-3333-cccccccccccc                         TestAU
                aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb                         test_130624_09
                aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb  demotest               test111
```

This command gets all the administrative units.

### Example 3: Get a specific administrative unit

```powershell
Connect-Entra -Scopes 'AdministrativeUnit.Read.All'
Get-EntraAdministrativeUnit -AdministrativeUnitId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'
```

```Output
DeletedDateTime Id                                   Description            DisplayName             Visibility
--------------- --                                   -----------            -----------             ----------
                aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb  Updated Description    Updated DisplayName
```

This example returns the details of the specified administrative unit.

- `-AdministrativeUnitId` parameter specifies the ID of an administrative unit.

### Example 4: Get administrative units filter by display name

```powershell
Connect-Entra -Scopes 'AdministrativeUnit.Read.All'
Get-EntraAdministrativeUnit -Filter "DisplayName eq 'DAU-Test'"
```

```Output
DeletedDateTime Id                                   Description            DisplayName             Visibility
--------------- --                                   -----------            -----------             ----------
                aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb  Dynamic AU testing in CORP tenant    DAU-Test
```

This example list of administrative units containing display name with the specified name.

### Example 5: Get top one administrative unit

```powershell
Connect-Entra -Scopes 'AdministrativeUnit.Read.All'
Get-EntraAdministrativeUnit -Top 1
```

```Output
DeletedDateTime Id                                   Description            DisplayName             Visibility
--------------- --                                   -----------            -----------             ----------
                aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb  Dynamic AU testing in CORP tenant    DAU-Test
```

This example returns the specified top administrative units. You can use `-Limit` as an alias for `-Top`.

## PARAMETERS

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
This parameter filters which objects are returned.

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

### -AdministrativeUnitId

Specifies the ID of an administrative unit in Microsoft Entra ID.

```yaml
Type: System.String
Parameter Sets: GetById
Aliases: ObjectId

Required: True
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
Aliases: Limit

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

## OUTPUTS

## NOTES

## RELATED LINKS

[New-EntraAdministrativeUnit](New-EntraAdministrativeUnit.md)

[Remove-EntraAdministrativeUnit](Remove-EntraAdministrativeUnit.md)

[Set-EntraAdministrativeUnit](Set-EntraAdministrativeUnit.md)
