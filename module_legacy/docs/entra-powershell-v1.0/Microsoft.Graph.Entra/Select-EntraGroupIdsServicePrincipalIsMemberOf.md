---
title: Select-EntraGroupIdsServicePrincipalIsMemberOf
description: This article provides details on the Select-EntraGroupIdsServicePrincipalIsMemberOf command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Select-EntraGroupIdsServicePrincipalIsMemberOf

schema: 2.0.0
---

# Select-EntraGroupIdsServicePrincipalIsMemberOf

## Synopsis

Selects the groups in which a service principal is a member.

## Syntax

```powershell
Select-EntraGroupIdsServicePrincipalIsMemberOf
 -ObjectId <String>
 -GroupIdsForMembershipCheck <GroupIdsForMembershipCheck>
 [<CommonParameters>]
```

## Description

The `Select-EntraGroupIdsServicePrincipalIsMemberOf` cmdlet selects the groups in which a service principal is a member in Microsoft Entra ID.

## Examples

### Example 1: Get the group membership of a group for a service principal

```powershell
Connect-Entra -Scopes 'Application.Read.All'
$Groups = New-Object Microsoft.Open.AzureAD.Model.GroupIdsForMembershipCheck
$Groups.GroupIds = (Get-EntraGroup -Top 10).ObjectId
$ServicePrincipal = Get-EntraServicePrincipal -Filter "DisplayName eq '<service-principal-display-name>'"
$params = @{
    ObjectId = $ServicePrincipal.ObjectId
    GroupIdsForMembershipCheck = $Groups
}
Select-EntraGroupIdsServicePrincipalIsMemberOf @params
```

```Output
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb
```

This command gets the group membership of a group for a specified service principal.  
You can use the command `Get-EntraGroup` to get group Id.  
You can use the command `Get-EntraServicePrincipal` to get service principal Id.

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

## Related Links
