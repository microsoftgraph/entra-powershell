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
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/New-EntraBetaAdministrativeUnit

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

In delegated scenarios, the signed-in user must be assigned a supported Microsoft Entra role or a custom role that includes the `microsoft.directory/administrativeUnits/allProperties/allTasks` permission. The Privileged Role Administrator role is the least privileged role that meets this requirement.

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

This example demonstrates how to create an administrative unit.

- `-DisplayName` parameter specifies the display name for the Administrative unit object.

### Example 2: Create an administrative unit using '-Description' parameter

```powershell
Connect-Entra -Scopes 'AdministrativeUnit.ReadWrite.All'
$params = @{
    DisplayName = 'Pacific Administrative Unit'
    Description = 'Administrative Unit for Pacific region'
}
New-EntraBetaAdministrativeUnit @params
```

```Output
DeletedDateTime Id                                   Description DisplayName IsMemberManagementRestricted Visibility
--------------- --                                   ----------- ----------- ---------------------------- ----------
                bbbbbbbb-1111-2222-3333-cccccccccccc New AdminiatrativeUnit     test1     False
```

This example demonstrates how to create an administrative unit.

- `-DisplayName` parameter specifies the display name for the Administrative unit object.
- `-Description` parameter specifies the description for the new administrative unit.

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

This example demonstrates how to create an administrative unit.

- `-DisplayName` parameter specifies the display name for the Administrative unit object.
- `-IsMemberManagementRestricted` parameter specifies the management rights on resources in the administrative units should be restricted to ONLY the administrators scoped on the administrative unit object.

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
