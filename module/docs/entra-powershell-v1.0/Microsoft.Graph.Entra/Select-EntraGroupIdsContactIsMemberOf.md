---
title: Select-EntraGroupIdsContactIsMemberOf
description: This article provides details on the Select-EntraGroupIdsContactIsMemberOf command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/en-us/powershell/module/Microsoft.Graph.Entra/Select-EntraGroupIdsContactIsMemberOf

schema: 2.0.0
---

# Select-EntraGroupIdsContactIsMemberOf

## Synopsis

Get groups in which a contact is a member.

## Syntax

```powershell
Select-EntraGroupIdsContactIsMemberOf 
 -ObjectId <String>
 -GroupIdsForMembershipCheck <GroupIdsForMembershipCheck> 
 [<CommonParameters>]
```

## Description

The Select-EntraGroupIdsContactIsMemberOf cmdlet gets groups in Microsoft Entra ID in which a contact is a member.

## Examples

### Example 1: Get groups in which a contact is a member.

```powershell
Connect-Entra -Scopes 'OrgContact.Read.All,Group.Read.All'
$Groups = New-Object Microsoft.Open.Entra.Model.GroupIdsForMembershipCheck
$Groups.GroupIds = (Get-EntraGroup -ObjectId 'jjjjjjjj-9999-7777-7777-uuuuuuuuuuuu').ObjectId
$UserID = (Get-EntraContact -ObjectId 'hhhhhhhh-8888-9999-8888-cccccccccccc').ObjectId
Select-EntraGroupIdsContactIsMemberOf -ObjectId $UserID -GroupIdsForMembershipCheck $Groups
```

This example demonstrates how to get groups in which a contact is a member.

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

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related Links
