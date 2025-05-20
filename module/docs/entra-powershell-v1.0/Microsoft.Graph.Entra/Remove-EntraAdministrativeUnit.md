---
title: Remove-EntraAdministrativeUnit
description: This article provides details on the Remove-EntraAdministrativeUnit command.

ms.topic: reference
ms.date: 07/19/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Remove-EntraAdministrativeUnit

schema: 2.0.0
---

# Remove-EntraAdministrativeUnit

## Synopsis

Removes an administrative unit.

## Syntax

```powershell
Remove-EntraAdministrativeUnit
 -AdministrativeUnitId <String>
 [<CommonParameters>]
```

## Description

The `Remove-EntraAdministrativeUnit` cmdlet removes an administrative unit from Microsoft Entra ID. Specify `AdministrativeUnitId` parameter to delete an administrative unit.

To delete an administrative unit, the calling principal must have at least the Privileged Role Administrator role in Microsoft Entra.

## Examples

### Example 1: Remove an administrative unit

```powershell
Connect-Entra -Scopes 'AdministrativeUnit.ReadWrite.All'
$administrativeUnit = Get-EntraAdministrativeUnit -Filter "DisplayName eq '<administrative-unit-display-name>'"
Remove-EntraAdministrativeUnit -AdministrativeUnitId $administrativeUnit.Id
```

This command removes the specified administrative unit from Microsoft Entra ID.

- `-AdministrativeUnitId` parameter specifies the ID of an administrative unit.

## Parameters

### -AdministrativeUnitId

Specifies the ID of an administrative unit in Microsoft Entra ID.

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

## Related links

[New-EntraAdministrativeUnit](New-EntraAdministrativeUnit.md)

[Get-EntraAdministrativeUnit](Get-EntraAdministrativeUnit.md)

[Set-EntraAdministrativeUnit](Set-EntraAdministrativeUnit.md)
