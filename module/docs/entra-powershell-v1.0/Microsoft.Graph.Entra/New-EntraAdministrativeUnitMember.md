---
title: New-EntraAdministrativeUnitMember
description: This article provides details on the New-EntraAdministrativeUnitMember command.


ms.topic: reference
ms.date: 07/19/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/New-EntraAdministrativeUnitMember

schema: 2.0.0
---

# New-EntraAdministrativeUnitMember

## Synopsis

Adds an administrative unit member.

## Syntax

```powershell
New-EntraAdministrativeUnitMember
 -RefObjectId <String>
 -AdministrativeUnitId <String>
 [<CommonParameters>]
```

## Description

The `New-EntraAdministrativeUnitMember` cmdlet adds a Microsoft Entra ID administrative unit member.

Administrative units enable more granular management of permissions and access, particularly in large organizations or where administrative responsibilities are divided across departments or regions.

To add a user, group, or device to an administrative unit, the calling principal must be assigned at least the Privileged Role Administrator Microsoft Entra role.

## Examples

### Example 1: Add user as an administrative unit member

```powershell
Connect-Entra -Scopes 'AdministrativeUnit.ReadWrite.All'
$administrativeUnit = Get-EntraAdministrativeUnit -Filter "DisplayName eq '<administrativeunit-display-name>'"
$user = Get-EntraUser -UserId 'SawyerM@contoso.com'
New-EntraAdministrativeUnitMember -AdministrativeUnitId $administrativeUnit.Id -RefObjectId $user.Id
```

This example demonstrates adding an administrative unit member. Use `Get-EntraAdministrativeUnit` to find the administrative unit ID and `Get-EntraUser` to find the user ID.

- `AdministrativeUnitId` parameter specifies the ID of an administrative unit.
- `RefObjectId` parameter specifies the ID of the user or group you want to add as a member of the administrative unit.

## Parameters

### -AdministrativeUnitId

Specifies the ID of a Microsoft Entra ID administrative unit.

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

### -RefObjectId

Specifies the unique ID of the specific Microsoft Entra ID object that are as owner/manager/member.

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

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

`Add-EntraAdministrativeUnitMember` is an alias for `New-EntraAdministrativeUnitMember`.

## Related Links

[Get-EntraAdministrativeUnitMember](Get-EntraAdministrativeUnitMember.md)

[Remove-EntraAdministrativeUnitMember](Remove-EntraAdministrativeUnitMember.md)

[New-EntraAdministrativeUnit](New-EntraAdministrativeUnit.md)
