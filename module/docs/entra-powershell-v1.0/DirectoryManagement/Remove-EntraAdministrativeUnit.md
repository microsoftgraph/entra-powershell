---
author: msewaweru
description: This article provides details on the Remove-EntraAdministrativeUnit command.
external help file: Microsoft.Entra.DirectoryManagement-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra
ms.author: eunicewaweru
ms.date: 02/05/2025
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Remove-EntraAdministrativeUnit
schema: 2.0.0
title: Remove-EntraAdministrativeUnit
---

# Remove-EntraAdministrativeUnit

## SYNOPSIS

Removes an administrative unit.

## SYNTAX

```powershell
Remove-EntraAdministrativeUnit
 -AdministrativeUnitId <String>
 [<CommonParameters>]
```

## DESCRIPTION

The `Remove-EntraAdministrativeUnit` cmdlet removes an administrative unit from Microsoft Entra ID. Specify `AdministrativeUnitId` parameter to delete an administrative unit.

To delete an administrative unit, the calling principal must have at least the Privileged Role Administrator role in Microsoft Entra.

## EXAMPLES

### Example 1: Remove an administrative unit

```powershell
Connect-Entra -Scopes 'AdministrativeUnit.ReadWrite.All'
$administrativeUnit = Get-EntraAdministrativeUnit -Filter "DisplayName eq '<administrative-unit-display-name>'"
Remove-EntraAdministrativeUnit -AdministrativeUnitId $administrativeUnit.Id
```

This command removes the specified administrative unit from Microsoft Entra ID.

- `-AdministrativeUnitId` parameter specifies the ID of an administrative unit.

### Example 2: Remove an administrative unit through pipelining

```powershell
Connect-Entra -Scopes 'AdministrativeUnit.ReadWrite.All'
Get-EntraAdministrativeUnit -Filter "DisplayName eq '<administrative-unit-display-name>'" | Remove-EntraAdministrativeUnit
```

This command removes the specified administrative unit from Microsoft Entra ID.

## PARAMETERS

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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[New-EntraAdministrativeUnit](New-EntraAdministrativeUnit.md)

[Get-EntraAdministrativeUnit](Get-EntraAdministrativeUnit.md)

[Set-EntraAdministrativeUnit](Set-EntraAdministrativeUnit.md)
