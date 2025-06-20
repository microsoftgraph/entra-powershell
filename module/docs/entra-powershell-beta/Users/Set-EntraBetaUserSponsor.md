---
author: msewaweru
description: This article provides details on the Set-EntraBetaUserSponsor command.
external help file: Microsoft.Entra.Beta.Users-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 03/10/2025
ms.reviewer: dbutoyi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Set-EntraBetaUserSponsor
schema: 2.0.0
title: Set-EntraBetaUserSponsor
---

# Set-EntraBetaUserSponsor

## Synopsis

Sets a user's sponsors (users or groups).

## Syntax

### SetUserSponsor (Default)

```powershell
Set-EntraBetaUserSponsor
 -UserId <String>
 -Type <String>
 -SponsorIds <String[]>
 [<CommonParameters>]
```

## Description

The `Set-EntraBetaUserSponsor` cmdlet sets a user's sponsors (users or groups). The sponsor feature tracks who is responsible for each guest user by assigning a person or group, ensuring accountability.

`Update-EntraBetaUserSponsor` is an alias for `Set-EntraBetaUserSponsor`.

In delegated scenarios with work or school accounts, the signed-in user must have a supported Microsoft Entra role or a custom role that includes the `microsoft.directory/users/sponsors/update` permission.

The following least privileged roles support this operation:

- Directory Writers
- User Administrator

## Examples

### Example 1: Assign single user sponsor

```powershell
Connect-Entra -Scopes 'User.ReadWrite.All'
$sponsor = Get-EntraBetaUser -UserId 'SponsorEmail@contoso.com'
Set-EntraBetaUserSponsor -UserId 'JohnstoneH@fabrikam.com' -Type User -SponsorIds $sponsor.Id
```

This example demonstrates how to assign a single user, as a sponsor to a target user account.

- The `-UserId` parameter specifies the User ID or User Principal Name. You can use `-UserPrincipalName`, `-Identity`, `-UPN`, `-ObjectId` as an alias for `-UserId`.
- The `-Type` parameter specifies the type of sponsor being assigned to the user. Supported sponsor types are (User or Group).
- The `-SponsorIds` parameter specifies the Ids of sponsors to be assigned to the user.

### Example 2: Assign single group sponsor

```powershell
Connect-Entra -Scopes 'User.ReadWrite.All', 'GroupMember.Read.All'
$group = Get-EntraBetaGroup -SearchString 'Sales and Marketing'
Set-EntraBetaUserSponsor -UserId 'JohnstoneH@fabrikam.com' -Type Group -SponsorIds $group.Id
```

This example demonstrates how to assign a single group, as a sponsor to a target user account.

- The `-UserId` parameter specifies the User ID or User Principal Name. You can use `-UserPrincipalName`, `-Identity`, `-UPN`, `-ObjectId` as an alias for `-UserId`.
- The `-Type` parameter specifies the type of sponsor being assigned to the user. Supported sponsor types are (User or Group).
- The `-SponsorIds` parameter specifies the Ids of sponsors to be assigned to the user.

### Example 3: Assign multiple user sponsors

```powershell
Connect-Entra -Scopes 'User.ReadWrite.All'
Set-EntraBetaUserSponsor -UserId 'JohnstoneH@fabrikam.com' -Type User -SponsorIds @("db0c6l50-93ee-4b22-9bb9-c8454875d990","c9db38b9-e5b8-4b5e-ak78-9812230af58d")
```

This example demonstrates how to assign multiple users as sponsors to a target user account.

- The `-UserId` parameter specifies the User ID or User Principal Name. You can use `-UserPrincipalName`, `-Identity`, `-UPN`, `-ObjectId` as an alias for `-UserId`.
- The `-Type` parameter specifies the type of sponsor being assigned to the user. Supported sponsor types are (User or Group).
- The `-SponsorIds` parameter specifies the Ids of sponsors to be assigned to the user.

### Example 4: Assign multiple group sponsors

```powershell
Connect-Entra -Scopes 'User.ReadWrite.All'
Set-EntraBetaUserSponsor -UserId 'JohnstoneH@fabrikam.com' -Type Group -SponsorIds @("db0c6f50-93ee-4b22-9bb9-c8454875d990","c9db38b9-e5v8-4b5e-ae78-9812230af58d")
```

This example demonstrates how to assign multiple groups as sponsors to a target user account.

- The `-UserId` parameter specifies the User ID or User Principal Name. You can use `-UserPrincipalName`, `-Identity`, `-UPN`, `-ObjectId` as an alias for `-UserId`.
- The `-Type` parameter specifies the type of sponsor being assigned to the user. Supported sponsor types are (User or Group).
- The `-SponsorIds` parameter specifies the Ids of sponsors to be assigned to the user.

## Parameters

### -Type

Specifies the type of sponsors being assigned to the user. Supported sponsor types are (User or Group).

```yaml
Type: System.String
Parameter Sets: (All)

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -UserId

Specifies the ID (as a UserPrincipalName or UserId) of a user in Microsoft Entra ID.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: ObjectId, UPN, Identity, UserPrincipalName

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -SponsorId

Specifies the sponsor ID (user or group ID) to assign to the specific user target.

```yaml
Type: System.String[]
Parameter Sets: (All)

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

[Get-EntraBetaUserSponsor](Get-EntraBetaUserSponsor.md)

[Remove-EntraBetaUserSponsor](Remove-EntraBetaUserSponsor.md)
