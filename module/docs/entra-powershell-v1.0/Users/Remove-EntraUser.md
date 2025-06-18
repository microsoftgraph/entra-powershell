---
author: msewaweru
description: This article provides details on the Remove-EntraUser command.
external help file: Microsoft.Entra.Users-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra
ms.author: eunicewaweru
ms.date: 06/26/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Remove-EntraUser
schema: 2.0.0
title: Remove-EntraUser
---

# Remove-EntraUser

## Synopsis

Removes a user.

## Syntax

```powershell
Remove-EntraUser
 -UserId <String>
 [<CommonParameters>]
```

## Description

The `Remove-EntraUser` cmdlet removes a user in Microsoft Entra ID. Specify the `UserId` parameter to remove the specified user in Microsoft Entra ID.

The calling user must be assigned at least one of the following Microsoft Entra roles:

- User Administrator
- Privileged Authentication Administrator

## Examples

### Example 1: Remove a user

```powershell
Connect-Entra -Scopes 'User.ReadWrite.All'
Remove-EntraUser -UserId 'SawyerM@Contoso.com'
```

This command removes the specified user in Microsoft Entra ID.

### Example 2: Remove a user based on search results

```powershell
Connect-Entra -Scopes 'User.ReadWrite.All'
Get-EntraUser -UserId 'SawyerM@Contoso.com' | Remove-EntraUser
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

[Get-EntraUser](Get-EntraUser.md)

[New-EntraUser](New-EntraUser.md)

[Set-EntraUser](Set-EntraUser.md)
