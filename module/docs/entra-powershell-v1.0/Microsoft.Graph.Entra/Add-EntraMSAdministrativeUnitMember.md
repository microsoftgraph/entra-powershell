---
title: Add-EntraMSAdministrativeUnitMember
description: This article provides details on the Add-EntraMSAdministrativeUnitMember command.

ms.service: entra
ms.topic: reference
ms.date: 03/22/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Add-EntraMSAdministrativeUnitMember

## SYNOPSIS

Adds an administrative unit member.

## SYNTAX

```powershell
Add-EntraMSAdministrativeUnitMember 
 -RefObjectId <String> 
 -Id <String> 
 [<CommonParameters>]
```

## DESCRIPTION

The `Add-EntraMSAdministrativeUnitMember` cmdlet adds a Microsoft Entra ID administrative unit member.

## EXAMPLES

### Example 1: Add user as an administrative unit member

```powershell
Connect-Entra -Scopes 'AdministrativeUnit.ReadWrite.All'
Add-EntraMSAdministrativeUnitMember -Id aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb -RefObjectId dddddddd-3333-4444-5555-eeeeeeeeeeee
```

This command adds a user as an administrative unit member.

`-Id` - specifies the unique identifier (ID) of the administrative unit to which you want to add a member. In this example, `aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb` represents the ID of the administrative unit.

`-RefObjectId` - specifies the unique identifier (Object ID) of the user or group you want to add as a member of the administrative unit. In this example, `dddddddd-3333-4444-5555-eeeeeeeeeeee` is the Object ID of the user or group being added.

Administrative units can help manage permissions and access in a more granular way, especially in large organizations or in scenarios where administrative responsibilities are divided among different departments or regions.

## PARAMETERS

### -Id

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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraMSAdministrativeUnitMember](Get-EntraMSAdministrativeUnitMember.md)

[Remove-EntraMSAdministrativeUnitMember](Remove-EntraMSAdministrativeUnitMember.md)
