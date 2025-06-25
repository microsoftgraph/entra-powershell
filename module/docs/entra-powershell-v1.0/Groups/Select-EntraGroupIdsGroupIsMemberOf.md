---
author: msewaweru
description: This article provides details on the Select-EntraGroupIdsGroupIsMemberOf command.
external help file: Microsoft.Entra.Groups-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra
ms.author: eunicewaweru
ms.date: 06/26/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Select-EntraGroupIdsGroupIsMemberOf
schema: 2.0.0
title: Select-EntraGroupIdsGroupIsMemberOf
---

# Select-EntraGroupIdsGroupIsMemberOf

## Synopsis

Gets group IDs that a group is a member of.

## Syntax

```powershell
Select-EntraGroupIdsGroupIsMemberOf
 -GroupId <String>
 -GroupIdsForMembershipCheck <GroupIdsForMembershipCheck>
 [<CommonParameters>]
```

## Description

The `Select-EntraGroupIdsGroupIsMemberOf` cmdlet gets the groups that a specified group is a member of in Microsoft Entra ID.

## Examples

### Example 1: Get the group membership of a group for a group

```powershell
Connect-Entra -Scopes 'GroupMember.Read.All'
$groupObject = New-Object Microsoft.Open.AzureAD.Model.GroupIdsForMembershipCheck
$groupObject.GroupIds = (Get-EntraGroup -Filter "displayName eq 'Tailspin Toys'").Id
$group = Get-EntraGroup -Filter "displayName eq 'sg-Legal'"
Select-EntraGroupIdsGroupIsMemberOf  -GroupId $group.Id -GroupIdsForMembershipCheck $groupObject
```

This example gets the group membership of a group identified by $GroupId. Use `Get-EntraGroup` cmdlet to obtain group `GroupId` value.

- `-GroupId` parameter specifies the group ID.
- `-GroupIdsForMembershipCheck` Specifies an array of group object IDs.

## Parameters

### -GroupIdsForMembershipCheck

Specifies an array of group object IDs.

```yaml
Type: GroupIdsForMembershipCheck
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -GroupId

Specifies the ID of a group in Microsoft Entra ID.

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

## Inputs

## Outputs

## Notes

## Related links

[Get-EntraGroup](Get-EntraGroup.md)
