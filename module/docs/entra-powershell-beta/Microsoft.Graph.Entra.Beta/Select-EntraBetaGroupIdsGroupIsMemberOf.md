---
title: Select-EntraBetaGroupIdsGroupIsMemberOf
description: This article provides details on the Select-EntraBetaGroupIdsGroupIsMemberOf.

ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
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
The Select-EntraBetaGroupIdsGroupIsMemberOf cmdlet gets the groups that a specified group is a member of in Microsoft Entra ID.

## Examples

### Example 1: Get the group membership of a group for a group
```
PS C:\> $Groups = New-Object Microsoft.Open.AzureAD.Model.GroupIdsForMembershipCheck
PS C:\> $Groups.GroupIds = (Get-EntraBetaGroup -Top 1).ObjectId
PS C:\> $GroupId = (Get-EntraBetaGroup -Top 1).ObjectId
PS C:\> Select-EntraBetaGroupIdsGroupIsMemberOf  -ObjectId $GroupId -GroupIdsForMembershipCheck $Groups
```
The first command creates a GroupIdsForMembershipCheck object, and then stores it in the $Groups variable.

The second command gets an ID for a group by using the Get-EntraBetaGroup (./Get-EntraBetaGroup.md) cmdlet, and then stores it as a property of $Groups.

The third command gets the ID of a group by using Get-EntraBetaGroup, and then stores it in the $GroupId variable.

The final command gets the group membership of a group identified by $GroupId.

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

## Inputs

## Outputs

## Notes

## Related Links

[Get-EntraBetaGroup](Get-EntraBetaGroup.md)

