---
title: Select-EntraBetaGroupIdsGroupIsMemberOf
description: This article provides details on the Select-EntraBetaGroupIdsGroupIsMemberOf.

ms.topic: reference
ms.date: 07/24/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Entra.Beta.Groups-Help.xml
Module Name: Microsoft.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Select-EntraBetaGroupIdsGroupIsMemberOf

schema: 2.0.0
---

# Select-EntraBetaGroupIdsGroupIsMemberOf

## Synopsis

Gets group IDs that a group is a member of.

## Syntax

```powershell
Select-EntraBetaGroupIdsGroupIsMemberOf
 -ObjectId <String>
 -GroupIdsForMembershipCheck <GroupIdsForMembershipCheck>
 [<CommonParameters>]
```

## Description

The `Select-EntraBetaGroupIdsGroupIsMemberOf` cmdlet gets the groups that a specified group is a member of in Microsoft Entra ID.

## Examples

### Example 1: Get the group membership of a group for a group

```powershell
Connect-Entra -Scopes 'GroupMember.Read.All'
$Groups = New-Object Microsoft.Open.AzureAD.Model.GroupIdsForMembershipCheck
$Groups.GroupIds = (Get-EntraBetaGroup -Top 1).ObjectId
$GroupId = (Get-EntraBetaGroup -Top 1).ObjectId
Select-EntraBetaGroupIdsGroupIsMemberOf  -ObjectId $GroupId -GroupIdsForMembershipCheck $Groups
```

This example gets the group membership of a group identified by $GroupId. Use `Get-EntraBetaGroup` cmdlet to obtain group `ObjectId` value.

- `-ObjectId` parameter specifies the group ID.
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

### -ObjectId

Specifies the ID of a group in Microsoft Entra ID.

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

[Get-EntraBetaGroup](Get-EntraBetaGroup.md)
