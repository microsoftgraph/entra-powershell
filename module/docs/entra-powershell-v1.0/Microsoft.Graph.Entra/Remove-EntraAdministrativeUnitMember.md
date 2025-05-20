---
title: Remove-EntraAdministrativeUnitMember
description: This article provides details on the Remove-EntraAdministrativeUnitMember command.

ms.topic: reference
ms.date: 07/17/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Remove-EntraAdministrativeUnitMember

schema: 2.0.0
---

# Remove-EntraAdministrativeUnitMember

## Synopsis

Removes an administrative unit member.

## Syntax

```powershell
Remove-EntraAdministrativeUnitMember
 -AdministrativeUnitId <String>
 -MemberId <String>
 [<CommonParameters>]
```

## Description

The `Remove-EntraAdministrativeUnitMember` cmdlet removes an administrative unit member in Microsoft Entra ID. Specify `AdministrativeUnitId` and `MemberId` to remove an administrative unit member.

To remove a member from an administrative unit, the calling principal must have at least the Privileged Role Administrator role in Microsoft Entra.

## Examples

### Example 1: Remove an administrative unit member

```powershell
Connect-Entra -Scopes 'AdministrativeUnit.Read.All'
$administrativeUnit = Get-EntraAdministrativeUnit -Filter "DisplayName eq 'Pacific Administrative Unit'"
$adminUnitMember = Get-EntraAdministrativeUnitMember -AdministrativeUnitId $administrativeUnit.Id | Select-Object Id, DisplayName,'@odata.type' | Where-Object {$_.DisplayName -eq 'Saywer Miller'}
Remove-EntraAdministrativeUnitMember -AdministrativeUnitId $administrativeUnit.Id -MemberId $adminUnitMember.Id
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

[Add-EntraAdministrativeUnitMember](Add-EntraAdministrativeUnitMember.md)

[Get-EntraAdministrativeUnitMember](Get-EntraAdministrativeUnitMember.md)

[New-EntraAdministrativeUnit](New-EntraAdministrativeUnit.md)
