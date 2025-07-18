---
author: msewaweru
description: This article provides details on the Set-EntraUserManager command.
external help file: Microsoft.Entra.Users-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra
ms.author: eunicewaweru
ms.date: 02/05/2025
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Set-EntraUserManager
schema: 2.0.0
title: Set-EntraUserManager
---

# Set-EntraUserManager

## SYNOPSIS

Updates a user's manager.

## SYNTAX

```powershell
Set-EntraUserManager
 -UserId <String>
 -ManagerId <String>
 [<CommonParameters>]
```

## DESCRIPTION

The `Set-EntraUserManager` cmdlet update the manager for a user in Microsoft Entra ID. Specify the `UserId` and `ManagerId` parameters to update the manager for a user in Microsoft Entra ID.

## EXAMPLES

### Example 1: Update a user's manager

```powershell
Connect-Entra -Scopes 'User.ReadWrite.All'
Set-EntraUserManager -UserId 'SawyerM@contoso.com' -ManagerId 'Manager@contoso.com'
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

[Get-EntraUserManager](Get-EntraUserManager.md)

[Remove-EntraUserManager](Remove-EntraUserManager.md)
