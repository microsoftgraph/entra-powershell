---
author: msewaweru
description: This article provides details on the Select-EntraGroupIdsContactIsMemberOf command.
external help file: Microsoft.Entra.Groups-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra
ms.author: eunicewaweru
ms.date: 06/26/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Select-EntraGroupIdsContactIsMemberOf
schema: 2.0.0
title: Select-EntraGroupIdsContactIsMemberOf
---

# Select-EntraGroupIdsContactIsMemberOf

## Synopsis

Get groups in which a contact is a member.

## Syntax

```powershell
Select-EntraGroupIdsContactIsMemberOf
 -OrgContactId <String>
 -GroupIdsForMembershipCheck <GroupIdsForMembershipCheck>
 [<CommonParameters>]
```

## Description

The `Select-EntraGroupIdsContactIsMemberOf` cmdlet gets groups in Microsoft Entra ID in which a contact is a member.

## Examples

### Example 1: Get groups in which a contact is a member

```powershell
Connect-Entra -Scopes 'OrgContact.Read.All,Group.Read.All'
$group = New-Object Microsoft.Open.AzureAD.Model.GroupIdsForMembershipCheck
$group.GroupIds = (Get-EntraGroup -Filter "displayName eq 'Sales and Marketing'").Id
$contact = Get-EntraContact -Filter "displayName eq 'Contoso Admin'"
Select-EntraGroupIdsContactIsMemberOf -OrgContactId $contact.Id -GroupIdsForMembershipCheck $group
```

This example demonstrates how to get groups in which a contact is a member.

- `-OrgContactId` parameter specifies the contact Object ID.
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

### -OrgContactId

Specifies the object ID of a contact in Microsoft Entra ID.

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

[Get-EntraContact](../DirectoryManagement/Get-EntraContact.md)
