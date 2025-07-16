---
author: msewaweru
description: This article provides details on the Remove-EntraBetaUserManager command.
external help file: Microsoft.Entra.Beta.Users-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 02/05/2025
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Remove-EntraBetaUserManager
schema: 2.0.0
title: Remove-EntraBetaUserManager
---

# Remove-EntraBetaUserManager

## SYNOPSIS

Removes a user's manager.

## SYNTAX

```powershell
Remove-EntraBetaUserManager
 -UserId <String>
 [<CommonParameters>]
```

## DESCRIPTION

The `Remove-EntraBetaUserManager` cmdlet removes a user's manager in Microsoft Entra ID. Specify the `UserId` parameter to remove the manager for a user in Microsoft Entra ID.

## EXAMPLES

### Example 1: Remove the manager of a user

```powershell
Connect-Entra -Scopes 'User.ReadWrite.All'
Remove-EntraBetaUserManager -UserId 'SawyerM@Contoso.com'
```

This example shows how to remove a user's manager.

You can use `Get-EntraBetaUser` command to get the user's details.

### Example 2: Remove the manager of a user via pipelining

```powershell
Connect-Entra -Scopes 'User.ReadWrite.All'
Get-EntraBetaUser -UserId 'SawyerM@Contoso.com' | Remove-EntraBetaUserManager
```

This example shows how to remove a user's manager.

## PARAMETERS

### -UserId

Specifies the ID of a user (as a User Principle Name or ObjectId) in Microsoft Entra ID.

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

[Get-EntraBetaUserManager](Get-EntraBetaUserManager.md)

[Set-EntraBetaUserManager](Set-EntraBetaUserManager.md)
