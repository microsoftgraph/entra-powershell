---
title: Get-EntraBetaUserAdministrativeUnit
description: This article provides details on the Get-EntraBetaUserAdministrativeUnit command.

ms.topic: reference
ms.date: 12/02/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Entra.Beta.Users-Help.xml
Module Name: Microsoft.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Get-EntraBetaUserAdministrativeUnit

schema: 2.0.0
---

# Get-EntraBetaUserAdministrativeUnit

## Synopsis

Retrieves the list of administrative units a user belongs to.

## Syntax

### GetQuery (Default)

```powershell
Get-EntraBetaUserAdministrativeUnit
 -UserId <String>
 [-All]
 [-Top <Int32>]
 [-Property <String[]>]
 [<CommonParameters>]
```

### GetById

```powershell
Get-EntraBetaUserAdministrativeUnit
 -UserId <String>
 -AdministrativeUnitId <String>
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

The `Get-EntraBetaUserAdministrativeUnit` cmdlet retrieves a list of administrative units to which a user belongs.

## Examples

### Example 1: Get a list of administrative units to which a specific user belongs

```powershell
Connect-Entra -Scopes 'AdministrativeUnit.Read.All'
Get-EntraBetaUserAdministrativeUnit -UserId 'SawyerM@contoso.com'
```

```Output
DeletedDateTime Id                                   Description                            DisplayName             Visibility
--------------- --                                   -----------                            -----------             ----------
                dddddddd-3333-4444-5555-eeeeeeeeeeee Pacific Administrative Unit            Pacific Admin Unit
                aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb Engineering Administrative Unit        Engineering Admin Unit
```

This cmdlet retrieves a list of administrative units to which a specific user belongs.

### Example 2: Get a list of administrative units to which a specific user belongs using the All parameter

```powershell
Connect-Entra -Scopes 'AdministrativeUnit.Read.All'
Get-EntraBetaUserAdministrativeUnit -UserId 'SawyerM@contoso.com' -All
```

```Output
DeletedDateTime Id                                   Description                            DisplayName             Visibility
--------------- --                                   -----------                            -----------             ----------
                dddddddd-3333-4444-5555-eeeeeeeeeeee Pacific Administrative Unit            Pacific Admin Unit
                aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb Engineering Administrative Unit        Engineering Admin Unit
```

This cmdlet retrieves a list of administrative units to which a specific user belongs using the All parameter.

### Example 3: Get an administrative unit to which a specific user belongs

```powershell
Connect-Entra -Scopes 'AdministrativeUnit.Read.All'
Get-EntraBetaUserAdministrativeUnit -UserId 'SawyerM@contoso.com' -Top 1
```

```Output
DeletedDateTime Id                                   Description                            DisplayName             Visibility
--------------- --                                   -----------                            -----------             ----------
                dddddddd-3333-4444-5555-eeeeeeeeeeee Pacific Administrative Unit            Pacific Admin Unit
                aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb Engineering Administrative Unit        Engineering Admin Unit
```

This cmdlet retrieves an administrative unit to which a specific user belongs. You can use `-Limit` as an alias for `-Top`.

### Example 4: Get a list of administrative units to which a specific user belongs using the Administrative Unit ID parameter

```powershell
Connect-Entra -Scopes 'AdministrativeUnit.Read.All'
$administrativeUnit = Get-EntraBetaAdministrativeUnit -Filter "DisplayName eq 'Pacific Admin Unit'"
Get-EntraBetaUserAdministrativeUnit -UserId 'SawyerM@contoso.com' -AdministrativeUnitId $administrativeUnit.Id
```

```Output
DeletedDateTime Id                                   Description                            DisplayName             Visibility
--------------- --                                   -----------                            -----------             ----------
                dddddddd-3333-4444-5555-eeeeeeeeeeee Pacific Administrative Unit            Pacific Admin Unit
```

This cmdlet retrieves a list of administrative units to which a specific user belongs using the Administrative Unit ID parameter.

- `-AdministrativeUnitId` parameter specifies the administrative unit ID.

## Parameters

### -UserId

Specifies the ID of a user (as a UserPrincipalName or ObjectId) in Microsoft Entra ID.

```yaml
Type: System.String
Parameter Sets: GetQuery
Aliases: ObjectId, UPN, Identity, UserPrincipalName

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

The maximum number of administrative units a user belongs to.

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

### -AdministrativeUnitId

The unique ID of the administrative unit.

```yaml
Type: System.String
Parameter Sets: GetQuery
Aliases: DirectoryObjectId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

### System.Object

## Notes

## Related links

[Get-EntraBetaUserMembership](Get-EntraBetaUserMembership.md)
