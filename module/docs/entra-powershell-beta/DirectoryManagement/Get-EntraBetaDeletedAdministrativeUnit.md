---
description: This article provides details on the Get-EntraBetaDeletedAdministrativeUnit command.
external help file: Microsoft.Entra.Beta.DirectoryManagement-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 02/12/2025
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Get-EntraBetaDeletedAdministrativeUnit
schema: 2.0.0
title: Get-EntraBetaDeletedAdministrativeUnit
---

# Get-EntraBetaDeletedAdministrativeUnit

## SYNOPSIS

Retrieves the list of previously deleted administrative units.

## SYNTAX

### GetQuery (Default)

```powershell
Get-EntraBetaDeletedAdministrativeUnit
 [-Filter <String>]
 [-All]
 [-Top <Int32>]
 [-Property <String[]>]
 [<CommonParameters>]
```

### GetById

```powershell
Get-EntraBetaDeletedAdministrativeUnit
 -AdministrativeUnitId <String>
 [-Property <String[]>]
 [<CommonParameters>]
```

### GetVague

```powershell
Get-EntraBetaDeletedAdministrativeUnit
 [-SearchString <String>]
 [-All]
 [-Property <String[]>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Get-EntraBetaDeletedAdministrativeUnit` cmdlet Retrieves the list of previously deleted administrative units.

## EXAMPLES

### Example 1: Get list of deleted administrative units

```powershell
Connect-Entra -Scopes 'AdministrativeUnit.Read.All'
Get-EntraBetaDeletedAdministrativeUnit | Select-Object Id, DisplayName, MembershipType, Visibility, DeletedDateTime, DeletionAgeInDays | Format-Table -AutoSize
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
Get-EntraBetaDeletedAdministrativeUnit -All | Select-Object Id, DisplayName, MembershipType, Visibility, DeletedDateTime, DeletionAgeInDays | Format-Table -AutoSize
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
Get-EntraBetaDeletedAdministrativeUnit -Top 2 | Select-Object Id, DisplayName, MembershipType, Visibility, DeletedDateTime, DeletionAgeInDays | Format-Table -AutoSize
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
Get-EntraBetaDeletedAdministrativeUnit -SearchString 'Americas Administrative Unit' | Select-Object Id, DisplayName, MembershipType, Visibility, DeletedDateTime, DeletionAgeInDays | Format-Table -AutoSize
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
Get-EntraBetaDeletedAdministrativeUnit -Filter "DisplayName eq 'Americas Administrative Unit'" | Select-Object Id, DisplayName, MembershipType, Visibility, DeletedDateTime, DeletionAgeInDays | Format-Table -AutoSize
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
Get-EntraBetaDeletedAdministrativeUnit -AdministrativeUnitId 'gggggggg-8888-9999-aaaa-hhhhhhhhhhhh' | Select-Object Id, DisplayName, MembershipType, Visibility, DeletedDateTime, DeletionAgeInDays | Format-Table -AutoSize
```

```Output
Id                                   DisplayName                   MembershipType     Visibility         DeletedDateTime           DeletionAgeInDays
--                                   -----------                   --------------     ----------         ---------------           -----------------
gggggggg-8888-9999-aaaa-hhhhhhhhhhhh Americas Administrative Unit   Dynamic           HiddenMembership   2/12/2025 12:40:52 PM     10
```

This cmdlet retrieves deleted administrative unit by AdministrativeUnitId.

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

## INPUTS

### System.String

System.Nullable\`1\[\[System.Boolean, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089\]\] System.Nullable\`1\[\[System.Int32, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089\]\]

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS

[Get-EntraBetaAdministrativeUnit](Get-EntraBetaAdministrativeUnit.md)
