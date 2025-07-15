---
description: This article provides details on the Remove-EntraAdministrativeUnitMember command.
external help file: Microsoft.Entra.DirectoryManagement-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra
ms.author: eunicewaweru
ms.date: 07/17/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Remove-EntraAdministrativeUnitMember
schema: 2.0.0
title: Remove-EntraAdministrativeUnitMember
---

# Remove-EntraAdministrativeUnitMember

## SYNOPSIS

Removes an administrative unit member.

## SYNTAX

```powershell
Remove-EntraAdministrativeUnitMember
 -AdministrativeUnitId <String>
 -MemberId <String>
 [<CommonParameters>]
```

## DESCRIPTION

The `Remove-EntraAdministrativeUnitMember` cmdlet removes an administrative unit member in Microsoft Entra ID. Specify `AdministrativeUnitId` and `MemberId` to remove an administrative unit member.

To remove a member from an administrative unit, the calling principal must have at least the Privileged Role Administrator role in Microsoft Entra.

## EXAMPLES

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

## PARAMETERS

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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Add-EntraAdministrativeUnitMember](Add-EntraAdministrativeUnitMember.md)

[Get-EntraAdministrativeUnitMember](Get-EntraAdministrativeUnitMember.md)

[New-EntraAdministrativeUnit](New-EntraAdministrativeUnit.md)
