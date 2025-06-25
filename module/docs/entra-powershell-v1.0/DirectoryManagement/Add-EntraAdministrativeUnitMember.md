---
author: msewaweru
description: This article provides details on the Add-EntraAdministrativeUnitMember command.
external help file: Microsoft.Entra.DirectoryManagement-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra
ms.author: eunicewaweru
ms.date: 02/05/2025
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Add-EntraAdministrativeUnitMember
schema: 2.0.0
title: Add-EntraAdministrativeUnitMember
---

# Add-EntraAdministrativeUnitMember

## Synopsis

Adds an administrative unit member.

## Syntax

```powershell
Add-EntraAdministrativeUnitMember
 -MemberId <String>
 -AdministrativeUnitId <String>
 [<CommonParameters>]
```

## Description

The `Add-EntraAdministrativeUnitMember` cmdlet adds a Microsoft Entra ID administrative unit member.

Administrative units enable more granular management of permissions and access, particularly in large organizations or where administrative responsibilities are divided across departments or regions.

In delegated scenarios, adding a user, group, or device to an administrative unit requires:

- Privileged Role Administrator

## Examples

### Example 1: Add user as an administrative unit member

```powershell
Connect-Entra -Scopes 'AdministrativeUnit.ReadWrite.All'
$administrativeUnit = Get-EntraAdministrativeUnit -Filter "DisplayName eq '<administrativeunit-display-name>'"
$user = Get-EntraUser -UserId 'SawyerM@contoso.com'
Add-EntraAdministrativeUnitMember -AdministrativeUnitId $administrativeUnit.Id -MemberId $user.Id
```

This example demonstrates adding an administrative unit member. Use `Get-EntraAdministrativeUnit` to find the administrative unit ID and `Get-EntraUser` to find the user ID.

- `AdministrativeUnitId` parameter specifies the ID of an administrative unit.
- `MemberId` parameter specifies the ID of the user or group you want to add as a member of the administrative unit.

### Example 2: Add a group to an administrative unit

```powershell
Connect-Entra -Scopes 'AdministrativeUnit.ReadWrite.All'
$administrativeUnit = Get-EntraAdministrativeUnit -Filter "DisplayName eq '<administrativeunit-display-name>'"
$group = Get-EntraGroup -SearchString 'Sales and Marketing'
Add-EntraAdministrativeUnitMember -AdministrativeUnitId $administrativeUnit.Id -MemberId $group.Id
```

This example demonstrates adding an administrative unit member. Use `Get-EntraAdministrativeUnit` to find the administrative unit ID and `Get-EntraGroup` to find the group ID.

- `AdministrativeUnitId` parameter specifies the ID of an administrative unit.
- `MemberId` parameter specifies the ID of the user or group you want to add as a member of the administrative unit.

### Example 3: Add a device to an administrative unit

```powershell
Connect-Entra -Scopes 'AdministrativeUnit.ReadWrite.All'
$administrativeUnit = Get-EntraAdministrativeUnit -Filter "DisplayName eq '<administrativeunit-display-name>'"
$device = Get-EntraDevice -SearchString 'ContosoDesktop01'
Add-EntraAdministrativeUnitMember -AdministrativeUnitId $administrativeUnit.Id -MemberId $device.Id
```

This example demonstrates adding an administrative unit member. Use `Get-EntraAdministrativeUnit` to find the administrative unit ID and `Get-EntraDevice` to find the device ID.

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

Specifies the unique ID of the specific Microsoft Entra ID object that are as owner/manager/member.

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

[Get-EntraAdministrativeUnitMember](Get-EntraAdministrativeUnitMember.md)

[Remove-EntraAdministrativeUnitMember](Remove-EntraAdministrativeUnitMember.md)

[New-EntraAdministrativeUnit](New-EntraAdministrativeUnit.md)
