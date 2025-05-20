---
title: Select-EntraBetaGroupIdsContactIsMemberOf
description: This article provides details on the Select-EntraBetaGroupIdsContactIsMemberOf.

ms.topic: reference
ms.date: 07/17/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Select-EntraBetaGroupIdsContactIsMemberOf

schema: 2.0.0
---

# Select-EntraBetaGroupIdsContactIsMemberOf

## Synopsis

Get groups in which a contact is a member.

## Syntax

```powershell
Select-EntraBetaGroupIdsContactIsMemberOf
 -ObjectId <String>
 -GroupIdsForMembershipCheck <GroupIdsForMembershipCheck>
 [<CommonParameters>]
```

## Description

The `Select-EntraBetaGroupIdsContactIsMemberOf` cmdlet gets groups in Microsoft Entra ID in which a contact is a member.

## Examples

### Example 1: Get groups in which a contact is a member

```powershell
Connect-Entra -Scopes 'OrgContact.Read.All,Group.Read.All'
$group = New-Object Microsoft.Open.AzureAD.Model.GroupIdsForMembershipCheck
$group.GroupIds = (Get-EntraBetaGroup -Filter "displayName eq 'Sales and Marketing'").Id
$contact = Get-EntraBetaContact -Filter "displayName eq 'Contoso Admin'"
Select-EntraBetaGroupIdsContactIsMemberOf -ObjectId $contact.Id -GroupIdsForMembershipCheck $group
```

This example demonstrates how to get groups in which a contact is a member.

- `-ObjectId` parameter specifies the contact Object ID.
- `-GroupIdsForMembershipCheck` parameter specifies the group Object ID.

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

Specifies the object ID of a contact in Microsoft Entra ID.

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

## Related links

[Get-EntraBetaContact](Get-EntraBetaContact.md)
