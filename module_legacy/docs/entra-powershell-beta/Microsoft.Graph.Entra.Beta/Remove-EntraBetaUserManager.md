---
title: Remove-EntraBetaUserManager
description: This article provides details on the Remove-EntraBetaUserManager command.


ms.topic: reference
ms.date: 06/20/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Remove-EntraBetaUserManager

schema: 2.0.0
---

# Remove-EntraBetaUserManager

## Synopsis

Removes a user's manager.

## Syntax

```powershell
Remove-EntraBetaUserManager
 -UserId <String>
 [<CommonParameters>]
```

## Description

The `Remove-EntraBetaUserManager` cmdlet removes a user's manager in Microsoft Entra ID. Specify the `UserId` parameter to remove the manager for a user in Microsoft Entra ID.

## Examples

### Example 1: Remove the manager of a user

```powershell
Connect-Entra -Scopes 'User.ReadWrite.All'
$user = Get-EntraBetaUser -UserId 'SawyerM@Contoso.com'
Remove-EntraBetaUserManager -UserId $user.Id
```

This example shows how to remove a user's manager.

You can use `Get-EntraBetaUser` command to get the user's details.

### Example 2: Remove the manager of a user via pipelining

```powershell
Connect-Entra -Scopes 'User.ReadWrite.All'
Get-EntraBetaUser -UserId 'SawyerM@Contoso.com' | Remove-EntraBetaUserManager
```

This example shows how to remove a user's manager.

## Parameters

### -UserId

Specifies the ID of a user (as a User Principle Name or ObjectId) in Microsoft Entra ID.

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

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related Links

[Get-EntraBetaUserManager](Get-EntraBetaUserManager.md)

[Set-EntraBetaUserManager](Set-EntraBetaUserManager.md)
