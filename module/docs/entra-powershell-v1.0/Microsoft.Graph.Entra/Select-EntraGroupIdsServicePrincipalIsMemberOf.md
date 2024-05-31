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

```powershell
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
 Connect-Entra -Scopes 'Application.Read.All'
 $Groups = New-Object Microsoft.Open.AzureAD.Model.GroupIdsForMembershipCheck
 $Groups.GroupIds = (Get-EntraGroup -Top 1).ObjectId
 $SPId = (Get-EntraServicePrincipal -Top 1).ObjectId
 Select-EntraGroupIdsServicePrincipalIsMemberOf -ObjectId $SPId -GroupIdsForMembershipCheck $Groups
```

```output
bbbbbbbb-5555-5555-0000-qqqqqqqqqqqq
```

The first command creates a GroupIdsForMembershipCheck object, and then stores it in the $Groups variable.

The second command gets an ID for a group by using the [Get-EntraGroup](./Get-EntraGroup.md) cmdlet, and then stores it as a property of $Groups.

The third command gets the ID of a service principal by using the [Get-EntraServicePrincipal](./Get-EntraServicePrincipal.md) cmdlet, and then stores it in the $SPId variable.

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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
