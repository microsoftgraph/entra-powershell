---
title: Update-EntraInvitedUserSponsorsFromInvitedBy
description: This article provides details on the Update-EntraInvitedUserSponsorsFromInvitedBy command.

ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Entra.Users-Help.xml
Module Name: Microsoft.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Update-EntraInvitedUserSponsorsFromInvitedBy

schema: 2.0.0
---

# Update-EntraInvitedUserSponsorsFromInvitedBy

## Synopsis

Updates the sponsors of invited users based on the user who invited them.

## Syntax

```powershell
Update-EntraInvitedUserSponsorsFromInvitedBy
 [-UserId <String[]>]
 [-All]
 [<CommonParameters>]
```

## Description

The `Update-EntraInvitedUserSponsorsFromInvitedBy` cmdlet updates the sponsors for invited users based on the inviter's information in Microsoft Entra ID.

The calling user must be assigned at least one of the following Microsoft Entra roles:

- User Administrator
- Privileged Authentication Administrator

## Examples

### Example 1: Update sponsors for a specific guest user

```powershell
Connect-Entra -Scopes 'User.ReadWrite.All'
Update-EntraInvitedUserSponsorsFromInvitedBy -UserId 'guestuser@contoso.com'
```

This command updates the sponsors for the specified guest user in Microsoft Entra ID.

### Example 2: Update sponsors for all invited guest users

```powershell
Connect-Entra -Scopes 'User.ReadWrite.All'
Update-EntraInvitedUserSponsorsFromInvitedBy -All
```

This command updates the sponsors for all invited guest users in Microsoft Entra ID.

## Parameters

### -UserId

Specifies the ID of one or more guest users (as UPNs or User IDs) in Microsoft Entra ID.

```yaml
Type: System.String[]
Parameter Sets: ByUsers
Aliases: None

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -All

Specifies that the cmdlet should update sponsors for all invited guest users.

```yaml
Type: SwitchParameter
Parameter Sets: AllInvitedGuests
Aliases: None

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

None.

## Outputs

None.

## Notes

- If neither `-UserId` nor `-All` is specified, the cmdlet returns an error.
- The cmdlet retrieves invited users and their inviter information before updating the sponsors.
- The `-All` switch processes all guest users in the tenant.

## Related Links

[Get-EntraUser](Get-EntraUser.md)

[Update-EntraUser](Update-EntraUser.md)

