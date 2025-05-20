---
title: Remove-EntraBetaAdministrativeUnitMember
description: This article provides details on the Remove-EntraBetaAdministrativeUnitMember command.

ms.topic: reference
ms.date: 07/04/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru 

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Remove-EntraBetaAdministrativeUnitMember

schema: 2.0.0
---

# Remove-EntraBetaAdministrativeUnitMember

## Synopsis

Removes an administrative unit member.

## Syntax

```powershell
Remove-EntraBetaAdministrativeUnitMember
 -AdministrativeUnitId <String>
 -MemberId <String>
 [<CommonParameters>]
```

## Description

The `Remove-EntraBetaAdministrativeUnitMember` cmdlet removes an administrative unit member in Microsoft Entra ID. Specify `AdministrativeUnitId` and `MemberId` to remove an administrative unit member.

To remove a member from an administrative unit, the calling principal must have at least the Privileged Role Administrator role in Microsoft Entra.

## Examples

### Example 1: Remove an administrative unit member

```powershell
Connect-Entra -Scopes 'AdministrativeUnit.Read.All'
$AdministrativeUnit = Get-EntraBetaAdministrativeUnit -Filter "DisplayName eq '<administrativeunit-display-name>'"
$params = @{
    AdministrativeUnitId = $AdministrativeUnit.ObjectId
    MemberId = 'eeeeeeee-4444-5555-6666-ffffffffffff'
}
Remove-EntraBetaAdministrativeUnitMember @params
```

This command removes a specified member (user or group) from a specified administrative unit.

- `-AdministrativeUnitId` parameter specifies the ID of an administrative unit.
- `-MemberId` parameter specifies the ID of the administrative unit member.

## Parameters

### -MemberId

Specifies the ID of the administrative unit member.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

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

[Add-EntraBetaAdministrativeUnitMember](Add-EntraBetaAdministrativeUnitMember.md)

[Get-EntraBetaAdministrativeUnitMember](Get-EntraBetaAdministrativeUnitMember.md)

[New-EntraBetaAdministrativeUnitMember](New-EntraBetaAdministrativeUnitMember.md)
