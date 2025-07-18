---
title: Set-EntraAdministrativeUnit
description: This article provides details on the Set-EntraAdministrativeUnit command.

ms.topic: reference
ms.date: 06/19/2023
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: mwongerapk
author: msewaweru

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Set-EntraAdministrativeUnit

schema: 2.0.0
---

# Set-EntraAdministrativeUnit

## Synopsis

Updates an administrative unit.

## Syntax

```powershell
Set-EntraAdministrativeUnit
 -AdministrativeUnitId <String>
 [-Description <String>]
 [-DisplayName <String>]
 [<CommonParameters>]
```

## Description

The `Set-EntraAdministrativeUnit` cmdlet updates an administrative unit in Microsoft Entra ID. Specify `AdministrativeUnitId` parameter to update a specific administrative unit.

In delegated scenarios, the signed-in user must be assigned a supported Microsoft Entra role or a custom role with the `microsoft.directory/administrativeUnits/allProperties/allTasks` permission.

The Privileged Role Administrator is the least privileged role required for this operation.

## Examples

### Example 1: Update DisplayName

```powershell
Connect-Entra -Scopes 'AdministrativeUnit.ReadWrite.All'
$AdministrativeUnit = Get-EntraAdministrativeUnit -Filter "DisplayName eq '<administrative-unit-display-name>'"
$params = @{
    AdministrativeUnitId =  $AdministrativeUnit.ObjectId
    DisplayName = 'UpdatedAU'
}
Set-EntraAdministrativeUnit @params
```

This Command update DisplayName of specific administrative unit.

- `-AdministrativeUnitId` parameter specifies the Id of an administrative unit.
- `-DisplayName` parameter specifies the display name for the administrative unit.

### Example 2: Update Description

```powershell
Connect-Entra -Scopes 'AdministrativeUnit.ReadWrite.All'
$AdministrativeUnit = Get-EntraAdministrativeUnit -Filter "DisplayName eq '<administrative-unit-display-name>'"
$params = @{
    AdministrativeUnitId = $AdministrativeUnit.ObjectId
    Description = 'Updated AU Description'
}
Set-EntraAdministrativeUnit @params
```

This example shows how to update the description of a specific administrative unit.

- `-AdministrativeUnitId` parameter specifies the Id of an administrative unit.
- `-Description` parameter specifies the description for the administrative unit.

## Parameters

### -Description

Specifies a description.

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

Specifies a display name.

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

### -AdministrativeUnitId

Specifies the Id of an administrative unit in Microsoft Entra ID.

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

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related Links

[Get-EntraAdministrativeUnit](Get-EntraAdministrativeUnit.md)

[New-EntraAdministrativeUnit](New-EntraAdministrativeUnit.md)

[Remove-EntraAdministrativeUnit](Remove-EntraAdministrativeUnit.md)
