---
title: Add-EntraBetaAdministrativeUnitMember.
description: This article provides details on the Add-EntraBetaAdministrativeUnitMember command.

ms.service: entra
ms.topic: reference
ms.date: 07/04/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Add-EntraBetaAdministrativeUnitMember

## Synopsis

Adds an administrative unit member.

## Syntax

```powershell
Add-EntraBetaAdministrativeUnitMember 
 -RefObjectId <String> 
 -ObjectId <String>
 [<CommonParameters>]
```

## Description

The `Add-EntraBetaAdministrativeUnitMember` cmdlet adds a Microsoft Entra ID administrative unit member. Specify `RefObjectId` and `ObjectId` parameters to add an administrative unit member.

To add a user, group, or device to an administrative unit, the calling principal must be assigned at least the Privileged Role Administrator Microsoft Entra role.

## Examples

### Example 1: Add an administrative unit member

```powershell
Connect-Entra -Scopes 'AdministrativeUnit.ReadWrite.All'
$params = @{
    RefObjectId = 'bbbbbbbb-1111-2222-3333-cccccccccccc'
    ObjectId = 'dddddddd-2222-2222-3333-cccccccccccc'
}
Add-EntraAdministrativeUnitMember @params
```

This example shows how to add an administrative unit member.

## Parameters

### -ObjectId

Specifies the ID of a Microsoft Entra ID administrative unit.

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
