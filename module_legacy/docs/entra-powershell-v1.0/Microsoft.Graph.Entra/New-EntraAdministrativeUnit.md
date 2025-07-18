---
title: New-EntraAdministrativeUnit
description: This article provides details on the New-EntraAdministrativeUnit command.


ms.topic: reference
ms.date: 07/25/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: mwongerapk
author: msewaweru

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/New-EntraAdministrativeUnit

schema: 2.0.0
---

# New-EntraAdministrativeUnit

## Synopsis

Creates an administrative unit.

## Syntax

```powershell
New-EntraAdministrativeUnit
 [-Description <String>]
 -DisplayName <String>
 [<CommonParameters>]
```

## Description

The `New-EntraAdministrativeUnit` cmdlet creates an administrative unit in Microsoft Entra ID. Specify `DisplayName` parameter to create an administrative unit.

In delegated scenarios, the signed-in user must be assigned a supported Microsoft Entra role or a custom role that includes the `microsoft.directory/administrativeUnits/allProperties/allTasks` permission. The Privileged Role Administrator role is the least privileged role that meets this requirement.

## Examples

### Example 1: Create an administrative unit

```powershell
Connect-Entra -Scopes 'AdministrativeUnit.ReadWrite.All'
New-EntraAdministrativeUnit -DisplayName 'TestAU'
```

```Output
DeletedDateTime Id                                   Description DisplayName Visibility
--------------- --                                   ----------- ----------- ----------
                bbbbbbbb-1111-2222-3333-cccccccccccc             TestAU
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

New-EntraAdministrativeUnit @params
```

```Output
DeletedDateTime Id                                   Description DisplayName IsMemberManagementRestricted Visibility
--------------- --                                   ----------- ----------- ---------------------------- ----------
                bbbbbbbb-1111-2222-3333-cccccccccccc Pacific Administrative Unit     test111     False
```

This example demonstrates how to create an administrative unit.

- `-DisplayName` parameter specifies the display name for the Administrative unit object.
- `-Description` parameter specifies a description for the Administrative unit object.

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

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related Links

[Get-EntraAdministrativeUnit](Get-EntraAdministrativeUnit.md)

[Remove-EntraAdministrativeUnit](Remove-EntraAdministrativeUnit.md)

[Set-EntraAdministrativeUnit](Set-EntraAdministrativeUnit.md)
