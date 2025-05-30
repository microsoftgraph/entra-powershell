---
title: Get-EntraDeletedAdministrativeUnit
description: This article provides details on the Get-EntraDeletedAdministrativeUnit command.

ms.topic: reference
ms.date: 02/12/2025
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Entra.DirectoryManagement-Help.xml
Module Name: Microsoft.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Get-EntraDeletedAdministrativeUnit

schema: 2.0.0
---

# Get-EntraDeletedAdministrativeUnit

## Synopsis

Retrieves the list of previously deleted administrative units.

## Syntax

### GetQuery (Default)

```powershell
Get-EntraDeletedAdministrativeUnit
 [-Filter <String>]
 [-All]
 [-Top <Int32>]
 [-Property <String[]>]
 [<CommonParameters>]
```

### GetById

```powershell
Get-EntraDeletedAdministrativeUnit
 -AdministrativeUnitId <String>
 [-Property <String[]>]
 [<CommonParameters>]
```

### GetVague

```powershell
Get-EntraDeletedAdministrativeUnit
 [-SearchString <String>]
 [-All]
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

The `Get-EntraDeletedAdministrativeUnit` cmdlet Retrieves the list of previously deleted administrative units.

## Examples

### Example 1: Get list of deleted administrative units

```powershell
Connect-Entra -Scopes 'AdministrativeUnit.Read.All'
Get-EntraDeletedAdministrativeUnit | Select-Object Id, DisplayName, MembershipType, Visibility, DeletedDateTime, DeletionAgeInDays | Format-Table -AutoSize
```

```Output
Id                                   DisplayName                   MembershipType     Visibility         DeletedDateTime           DeletionAgeInDays
--                                   -----------                   --------------     ----------         ---------------           -----------------
gggggggg-8888-9999-aaaa-hhhhhhhhhhhh Americas Administrative Unit   Dynamic           HiddenMembership   2/12/2025 12:40:52 PM     10
```

This cmdlet retrieves the list of deleted administrative units.

### Example 2: Get list of deleted administrative units using All parameter

```powershell
Connect-Entra -Scopes 'AdministrativeUnit.Read.All'
Get-EntraDeletedAdministrativeUnit -All | Select-Object Id, DisplayName, MembershipType, Visibility, DeletedDateTime, DeletionAgeInDays | Format-Table -AutoSize
```

```Output
Id                                   DisplayName                   MembershipType     Visibility         DeletedDateTime           DeletionAgeInDays
--                                   -----------                   --------------     ----------         ---------------           -----------------
gggggggg-8888-9999-aaaa-hhhhhhhhhhhh Americas Administrative Unit   Dynamic           HiddenMembership   2/12/2025 12:40:52 PM     10
```

This cmdlet retrieves the list of deleted administrative units using All parameter.

### Example 3: Get top two deleted administrative units

```powershell
Connect-Entra -Scopes 'AdministrativeUnit.Read.All'
Get-EntraDeletedAdministrativeUnit -Top 2 | Select-Object Id, DisplayName, MembershipType, Visibility, DeletedDateTime, DeletionAgeInDays | Format-Table -AutoSize
```

```Output
Id                                   DisplayName                   MembershipType     Visibility         DeletedDateTime           DeletionAgeInDays
--                                   -----------                   --------------     ----------         ---------------           -----------------
gggggggg-8888-9999-aaaa-hhhhhhhhhhhh Americas Administrative Unit   Dynamic           HiddenMembership   2/12/2025 12:40:52 PM     10
```

This cmdlet retrieves top two deleted administrative units. You can use `-Limit` as an alias for `-Top`.

### Example 4: Get deleted administrative units using SearchString parameter

```powershell
Connect-Entra -Scopes 'AdministrativeUnit.Read.All'
Get-EntraDeletedAdministrativeUnit -SearchString 'Americas Administrative Unit' | Select-Object Id, DisplayName, MembershipType, Visibility, DeletedDateTime, DeletionAgeInDays | Format-Table -AutoSize
```

```Output
Id                                   DisplayName                   MembershipType     Visibility         DeletedDateTime           DeletionAgeInDays
--                                   -----------                   --------------     ----------         ---------------           -----------------
gggggggg-8888-9999-aaaa-hhhhhhhhhhhh Americas Administrative Unit   Dynamic           HiddenMembership   2/12/2025 12:40:52 PM     10
```

This cmdlet retrieves deleted administrative units using SearchString parameter.

### Example 5: Get deleted administrative units filter by display name

```powershell
Connect-Entra -Scopes 'AdministrativeUnit.Read.All'
Get-EntraDeletedAdministrativeUnit -Filter "DisplayName eq 'Americas Administrative Unit'" | Select-Object Id, DisplayName, MembershipType, Visibility, DeletedDateTime, DeletionAgeInDays | Format-Table -AutoSize
```

```Output
Id                                   DisplayName                   MembershipType     Visibility         DeletedDateTime           DeletionAgeInDays
--                                   -----------                   --------------     ----------         ---------------           -----------------
gggggggg-8888-9999-aaaa-hhhhhhhhhhhh Americas Administrative Unit   Dynamic           HiddenMembership   2/12/2025 12:40:52 PM     10
```

This cmdlet retrieves deleted administrative units having specified display name.

### Example 6: Get deleted administrative unit by AdministrativeUnitId

```powershell
Connect-Entra -Scopes 'AdministrativeUnit.Read.All'
Get-EntraDeletedAdministrativeUnit -AdministrativeUnitId 'gggggggg-8888-9999-aaaa-hhhhhhhhhhhh' | Select-Object Id, DisplayName, MembershipType, Visibility, DeletedDateTime, DeletionAgeInDays | Format-Table -AutoSize
```

```Output
Id                                   DisplayName                   MembershipType     Visibility         DeletedDateTime           DeletionAgeInDays
--                                   -----------                   --------------     ----------         ---------------           -----------------
gggggggg-8888-9999-aaaa-hhhhhhhhhhhh Americas Administrative Unit   Dynamic           HiddenMembership   2/12/2025 12:40:52 PM     10
```

This cmdlet retrieves deleted administrative unit by AdministrativeUnitId.

## Parameters

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

Retrieve only those deleted administrative units that satisfy the filter.

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

### -SearchString

Retrieve only those administrative units that satisfy the -SearchString value.

```yaml
Type: System.String
Parameter Sets: GetVague
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Top

The maximum number of administrative units.

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

Specifies properties to be returned

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

## Inputs

### System.String

System.Nullable\`1\[\[System.Boolean, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089\]\] System.Nullable\`1\[\[System.Int32, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089\]\]

## Outputs

### System.Object

## Notes

## Related links

[Get-EntraAdministrativeUnit](Get-EntraAdministrativeUnit.md)
