---
title: Select-EntraBetaGroupIdsUserIsMemberOf
description: This article provides details on the Select-EntraBetaGroupIdsUserIsMemberOf command.

ms.topic: reference
ms.date: 07/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: mwongerapk
author: msewaweru
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Select-EntraBetaGroupIdsUserIsMemberOf

schema: 2.0.0
---

# Select-EntraBetaGroupIdsUserIsMemberOf

## Synopsis

Selects the groups that a user is a member of.

## Syntax

```powershell
Select-EntraBetaGroupIdsUserIsMemberOf
 -ObjectId <String>
 -GroupIdsForMembershipCheck <GroupIdsForMembershipCheck>
 [<CommonParameters>]
```

## Description

The `Select-EntraBetaGroupIdsUserIsMemberOf` cmdlet selects the groups that a user is a member of in Microsoft Entra ID.

## Examples

### Example 1: Get the group membership of a group for a user

```powershell
Connect-Entra -Scopes 'Application.Read.All'
$myGroup = Get-EntraBetaGroup -Filter "DisplayName eq '<Group-DisplayName>'"
$UserId = 'SawyerM@contoso.com'
$groups = New-Object Microsoft.Open.AzureAD.Model.GroupIdsForMembershipCheck
$groups.GroupIds = $myGroup.Id
Select-EntraBetaGroupIdsUserIsMemberOf -ObjectId 'SawyerM@contoso.com' -GroupIdsForMembershipCheck $groups
```

```Output
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb
```

This example retrieves the group membership of a group for a user.

- `-ObjectId` parameter specifies the object Id of a user(as a UserPrincipalName or ObjectId).
- `-GroupIdsForMembershipCheck` parameter specifies the group Object Ids.

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

Specifies the ID of a user (as a UserPrincipalName or ObjectId) in Microsoft Entra ID.

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
