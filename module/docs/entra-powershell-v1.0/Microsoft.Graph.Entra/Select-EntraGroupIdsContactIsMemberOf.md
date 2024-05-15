---
title: Select-EntraGroupIdsContactIsMemberOf
description: This article provides details on the Select-EntraGroupIdsContactIsMemberOf command.

ms.service: entra
ms.subservice: powershell
ms.topic: reference
ms.date: 03/21/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Select-EntraGroupIdsContactIsMemberOf

## SYNOPSIS
Get groups in which a contact is a member.

## SYNTAX

```powershell
Select-EntraGroupIdsContactIsMemberOf 
 -ObjectId <String>
 -GroupIdsForMembershipCheck <GroupIdsForMembershipCheck> 
 [<CommonParameters>]
```

## DESCRIPTION
The Select-EntraGroupIdsContactIsMemberOf cmdlet gets groups in Microsoft Entra ID in which a contact is a member.

## EXAMPLES

### Example 1: Get groups in which a contact is a member.
```powershell
PS C:\> $Groups = New-Object Microsoft.Open.AzureAD.Model.GroupIdsForMembershipCheck
PS C:\>$Groups.GroupIds = (Get-AzureADGroup -ObjectId 69641f6c-41dc-4f63-9c21-cc9c8ed12931).ObjectId
PS C:\>$UserID = (Get-AzureADContact -ObjectId cb4e4d7f-3cd6-43f2-8d37-b23b04b6417c).ObjectId
PS C:\>Select-AzureADGroupIdsContactIsMemberOf -ObjectId $UserID -GroupIdsForMembershipCheck $Groups

```
This example demonstrates how to get groups in which a contact is a member.

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
Specifies the object ID of a contact in Microsoft Entra ID.

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
