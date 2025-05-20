---
title: Select-EntraBetaGroupIdsServicePrincipalIsMemberOf
description: This article provides details on the Select-EntraBetaGroupIdsServicePrincipalIsMemberOf command.


ms.topic: reference
ms.date: 07/31/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Select-EntraBetaGroupIdsServicePrincipalIsMemberOf

schema: 2.0.0
---

# Select-EntraBetaGroupIdsServicePrincipalIsMemberOf

## Synopsis

Selects the groups in which a service principal is a member.

## Syntax

```powershell
Select-EntraBetaGroupIdsServicePrincipalIsMemberOf
 -ObjectId <String>
 -GroupIdsForMembershipCheck <GroupIdsForMembershipCheck>
 [<CommonParameters>]
```

## Description

The `Select-EntraBetaGroupIdsServicePrincipalIsMemberOf` cmdlet selects the groups in which a service principal is a member in Microsoft Entra ID.

## Examples

### Example 1: Get the group membership of a group for a service principal

```powershell
Connect-Entra -Scopes 'Application.Read.All'
$Groups = New-Object Microsoft.Open.AzureAD.Model.GroupIdsForMembershipCheck
$Groups.GroupIds = (Get-EntraBetaGroup -Top 10).ObjectId
$ServicePrincipal = Get-EntraBetaServicePrincipal -Filter "DisplayName eq '<service-principal-display-name>'"
$params = @{
    ObjectId = $ServicePrincipal.ObjectId
    GroupIdsForMembershipCheck = $Groups
}
Select-EntraBetaGroupIdsServicePrincipalIsMemberOf @params
```

```Output
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb
```

This command gets the group membership of a group for a specified service principal.  
You can use the command `Get-EntraBetaGroup` to get group Id.  
You can use the command `Get-EntraBetaServicePrincipal` to get service principal Id.

- `-ObjectId` parameter specifies the service principal Id.
- `-GroupIdsForMembershipCheck` parameter specifies the array of group object IDs.

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

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related links
