---
author: msewaweru
description: This article provides details on the Get-EntraBetaAdministrativeUnit command.
external help file: Microsoft.Entra.Beta.DirectoryManagement-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 07/02/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Get-EntraBetaAdministrativeUnit
schema: 2.0.0
title: Get-EntraBetaAdministrativeUnit
---

# Get-EntraBetaAdministrativeUnit

## SYNOPSIS

Gets an administrative unit.

## SYNTAX

### GetQuery (Default)

```powershell
Get-EntraBetaAdministrativeUnit
 [-Filter <String>]
 [-All]
 [-Top <Int32>]
 [-Property <String[]>]
 [<CommonParameters>]
```

### GetById

```powershell
Get-EntraBetaAdministrativeUnit
 -AdministrativeUnitId <String>
 [-All]
 [-Property <String[]>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Get-EntraBetaAdministrativeUnit` cmdlet gets a Microsoft Entra ID administrative unit. Specify `AdministrativeUnitId` parameter to get a specific administrative unit.

## EXAMPLES

### Example 1: Get all administrative units

```powershell
Connect-Entra -Scopes 'AdministrativeUnit.Read.All'
Get-EntraBetaAdministrativeUnit
```

```Output
DeletedDateTime Id                                   Description          DisplayName         IsMemberManagementRestricted Visibility
--------------- --                                   -----------          -----------         ---------------------------- ----------
                aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb Updated Description  Updated DisplayName
                bbbbbbbb-1111-2222-3333-cccccccccccc test111              test111
                cccccccc-2222-3333-4444-dddddddddddd                      TestAU
                dddddddd-3333-4444-5555-eeeeeeeeeeee                      test_130624_09
                eeeeeeee-4444-5555-6666-ffffffffffff test111              test111
                ffffffff-5555-6666-7777-aaaaaaaaaaaa                      test66
                aaaaaaaa-6666-7777-8888-bbbbbbbbbbbb test111              test111             True
```

This command gets all the administrative units.

### Example 2: Get all administrative units using '-All' parameter

```powershell
Connect-Entra -Scopes 'AdministrativeUnit.Read.All'
Get-EntraBetaAdministrativeUnit -All
```

```Output
DeletedDateTime Id                                   Description          DisplayName         IsMemberManagementRestricted Visibility
--------------- --                                   -----------          -----------         ---------------------------- ----------
                aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb Updated Description  Updated DisplayName
                bbbbbbbb-1111-2222-3333-cccccccccccc test111              test111
                cccccccc-2222-3333-4444-dddddddddddd                      TestAU
                dddddddd-3333-4444-5555-eeeeeeeeeeee                      test_130624_09
                eeeeeeee-4444-5555-6666-ffffffffffff test111              test111
                ffffffff-5555-6666-7777-aaaaaaaaaaaa                      test66
                aaaaaaaa-6666-7777-8888-bbbbbbbbbbbb test111              test111             True
```

This command gets all the administrative units.

### Example 3: Get a specific administrative unit

```powershell
Connect-Entra -Scopes 'AdministrativeUnit.Read.All'
Get-EntraBetaAdministrativeUnit -AdministrativeUnitId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'
```

```Output
DeletedDateTime Id                                   Description          DisplayName         IsMemberManagementRestricted Visibility
--------------- --                                   -----------          -----------         ---------------------------- ----------
                aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb Updated Description  Updated DisplayName
```

This example returns the details of the specified administrative unit.

- `-AdministrativeUnitId` parameter specifies the ID of an administrative unit.

### Example 4: Get administrative units filter by display name

```powershell
Connect-Entra -Scopes 'AdministrativeUnit.Read.All'
Get-EntraBetaAdministrativeUnit -Filter "DisplayName eq 'Updated DisplayName'"
```

```Output
DeletedDateTime Id                                   Description          DisplayName         IsMemberManagementRestricted Visibility
--------------- --                                   -----------          -----------         ---------------------------- ----------
                aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb Updated Description  Updated DisplayName
```

This example list of administrative units containing display name with the specified name.

### Example 5: Get top one administrative unit

```powershell
Connect-Entra -Scopes 'AdministrativeUnit.Read.All'
Get-EntraBetaAdministrativeUnit -Top 1
```

```Output
DeletedDateTime Id                                   Description          DisplayName         IsMemberManagementRestricted Visibility
--------------- --                                   -----------          -----------         ---------------------------- ----------
                aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb Updated Description  Updated DisplayName
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
Aliases: Id

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

[New-EntraBetaAdministrativeUnit](New-EntraBetaAdministrativeUnit.md)

[Remove-EntraBetaAdministrativeUnit](Remove-EntraBetaAdministrativeUnit.md)

[Set-EntraBetaAdministrativeUnit](Set-EntraBetaAdministrativeUnit.md)
