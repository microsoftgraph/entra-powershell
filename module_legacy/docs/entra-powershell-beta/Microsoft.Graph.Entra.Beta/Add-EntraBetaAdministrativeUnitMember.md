---
title: Add-EntraBetaAdministrativeUnitMember
description: This article provides details on the Add-EntraBetaAdministrativeUnitMember command.


ms.topic: reference
ms.date: 08/05/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: mwongerapk
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Add-EntraBetaAdministrativeUnitMember

schema: 2.0.0
---

# Add-EntraBetaAdministrativeUnitMember

## Synopsis

Adds an administrative unit member.

## Syntax

```powershell
Add-EntraBetaAdministrativeUnitMember
 -RefObjectId <String>
 -AdministrativeUnitId <String>
 [<CommonParameters>]
```

## Description

The `Add-EntraBetaAdministrativeUnitMember` cmdlet adds a Microsoft Entra ID administrative unit member.

Administrative units enable more granular management of permissions and access, particularly in large organizations or where administrative responsibilities are divided across departments or regions.

To add a user, group, or device to an administrative unit, the calling principal must be assigned at least the Privileged Role Administrator Microsoft Entra role.

## Examples

### Example 1: Add an administrative unit member

```powershell
Connect-Entra -Scopes 'AdministrativeUnit.ReadWrite.All'
$AdministrativeUnit = Get-EntraBetaAdministrativeUnit -Filter "DisplayName eq '<administrativeunit-display-name>'"
$User = Get-EntraBetaUser -SearchString '<user-name>'
$params = @{
    AdministrativeUnitId = $AdministrativeUnit.ObjectId
    RefObjectId = $User.ObjectId
}
Add-EntraBetaAdministrativeUnitMember @params
```

This example shows how to add an administrative unit member. You can use the command `Get-EntraBetaAdministrativeUnit` to get administrative unit ID. You can use the command `Get-EntraBetaUser` to get user ID.

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

Specifies the unique ID of the specific Microsoft Entra ID object that is assigned as owner/manager/member.

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

## Related Links

[Get-EntraBetaAdministrativeUnitMember](Get-EntraBetaAdministrativeUnitMember.md)

[New-EntraBetaAdministrativeUnitMember](New-EntraBetaAdministrativeUnitMember.md)

[Remove-EntraBetaAdministrativeUnitMember](Remove-EntraBetaAdministrativeUnitMember.md)
