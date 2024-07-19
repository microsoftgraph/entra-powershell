---
title: New-EntraBetaAdministrativeUnit
description: This article provides details on the New-EntraBetaAdministrativeUnit command.

ms.topic: reference
ms.date: 07/03/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# New-EntraBetaAdministrativeUnit

## Synopsis

Creates an administrative unit.

## Syntax

```powershell
New-EntraBetaAdministrativeUnit 
 -DisplayName <String>
 [-Description <String>] 
 [-IsMemberManagementRestricted <Boolean>] 
 [<CommonParameters>]
```

## Description

The `New-EntraBetaAdministrativeUnit` cmdlet creates an administrative unit in Microsoft Entra ID. Specify `DisplayName` parameter to create an administrative unit.

## Examples

### Example 1: Create an administrative unit

```powershell
Connect-Entra -Scopes 'AdministrativeUnit.ReadWrite.All'
New-EntraBetaAdministrativeUnit -DisplayName 'TestAU'
```

```Output
DeletedDateTime Id                                   Description DisplayName IsMemberManagementRestricted Visibility
--------------- --                                   ----------- ----------- ---------------------------- ----------
                aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb             TestAU      False
```

This command creates an administrative unit.

### Example 2: Create an administrative unit using '-Description' parameter

```powershell
Connect-Entra -Scopes 'AdministrativeUnit.ReadWrite.All'
$params = @{
    DisplayName = 'test111'
    Description = 'New AdministrativeUnit'
}
New-EntraBetaAdministrativeUnit @params
```

```Output
DeletedDateTime Id                                   Description DisplayName IsMemberManagementRestricted Visibility
--------------- --                                   ----------- ----------- ---------------------------- ----------
                bbbbbbbb-1111-2222-3333-cccccccccccc New AdminiatrativeUnit     test111     False
```

### Example 3: Create an administrative unit using '-IsMemberManagementRestricted' parameter

```powershell
Connect-Entra -Scopes 'AdministrativeUnit.ReadWrite.All'
$params = @{
    DisplayName = 'NewUnit'
    IsMemberManagementRestricted = $true
}
New-EntraBetaAdministrativeUnit @params
```

```Output
DeletedDateTime Id                                   Description DisplayName IsMemberManagementRestricted Visibility
--------------- --                                   ----------- ----------- ---------------------------- ----------
                cccccccc-2222-3333-4444-dddddddddddd             NewUnit     True
```

This command creates an administrative unit.

## Parameters

### -Description

Specifies a description for the new administrative unit.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DisplayName

Specifies the display name of the new administrative unit.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IsMemberManagementRestricted

Indicates whether the management rights on resources in the administrative units should be restricted to ONLY the administrators scoped on the administrative unit object.
If no value is specified, it defaults to false.

```yaml
Type: System.Boolean
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

[Get-EntraBetaAdministrativeUnit](Get-EntraBetaAdministrativeUnit.md)

[Remove-EntraBetaAdministrativeUnit](Remove-EntraBetaAdministrativeUnit.md)

[Set-EntraBetaAdministrativeUnit](Set-EntraBetaAdministrativeUnit.md)
