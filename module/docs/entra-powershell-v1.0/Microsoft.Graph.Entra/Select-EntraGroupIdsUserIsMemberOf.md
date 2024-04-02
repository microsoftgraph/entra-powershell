---
title: Select-EntraGroupIdsUserIsMemberOf.
description: This article provides details on the Select-EntraGroupIdsUserIsMemberOf command.

ms.service: active-directory
ms.topic: reference
ms.date: 11/10/2023
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Select-EntraGroupIdsUserIsMemberOf

## SYNOPSIS
Selects the groups that a user is a member of.

## SYNTAX

```
Select-EntraGroupIdsUserIsMemberOf 
 -ObjectId <String> 
 -GroupIdsForMembershipCheck <GroupIdsForMembershipCheck>
 [<CommonParameters>]
```

## DESCRIPTION
The Select-EntraGroupIdsUserIsMemberOf cmdlet selects the groups that a user is a member of in Microsoft Entra ID.

## EXAMPLES

### Example 1: Get the group membership of a group for a user
```powershell
PS C:\> $Groups = New-Object Microsoft.Open.AzureAD.Model.GroupIdsForMembershipCheck
PS C:\> $Groups.GroupIds = (Get-EntraGroup -Top 1).ObjectId
PS C:\> $UserId = (Get-EntraUser -Top 1).ObjectId
PS C:\> Select-EntraGroupIdsUserIsMemberOf  -ObjectId $UserId -GroupIdsForMembershipCheck $Groups
```
```output
056b2531-005e-4f3e-be78-01a71ea30a04
```

The first command creates a GroupIdsForMembershipCheck object, and then stores it in the $Groups variable.

The second command gets an ID for a group by using the Get-EntraGroup (./Get-EntraGroup.md) cmdlet, and then stores it as a property of $Groups.

The third command gets the ID of a user by using the Get-EntraUser (./Get-EntraUser.md) cmdlet, and then stores it in the $UserId variable.

The final command gets the group membership of a group for a user identified by $UserId.

## PARAMETERS

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
Type: String
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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
