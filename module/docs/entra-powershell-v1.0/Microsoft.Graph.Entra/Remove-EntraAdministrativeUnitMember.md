---
<<<<<<< HEAD
title: Remove-EntraAdministrativeUnitMember.
description: This article provides details on the Remove-EntraAdministrativeUnitMember command.
ms.service: active-directory
ms.topic: reference
ms.date: 06/05/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
=======
title: Remove-EntraAdministrativeUnitMember
description: This article provides details on the Remove-EntraAdministrativeUnitMember command.

ms.service: entra
ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

>>>>>>> dc9d8ea1658f58c862053028f1dccb73525bd2c0
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Remove-EntraAdministrativeUnitMember

<<<<<<< HEAD
## SYNOPSIS

Removes an administrative unit member.

## SYNTAX

```powershell
Remove-EntraAdministrativeUnitMember 
 -ObjectId <String> 
=======
## Synopsis

Removes an administrative unit member.

## Syntax

```powershell
Remove-EntraAdministrativeUnitMember 
 -Id <String> 
>>>>>>> dc9d8ea1658f58c862053028f1dccb73525bd2c0
 -MemberId <String>
 [<CommonParameters>]
```

<<<<<<< HEAD
## DESCRIPTION

The `Remove-EntraAdministrativeUnitMember` cmdlet removes an administrative unit member in Microsoft Entra ID. Specify the `ObjectId` and `MemberId` parameter to remove a member of administrative unit.

## EXAMPLES

### Example 1: Remove an  administrative unit member

```powershell
Connect-Entra -Scopes 'AdministrativeUnit.ReadWrite.All'
Remove-EntraAdministrativeUnitMember -ObjectId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb' -MemberId '11bb11bb-cc22-dd33-ee44-55ff55ff55ff'
```

This example removes an administrative unit member from Microsoft Entra ID.

## PARAMETERS
=======
## Description
The Remove-EntraAdministrativeUnitMember cmdlet removes an administrative unit member in Microsoft Entra ID.

## Examples

### Example 1: Remove an administrative unit

```powershell
Connect-Entra -Scopes 'AdministrativeUnit.Read.All'
Remove-EntraAdministrativeUnitMember -Id 'bbbbbbbb-1111-2222-3333-cccccccccccc' -MemberId 'eeeeeeee-4444-5555-6666-ffffffffffff'
```

This command removes a specified member (user or group) from a specified administrative unit.

- `-Id` - specifies the unique identifier (ID) of the administrative unit from which you want to remove a member. In this example, `bbbbbbbb-1111-2222-3333-cccccccccccc` represents the ID of the administrative unit.

- `-MemberId` - specifies the unique identifier (Object ID) of the user or group you want to remove from the administrative unit. In this example, `eeeeeeee-4444-5555-6666-ffffffffffff` is the Object ID of the member being removed.

## Parameters
>>>>>>> dc9d8ea1658f58c862053028f1dccb73525bd2c0

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

<<<<<<< HEAD
### -ObjectId
=======
### -Id
>>>>>>> dc9d8ea1658f58c862053028f1dccb73525bd2c0

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

<<<<<<< HEAD
## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Add-EntraAdministrativeUnitMember](Add-EntraAdministrativeUnitMember.md)

[Get-EntraAdministrativeUnitMember](Get-EntraAdministrativeUnitMember.md)
=======
## Inputs

## Outputs

## Notes

## Related Links

[Add-EntraAdministrativeUnitMember](Add-EntraAdministrativeUnitMember.md)

[Remove-EntraAdministrativeUnitMember](Remove-EntraAdministrativeUnitMember.md)

>>>>>>> dc9d8ea1658f58c862053028f1dccb73525bd2c0
