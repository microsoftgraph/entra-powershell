---
title: Remove-EntraAdministrativeUnitMember.
description: This article provides details on the Remove-EntraAdministrativeUnitMember command.
ms.service: active-directory
ms.topic: reference
ms.date: 06/05/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Remove-EntraAdministrativeUnitMember

## SYNOPSIS

Removes an administrative unit member.

## SYNTAX

```powershell
Remove-EntraAdministrativeUnitMember 
 -ObjectId <String> 
 -MemberId <String>
 [<CommonParameters>]
```

## DESCRIPTION

The Remove-EntraAdministrativeUnitMember cmdlet removes an administrative unit member in Microsoft Entra ID. Specify the `ObjectId` and `MemberId` parameter to remove a member of administrative unit.

## EXAMPLES

### Example 1: Remove an  administrative unit member

```powershell
Connect-Entra -Scopes 'User.Read.All'
Remove-EntraAdministrativeUnitMember -ObjectId '00000000-1111-1111-1111-000000000000' -MemberId 'aaaaaaaa-bbbb-aaaa-aaaa-000000000000'
```

This example removes an administrative unit member from Microsoft Entra ID.

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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Add-EntraAdministrativeUnitMember](Add-EntraAdministrativeUnitMember.md)

[Get-EntraAdministrativeUnitMember](Get-EntraAdministrativeUnitMember.md)
