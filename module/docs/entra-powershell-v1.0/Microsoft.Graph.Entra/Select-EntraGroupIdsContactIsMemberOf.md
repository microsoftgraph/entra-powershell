---
title: Select-EntraGroupIdsGroupIsMemberOf
description: This article provides details on the Select-EntraGroupIdsGroupIsMemberOf command.

ms.service: active-directory
ms.topic: reference
ms.date: 03/16/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Select-EntraGroupIdsGroupIsMemberOf

## SYNOPSIS
Gets group IDs that a group is a member of.

## SYNTAX

```powershell
Select-EntraGroupIdsGroupIsMemberOf 
 -ObjectId <String> 
 -GroupIdsForMembershipCheck <GroupIdsForMembershipCheck>
 [<CommonParameters>]
```

## DESCRIPTION
The Select-EntraGroupIdsGroupIsMemberOf cmdlet gets the groups that a specified group is a member of in Microsoft Entra ID.

## EXAMPLES

### Example 1: Get the group membership of a group for a group.

```powershell
PS C:\> $Groups = New-Object Microsoft.Open.AzureAD.Model.GroupIdsForMembershipCheck
PS C:\> $Groups.GroupIds = (Get-EntraGroup -Top 1).ObjectId
PS C:\> $GroupId = (Get-EntraGroup -Top 1).ObjectId
PS C:\> Select-EntraGroupIdsGroupIsMemberOf  -ObjectId $GroupId -GroupIdsForMembershipCheck $Groups
```

The first command creates a GroupIdsForMembershipCheck object, and then stores it in the $Groups variable.

The second command gets an ID for a group by using the [Get-EntraGroup](./Get-EntraGroup.md) cmdlet, and then stores it as a property of $Groups.

The third command gets the ID of a group by using Get-EntraGroup, and then stores it in the $GroupId variable.

The final command gets the group membership of a group identified by $GroupId.

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
Specifies the ID of a group in Microsoft Entra ID.

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

[Get-EntraGroup](Get-EntraGroup.md)