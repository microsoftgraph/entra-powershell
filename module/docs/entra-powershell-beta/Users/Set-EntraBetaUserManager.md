---
author: msewaweru
description: This article provides details on the Set-EntraBetaUserManager command.
external help file: Microsoft.Entra.Beta.Users-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 02/05/2025
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Set-EntraBetaUserManager
schema: 2.0.0
title: Set-EntraBetaUserManager
---

# Set-EntraBetaUserManager

## SYNOPSIS

Updates a user's manager.

## SYNTAX

```powershell
Set-EntraBetaUserManager
 -UserId <String>
 -ManagerId <String>
 [<CommonParameters>]
```

## DESCRIPTION

The `Set-EntraBetaUserManager` cmdlet update the manager for a user in Microsoft Entra ID. Specify the `UserId` and `ManagerId` parameters to update the manager for a user in Microsoft Entra ID.

## EXAMPLES

### Example 1: Update a user's manager

```powershell
Connect-Entra -Scopes 'User.ReadWrite.All'
Set-EntraBetaUserManager -UserId 'SawyerM@contoso.com' -ManagerId 'Manager@contoso.com'
```

This example demonstrates how to update the manager for the specified user.

## PARAMETERS

### -UserId

Specifies the ID (as a User Principle Name or ObjectId) of a user in Microsoft Entra ID.

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

### -ManagerId

Specifies the ID of the Microsoft Entra ID object to assign as owner/manager/member.

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

[Get-EntraBetaUserManager](Get-EntraBetaUserManager.md)

[Remove-EntraBetaUserManager](Remove-EntraBetaUserManager.md)
