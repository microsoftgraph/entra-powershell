---
title: Remove-EntraBetaAdministrativeUnit
description: This article provides details on the Remove-EntraBetaAdministrativeUnit command.

ms.topic: reference
ms.date: 07/03/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Remove-EntraBetaAdministrativeUnit

schema: 2.0.0
---

# Remove-EntraBetaAdministrativeUnit

## Synopsis

Removes an administrative unit.

## Syntax

```powershell
Remove-EntraBetaAdministrativeUnit
 -AdministrativeUnitId <String>
 [<CommonParameters>]
```

## Description

The `Remove-EntraBetaAdministrativeUnit` cmdlet removes an administrative unit from Microsoft Entra ID. Specify `AdministrativeUnitId` parameter to delete an administrative unit.

To delete an administrative unit, the calling principal must have at least the Privileged Role Administrator role in Microsoft Entra.

## Examples

### Example 1: Remove an administrative unit

```powershell
Connect-Entra -Scopes 'AdministrativeUnit.ReadWrite.All'
$AdministrativeUnit = Get-EntraBetaAdministrativeUnit -Filter "DisplayName eq '<administrative-unit-display-name>'"
Remove-EntraBetaAdministrativeUnit -AdministrativeUnitId $AdministrativeUnit.ObjectId  
```

This command removes the specified administrative unit from Microsoft Entra ID.

- `-AdministrativeUnitId` parameter specifies the ID of an administrative unit.

## Parameters

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

## Inputs

## Outputs

## Notes

## Related Links

[New-EntraBetaAdministrativeUnit](New-EntraBetaAdministrativeUnit.md)

[Set-EntraBetaAdministrativeUnit](Set-EntraBetaAdministrativeUnit.md)

[Get-EntraBetaAdministrativeUnit](Get-EntraBetaAdministrativeUnit.md)
