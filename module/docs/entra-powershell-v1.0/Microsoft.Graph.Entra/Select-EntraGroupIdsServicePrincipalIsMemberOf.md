---
title: Select-EntraGroupIdsServicePrincipalIsMemberOf.
description: This article provides details on the Select-EntraGroupIdsServicePrincipalIsMemberOf command.

ms.service: active-directory
ms.topic: reference
ms.date: 03/15/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Select-EntraGroupIdsServicePrincipalIsMemberOf

## SYNOPSIS
Selects the groups in which a service principal is a member.

## SYNTAX

```
Select-EntraGroupIdsServicePrincipalIsMemberOf 
 -ObjectId <String>
 -GroupIdsForMembershipCheck <GroupIdsForMembershipCheck> 
 [<CommonParameters>]
```

## DESCRIPTION
The Select-EntraGroupIdsServicePrincipalIsMemberOf cmdlet selects the groups in which a service principal is a member in Microsoft Entra ID.

## EXAMPLES

### Example 1: Get the group membership of a group for a service principal
```powershell
PS C:\> $Groups = New-Object Microsoft.Open.AzureAD.Model.GroupIdsForMembershipCheck
PS C:\> $Groups.GroupIds = (Get-EntraGroup -Top 1).ObjectId
PS C:\> $SPId = (Get-EntraServicePrincipal -Top 1).ObjectId
PS C:\> Select-EntraGroupIdsServicePrincipalIsMemberOf -ObjectId $SPId -GroupIdsForMembershipCheck $Groups
```
```output
140036f7-33f9-4f06-bdd6-39de8fe65d81
```

The first command creates a GroupIdsForMembershipCheck object, and then stores it in the $Groups variable.

The second command gets an ID for a group by using the Get-EntraGroup (./Get-EntraGroup.md) cmdlet, and then stores it as a property of $Groups.

The third command gets the ID of a service principal by using the Get-EntraServicePrincipal (./Get-EntraServicePrincipal.md) cmdlet, and then stores it in the $SPId variable.

The final command gets the group membership of a group for a service principal identified by $SPId.

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
Specifies the ID of a service principal in Microsoft Entra ID.

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
