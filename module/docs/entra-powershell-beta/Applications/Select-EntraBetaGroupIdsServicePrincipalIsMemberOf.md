---
author: msewaweru
description: This article provides details on the Select-EntraBetaGroupIdsServicePrincipalIsMemberOf command.
external help file: Microsoft.Entra.Beta.Applications-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 07/31/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Select-EntraBetaGroupIdsServicePrincipalIsMemberOf
schema: 2.0.0
title: Select-EntraBetaGroupIdsServicePrincipalIsMemberOf
---

# Select-EntraBetaGroupIdsServicePrincipalIsMemberOf

## SYNOPSIS

Selects the groups in which a service principal is a member.

## SYNTAX

```powershell
Select-EntraBetaGroupIdsServicePrincipalIsMemberOf
 -ServicePrincipalId <String>
 -GroupIdsForMembershipCheck <GroupIdsForMembershipCheck>
 [<CommonParameters>]
```

## DESCRIPTION

The `Select-EntraBetaGroupIdsServicePrincipalIsMemberOf` cmdlet selects the groups in which a service principal is a member in Microsoft Entra ID.

## EXAMPLES

### Example 1: Get the group membership of a group for a service principal

```powershell
Connect-Entra -Scopes 'Application.Read.All'
$group = New-Object Microsoft.Open.AzureAD.Model.GroupIdsForMembershipCheck
$group.GroupIds = (Get-EntraBetaGroup -Top 10).Id
$servicePrincipal = Get-EntraBetaServicePrincipal -Filter "DisplayName eq 'Helpdesk Application'"
Select-EntraBetaGroupIdsServicePrincipalIsMemberOf -ServicePrincipalId $servicePrincipal.Id -GroupIdsForMembershipCheck $group
```

```Output
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb
```

This command gets the group membership of a group for a specified service principal. Use the command `Get-EntraBetaGroup` to get group Id and `Get-EntraBetaServicePrincipal` to get service principal Id.

- `-ServicePrincipalId` parameter specifies the service principal Id.
- `-GroupIdsForMembershipCheck` parameter specifies the array of group object IDs.

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

### -ServicePrincipalId

Specifies the ID of a service principal in Microsoft Entra ID.

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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
