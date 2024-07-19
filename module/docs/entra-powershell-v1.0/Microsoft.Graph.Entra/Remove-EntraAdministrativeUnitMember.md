---
title: Remove-EntraAdministrativeUnitMember
description: This article provides details on the Remove-EntraAdministrativeUnitMember command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Remove-EntraAdministrativeUnitMember

## Synopsis

Removes an administrative unit member.

## Syntax

```powershell
Remove-EntraAdministrativeUnitMember 
 -ObjectId <String> 
 -MemberId <String>
 [<CommonParameters>]
```

## Description

The `Remove-EntraAdministrativeUnitMember` cmdlet removes an administrative unit member in Microsoft Entra ID. Specify `ObjectId` and `MemberId` to Remove an administrative unit member.

## Examples

### Example 1: Remove an administrative unit member

```powershell
Connect-Entra -Scopes 'AdministrativeUnit.Read.All'
Remove-EntraAdministrativeUnitMember -ObjectId 'bbbbbbbb-1111-2222-3333-cccccccccccc' -MemberId 'eeeeeeee-4444-5555-6666-ffffffffffff'
```

This command removes a specified member (user or group) from a specified administrative unit.

- `-ObjectId` - specifies the unique identifier (ID) of the administrative unit from which you want to remove a member. In this example, `bbbbbbbb-1111-2222-3333-cccccccccccc` represents the ObjectId of the administrative unit.

- `-MemberId` - specifies the unique identifier (Object ID) of the user or group you want to remove from the administrative unit. In this example, `eeeeeeee-4444-5555-6666-ffffffffffff` is the Object ID of the member being removed.

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

### -ObjectId

Specifies the ID of an administrative unit in Microsoft Entra ID.

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

[Add-EntraAdministrativeUnitMember](Add-EntraAdministrativeUnitMember.md)

[Remove-EntraAdministrativeUnitMember](Remove-EntraAdministrativeUnitMember.md)
