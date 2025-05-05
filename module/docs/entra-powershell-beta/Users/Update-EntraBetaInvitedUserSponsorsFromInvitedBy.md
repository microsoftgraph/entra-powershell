---
title: Update-EntraBetaInvitedUserSponsorsFromInvitedBy
description: This article provides details on the Update-EntraBetaInvitedUserSponsorsFromInvitedBy command.

ms.topic: reference
ms.date: 02/11/2025
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Entra.Beta.Users-Help.xml
Module Name: Microsoft.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Beta.Entra/Update-EntraBetaInvitedUserSponsorsFromInvitedBy

schema: 2.0.0
---

# Update-EntraBetaInvitedUserSponsorsFromInvitedBy

## Synopsis

Update the Sponsors attribute to include the user who initially invited them to the tenant using the InvitedBy property. While new guests are sponsored automatically, the feature was only rolled out last year and did not backfill the sponsor info for previous guests that were invited.

## Syntax

```powershell
Update-EntraBetaInvitedUserSponsorsFromInvitedBy
 [-UserId <String[]>]
 [-All]
 [<CommonParameters>]
```

## Description

The `Update-EntraBetaInvitedUserSponsorsFromInvitedBy` cmdlet updates the Sponsors attribute to include the user who initially invited them to the tenant using the InvitedBy property. This script can be used to backfill Sponsors attribute for existing users.

The calling user must be assigned at least one of the following Microsoft Entra roles:

- User Administrator
- Privileged Authentication Administrator

## Examples

### Example 1: Enumerate all invited users in the Tenant and update Sponsors using InvitedBy value

```powershell
 Connect-Entra -Scopes 'User.ReadWrite.All'
 Update-EntraBetaInvitedUserSponsorsFromInvitedBy
```

```Output
Confirm
Are you sure you want to perform this action?
Performing the operation "Update Sponsors" on target "externaluser_externaldomain.com"
(externaluser_externaldomain.com#EXT#@contoso.com - 00aa00aa-bb11-cc22-dd33-44ee44ee44ee)".
[Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help (default is "Y"): A

externaluser1_externaldomain.com#EXT#@contoso.com - Sponsor updated successfully for this user.
externaluser1_externaldomain#EXT#@contoso - Sponsor updated successfully for this user.
externaluser1_externaldomain#EXT#@contoso - Sponsor updated successfully for this user.
```

Enumerate all invited users in the Tenant and update Sponsors using InvitedBy value

### Example 2: Update sponsors for a specific guest user

```powershell
Connect-Entra -Scopes 'User.ReadWrite.All'
Update-EntraBetaInvitedUserSponsorsFromInvitedBy -UserId 'externaluser1_externaldomain.com','externaluser1_externaldomain.com'
```

```Output
Confirm
Are you sure you want to perform this action?
Performing the operation "Update Sponsors" on target "externaluser_externaldomain.com"
(externaluser_externaldomain.com#EXT#@contoso.com - 00aa00aa-bb11-cc22-dd33-44ee44ee44ee)".
[Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help (default is "Y"): A

externaluser1_externaldomain.com#EXT#@contoso.com - Sponsor updated successfully for this user.
```

This command updates the sponsors for the specified guest user in Microsoft Entra ID.

### Example 3: Update sponsors for all invited guest users

```powershell
Connect-Entra -Scopes 'User.ReadWrite.All'
Update-EntraBetaInvitedUserSponsorsFromInvitedBy -All
```

```Output
Confirm
Are you sure you want to perform this action?
Performing the operation "Update Sponsors" on target "externaluser_externaldomain.com"
(externaluser_externaldomain.com#EXT#@contoso.com - 00aa00aa-bb11-cc22-dd33-44ee44ee44ee)".
[Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help (default is "Y"): A

externaluser1_externaldomain.com#EXT#@contoso.com - Sponsor updated successfully for this user.
externaluser1_externaldomain#EXT#@contoso - Sponsor updated successfully for this user.
externaluser1_externaldomain#EXT#@contoso - Sponsor updated successfully for this user.
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

## Outputs

## Notes

- If neither `-UserId` nor `-All` is specified, the cmdlet returns an error.
- The cmdlet retrieves invited users and their inviter information before updating the sponsors.
- The `-All` switch processes all guest users in the tenant.

## Related Links

[Get-EntraUser](Get-EntraBetaUser.md)

[Set-EntraUser](Set-EntraBetaUser.md)
