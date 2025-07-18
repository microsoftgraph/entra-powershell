---
author: msewaweru
description: This article provides details on the Remove-EntraBetaUser command.
external help file: Microsoft.Entra.Beta.Users-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 06/20/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Remove-EntraBetaUser
schema: 2.0.0
title: Remove-EntraBetaUser
---

# Remove-EntraBetaUser

## SYNOPSIS

Removes a user.

## SYNTAX

```powershell
Remove-EntraBetaUser
 -UserId <String>
 [<CommonParameters>]
```

## DESCRIPTION

The `Remove-EntraBetaUser` cmdlet removes a user in Microsoft Entra ID. Specify the `UserId` parameter to remove the specified user in Microsoft Entra ID.

The calling user must be assigned at least one of the following Microsoft Entra roles:

- User Administrator
- Privileged Authentication Administrator

## EXAMPLES

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

## PARAMETERS

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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraBetaUser](Get-EntraBetaUser.md)

[New-EntraBetaUser](New-EntraBetaUser.md)

[Set-EntraBetaUser](Set-EntraBetaUser.md)
