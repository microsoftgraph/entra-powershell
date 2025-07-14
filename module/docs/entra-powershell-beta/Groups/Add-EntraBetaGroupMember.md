---
author: msewaweru
description: This article provides details on the Add-EntraBetaGroupMember command.
external help file: Microsoft.Entra.Beta.Groups-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 02/08/2025
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Add-EntraBetaGroupMember
schema: 2.0.0
title: Add-EntraBetaGroupMember
---

# Add-EntraBetaGroupMember

## SYNOPSIS

Add a member to a security or Microsoft 365 group.

## SYNTAX

```powershell
Add-EntraBetaGroupMember
 -GroupId <String>
 -MemberId <String>
 [-WhatIf]
 [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION

The `Add-EntraBetaGroupMember` cmdlet adds a member to a security or Microsoft 365 group.

`New-EntraBetaGroupMember` and `Add-EntraBetaGroupMembership` are aliases of `Add-EntraBetaGroupMember`.

In delegated scenarios, the signed-in user needs a supported Microsoft Entra role or a custom role with the `microsoft.directory/groups/members/update` permission. The minimum roles required for this operation, excluding role-assignable groups, are:

- Group owners
- Directory Writers
- Groups Administrator
- User Administrator

## EXAMPLES

### Example 1: Add a member to a group

```powershell
Connect-Entra -Scopes 'GroupMember.ReadWrite.All'
$group = Get-EntraBetaGroup -Filter "DisplayName eq 'Contoso Marketing Group'"
$user = Get-EntraBetaUser -UserId 'SawyerM@contoso.com'
Add-EntraBetaGroupMember -GroupId $group.Id -MemberId $user.Id
```

This example demonstrates how to add a member to a group.

### Example 2: Add members based on search results to a group

```powershell
Connect-Entra -Scopes 'GroupMember.ReadWrite.All'
$group = Get-EntraBetaGroup -Filter "DisplayName eq 'Sales and Marketing'"
Get-EntraBetaUser -Filter "startsWith(displayName,'Updated User')" | 
    Add-EntraBetaGroupMember -GroupId $group.Id
```

This example demonstrates how to add members based on a search result to a group.

- `-GroupId` - Specifies the unique identifier (Object ID) of the group to which you want to add a member.

### Example 3: Sync users from one group to another

```powershell
Connect-Entra -Scopes 'GroupMember.ReadWrite.All'
$group = Get-EntraBetaGroup -Filter "DisplayName eq 'Sales and Marketing'"
Get-EntraBetaGroupMember -GroupId "source-group-id" | 
    Add-EntraBetaGroupMember -GroupId $group.Id
```

This example demonstrates how to sync group members from source target group to a new group.

- `-GroupId` - Specifies the unique identifier (Object ID) of the group to which you want to add a member.

## PARAMETERS

### -GroupId

Specifies the ID of a group in Microsoft Entra ID.

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

### -MemberId

Specifies the unique identifier (Object ID) of the member to be added to the group. You can add users, security groups, Microsoft 365 groups, devices, service principals, and organizational contacts to security groups. Only users can be added to Microsoft 365 groups.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: RefObjectId

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

[Get-EntraBetaGroupMember](Get-EntraBetaGroupMember.md)

[Remove-EntraBetaGroupMember](Remove-EntraBetaGroupMember.md)
