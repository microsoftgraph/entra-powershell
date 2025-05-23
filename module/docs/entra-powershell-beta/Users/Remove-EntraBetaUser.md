---
title: Remove-EntraBetaUser
description: This article provides details on the Remove-EntraBetaUser command.

ms.topic: reference
ms.date: 06/20/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Entra.Beta.Users-Help.xml
Module Name: Microsoft.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Remove-EntraBetaUser

schema: 2.0.0
---

# Remove-EntraBetaUser

## Synopsis

Removes a user.

## Syntax

```powershell
Remove-EntraBetaUser
 -UserId <String>
 [<CommonParameters>]
```

## Description

The `Remove-EntraBetaUser` cmdlet removes a user in Microsoft Entra ID. Specify the `UserId` parameter to remove the specified user in Microsoft Entra ID.

The calling user must be assigned at least one of the following Microsoft Entra roles:

- User Administrator
- Privileged Authentication Administrator

## Examples

### Example 1: Remove a user

```powershell
Connect-Entra -Scopes 'User.ReadWrite.All'
Remove-EntraBetaUser -UserId 'SawyerM@Contoso.com'
```

This command removes the specified user in Microsoft Entra ID.

### Example 2: Remove a user based on search results

```powershell
Connect-Entra -Scopes 'User.ReadWrite.All'
Get-EntraBetaUser -UserId 'SawyerM@Contoso.com' | Remove-EntraBetaUser
```

This command removes the specified user in Microsoft Entra ID.

## Parameters

### -UserId

Specifies the ID of a user (as a UPN or UserId) in Microsoft Entra ID.

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

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related links

[Get-EntraBetaUser](Get-EntraBetaUser.md)

[New-EntraBetaUser](New-EntraBetaUser.md)

[Set-EntraBetaUser](Set-EntraBetaUser.md)
