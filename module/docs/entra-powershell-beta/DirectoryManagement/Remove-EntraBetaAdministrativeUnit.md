---
description: This article provides details on the Remove-EntraBetaAdministrativeUnit command.
external help file: Microsoft.Entra.Beta.DirectoryManagement-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 02/05/2025
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Remove-EntraBetaAdministrativeUnit
schema: 2.0.0
title: Remove-EntraBetaAdministrativeUnit
---

# Remove-EntraBetaAdministrativeUnit

## SYNOPSIS

Removes an administrative unit.

## SYNTAX

```powershell
Remove-EntraBetaAdministrativeUnit
 -AdministrativeUnitId <String>
 [<CommonParameters>]
```

## DESCRIPTION

The `Remove-EntraBetaAdministrativeUnit` cmdlet removes an administrative unit from Microsoft Entra ID. Specify `AdministrativeUnitId` parameter to delete an administrative unit.

To delete an administrative unit, the calling principal must have at least the Privileged Role Administrator role in Microsoft Entra.

## EXAMPLES

### Example 1: Remove an administrative unit

```powershell
Connect-Entra -Scopes 'AdministrativeUnit.ReadWrite.All'
$administrativeUnit = Get-EntraBetaAdministrativeUnit -Filter "DisplayName eq '<administrative-unit-display-name>'"
Remove-EntraBetaAdministrativeUnit -AdministrativeUnitId $administrativeUnit.Id
```

This command removes the specified administrative unit from Microsoft Entra ID.

- `-AdministrativeUnitId` parameter specifies the ID of an administrative unit.

### Example 2: Remove an administrative unit through pipelining

```powershell
Connect-Entra -Scopes 'AdministrativeUnit.ReadWrite.All'
Get-EntraBetaAdministrativeUnit -Filter "DisplayName eq '<administrative-unit-display-name>'" | Remove-EntraBetaAdministrativeUnit
```

This command removes the specified administrative unit from Microsoft Entra ID.

## PARAMETERS

### -AdministrativeUnitId

Specifies the ID of an administrative unit in Microsoft Entra ID.

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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[New-EntraBetaAdministrativeUnit](New-EntraBetaAdministrativeUnit.md)

[Set-EntraBetaAdministrativeUnit](Set-EntraBetaAdministrativeUnit.md)

[Get-EntraBetaAdministrativeUnit](Get-EntraBetaAdministrativeUnit.md)
