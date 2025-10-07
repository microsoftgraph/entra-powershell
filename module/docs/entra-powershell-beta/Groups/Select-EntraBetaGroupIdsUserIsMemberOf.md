---
author: msewaweru
description: This article provides details on the Select-EntraBetaGroupIdsUserIsMemberOf command.
external help file: Microsoft.Entra.Beta.Groups-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.Beta.Groups
ms.author: eunicewaweru
ms.date: 07/26/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta.Groups/Select-EntraBetaGroupIdsUserIsMemberOf
schema: 2.0.0
title: Select-EntraBetaGroupIdsUserIsMemberOf
---

# Select-EntraBetaGroupIdsUserIsMemberOf

## SYNOPSIS

Selects the groups that a user is a member of.

## SYNTAX

```powershell
Select-EntraBetaGroupIdsUserIsMemberOf
 -UserId <String>
 -GroupIdsForMembershipCheck <GroupIdsForMembershipCheck>
 [<CommonParameters>]
```

## DESCRIPTION

The `Select-EntraBetaGroupIdsUserIsMemberOf` cmdlet selects the groups that a user is a member of in Microsoft Entra ID.

## EXAMPLES

### Example 1: Get the group membership of a group for a user

```powershell
Connect-Entra -Scopes 'Application.Read.All'
$myGroup = Get-EntraBetaGroup -Filter "DisplayName eq '<Group-DisplayName>'"
$groups = New-Object Microsoft.Open.AzureAD.Model.GroupIdsForMembershipCheck
$groups.GroupIds = $myGroup.Id
Select-EntraBetaGroupIdsUserIsMemberOf -UserId 'SawyerM@contoso.com' -GroupIdsForMembershipCheck $groups
```

```Output
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb
```

This example retrieves the group membership of a group for a user.

- `-UserId` parameter specifies the object Id of a user(as a UserPrincipalName or ObjectId).
- `-GroupIdsForMembershipCheck` parameter specifies the group Object Ids.

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

### -UserId

Specifies the ID of a user (as a UserPrincipalName or ObjectId) in Microsoft Entra ID.

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

[Get-EntraBetaGroup](Get-EntraBetaGroup.md)
