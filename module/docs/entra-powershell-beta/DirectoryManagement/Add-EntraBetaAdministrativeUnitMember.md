---
author: msewaweru
description: This article provides details on the Add-EntraBetaAdministrativeUnitMember command.
external help file: Microsoft.Entra.Beta.DirectoryManagement-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 02/05/2025
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Add-EntraBetaAdministrativeUnitMember
schema: 2.0.0
title: Add-EntraBetaAdministrativeUnitMember
---

# Add-EntraBetaAdministrativeUnitMember

## Synopsis

Adds an administrative unit member.

## Syntax

```powershell
Add-EntraBetaAdministrativeUnitMember
 -MemberId <String>
 -AdministrativeUnitId <String>
 [<CommonParameters>]
```

## Description

The `Add-EntraBetaAdministrativeUnitMember` cmdlet adds a Microsoft Entra ID administrative unit member.

Administrative units enable more granular management of permissions and access, particularly in large organizations or where administrative responsibilities are divided across departments or regions.

In delegated scenarios, adding a user, group, or device to an administrative unit requires:

- Privileged Role Administrator

## Examples

### Example 1: Add an administrative unit member

```powershell
Connect-Entra -Scopes 'AdministrativeUnit.ReadWrite.All'
$administrativeUnit = Get-EntraBetaAdministrativeUnit -Filter "DisplayName eq '<administrativeunit-display-name>'"
$user = Get-EntraBetaUser -UserId 'SawyerM@contoso.com'
Add-EntraBetaAdministrativeUnitMember -AdministrativeUnitId $administrativeUnit.Id -MemberId $user.Id
```

This example demonstrates adding an administrative unit member. Use `Get-EntraBetaAdministrativeUnit` to find the administrative unit ID and `Get-EntraBetaUser` to find the user ID.

- `AdministrativeUnitId` parameter specifies the ID of an administrative unit.
- `MemberId` parameter specifies the ID of the user you want to add as a member of the administrative unit.

### Example 2: Add a group to an administrative unit

```powershell
Connect-Entra -Scopes 'AdministrativeUnit.ReadWrite.All'
$administrativeUnit = Get-EntraBetaAdministrativeUnit -Filter "DisplayName eq '<administrativeunit-display-name>'"
$group = Get-EntraBetaGroup -SearchString 'Sales and Marketing'
Add-EntraBetaAdministrativeUnitMember -AdministrativeUnitId $administrativeUnit.Id -MemberId $group.Id
```

This example demonstrates adding an administrative unit member. Use `Get-EntraBetaAdministrativeUnit` to find the administrative unit ID and `Get-EntraBetaGroup` to find the group ID.

- `AdministrativeUnitId` parameter specifies the ID of an administrative unit.
- `MemberId` parameter specifies the ID of the group you want to add as a member of the administrative unit.

### Example 3: Add a device to an administrative unit

```powershell
Connect-Entra -Scopes 'AdministrativeUnit.ReadWrite.All'
$administrativeUnit = Get-EntraBetaAdministrativeUnit -Filter "DisplayName eq '<administrativeunit-display-name>'"
$device = Get-EntraBetaDevice -SearchString 'ContosoDesktop01'
Add-EntraBetaAdministrativeUnitMember -AdministrativeUnitId $administrativeUnit.Id -MemberId $device.Id
```

This example demonstrates adding an administrative unit member. Use `Get-EntraBetaAdministrativeUnit` to find the administrative unit ID and `Get-EntraBetaDevice` to find the device ID.

- `AdministrativeUnitId` parameter specifies the ID of an administrative unit.
- `MemberId` parameter specifies the ID of the device you want to add as a member of the administrative unit.

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

### -MemberId

Specifies the unique ID of the specific Microsoft Entra ID object that is assigned as owner/manager/member.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: RefObjectId

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

[Get-EntraBetaAdministrativeUnitMember](Get-EntraBetaAdministrativeUnitMember.md)

[Remove-EntraBetaAdministrativeUnitMember](Remove-EntraBetaAdministrativeUnitMember.md)

[New-EntraBetaAdministrativeUnit](New-EntraBetaAdministrativeUnit.md)
