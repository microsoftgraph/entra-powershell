---
title: Set-EntraBetaAdministrativeUnit
description: This article provides details on the Set-EntraBetaAdministrativeUnit command.

ms.topic: reference
ms.date: 07/03/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Set-EntraBetaAdministrativeUnit

schema: 2.0.0
---

# Set-EntraBetaAdministrativeUnit

## Synopsis

Updates an administrative unit.

## Syntax

```powershell
Set-EntraBetaAdministrativeUnit
 -AdministrativeUnitId <String>
 [-IsMemberManagementRestricted <Boolean>]
 [-Description <String>]
 [-DisplayName <String>]
 [<CommonParameters>]
```

## Description

The `Set-EntraBetaAdministrativeUnit` cmdlet updates an administrative unit in Microsoft Entra ID. Specify `AdministrativeUnitId` parameter to update a specific administrative unit.

In delegated scenarios, the signed-in user must be assigned a supported Microsoft Entra role or a custom role with the `microsoft.directory/administrativeUnits/allProperties/allTasks` permission.

The Privileged Role Administrator is the least privileged role required for this operation.

## Examples

### Example 1: Update DisplayName

```powershell
Connect-Entra -Scopes 'AdministrativeUnit.ReadWrite.All'
$AdministrativeUnit = Get-EntraBetaAdministrativeUnit -Filter "DisplayName eq '<administrative-unit-display-name>'"
$params = @{
    AdministrativeUnitId = $AdministrativeUnit.ObjectId
    DisplayName = 'UpdatedAU'
}
Set-EntraBetaAdministrativeUnit @params
```

This Command update DisplayName of specific administrative unit.

- `-AdministrativeUnitId` parameter specifies the Id of an administrative unit.
- `-DisplayName` parameter specifies the display name for the administrative unit.

### Example 2: Update Description

```powershell
Connect-Entra -Scopes 'AdministrativeUnit.ReadWrite.All'
$AdministrativeUnit = Get-EntraBetaAdministrativeUnit -Filter "DisplayName eq '<administrative-unit-display-name>'"
$params = @{
    AdministrativeUnitId = $AdministrativeUnit.ObjectId
    Description = 'Updated AU Description'
}
Set-EntraBetaAdministrativeUnit @params
```

This example shows how to update the description of a specific administrative unit.

- `-AdministrativeUnitId` parameter specifies the Id of an administrative unit.
- `-Description` parameter specifies the description for the administrative unit.

### Example 3: Update IsMemberManagementRestricted

```powershell
Connect-Entra -Scopes 'AdministrativeUnit.ReadWrite.All'
$AdministrativeUnit = Get-EntraBetaAdministrativeUnit -Filter "DisplayName eq '<administrative-unit-display-name>'"
$params = @{
    AdministrativeUnitId = $AdministrativeUnit.ObjectId
    IsMemberManagementRestricted = $true
}
Set-EntraBetaAdministrativeUnit @params
```

This example shows how to update the `IsMemberManagementRestricted` setting for a specific administrative unit.

- `-AdministrativeUnitId` parameter specifies the Id of an administrative unit.
- `-IsMemberManagementRestricted` parameter specifies the management rights on resources in the administrative units should be restricted to ONLY the administrators scoped on the administrative unit object.

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

### -IsMemberManagementRestricted

Indicates whether the management rights on resources in the administrative units should be restricted to ONLY the administrators scoped on the administrative unit object.

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

### -AdministrativeUnitId

Specifies the Id of an administrative unit in Microsoft Entra ID.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: Id

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

[Get-EntraBetaAdministrativeUnit](Get-EntraBetaAdministrativeUnit.md)

[New-EntraBetaAdministrativeUnit](New-EntraBetaAdministrativeUnit.md)

[Remove-EntraBetaAdministrativeUnit](Remove-EntraBetaAdministrativeUnit.md)
