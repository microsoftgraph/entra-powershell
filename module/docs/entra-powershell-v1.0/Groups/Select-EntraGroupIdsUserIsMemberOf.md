---
author: msewaweru
description: This article provides details on the Select-EntraGroupIdsUserIsMemberOf command.
external help file: Microsoft.Entra.Groups-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra
ms.author: eunicewaweru
ms.date: 06/26/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Select-EntraGroupIdsUserIsMemberOf
schema: 2.0.0
title: Select-EntraGroupIdsUserIsMemberOf
---

# Select-EntraGroupIdsUserIsMemberOf

## Synopsis

Selects the groups that a user is a member of.

## Syntax

```powershell
Select-EntraGroupIdsUserIsMemberOf
 -UserId <String>
 -GroupIdsForMembershipCheck <GroupIdsForMembershipCheck>
 [<CommonParameters>]
```

## Description

The `Select-EntraGroupIdsUserIsMemberOf` cmdlet selects the groups that a user is a member of in Microsoft Entra ID.

## Examples

### Example 1: Get the group membership of a group for a user

```powershell
Connect-Entra -Scopes 'Application.Read.All'
$myGroup = Get-EntraGroup -Filter "DisplayName eq '<Group-DisplayName>'"
$UserId = 'SawyerM@contoso.com'
$groups = New-Object Microsoft.Open.AzureAD.Model.GroupIdsForMembershipCheck
$groups.GroupIds = $myGroup.Id
Select-EntraGroupIdsUserIsMemberOf -UserId 'SawyerM@contoso.com' -GroupIdsForMembershipCheck $groups
```

```Output
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb
```

This example retrieves the group membership of a group for a user.

- `-UserId` parameter specifies the object Id of a user(as a UserPrincipalName or ObjectId).
- `-GroupIdsForMembershipCheck` parameter specifies the group Object Ids.

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

## Inputs

## Outputs

## Notes

## Related links

[Get-EntraGroup](Get-EntraGroup.md)
