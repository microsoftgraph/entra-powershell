---
title: Remove-EntraUserManager
description: This article provides details on the Remove-EntraUserManager command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Remove-EntraUserManager

schema: 2.0.0
---

# Remove-EntraUserManager

## Synopsis

Removes a user's manager.

## Syntax

```powershell
Remove-EntraUserManager 
 -ObjectId <String> 
```

## Description

The Remove-EntraUserManager cmdlet removes a user's manager in Microsoft Entra ID.

## Examples

### Example 1: Remove the manager of a user

```powershell
Connect-Entra -Scopes 'User.ReadWrite.All'
$User = Get-EntraUser -Top 1
Remove-EntraUserManager -ObjectId $User.ObjectId
```

This example demonstrates how to removes a user's manager.

- The first command gets a user by using the `Get-EntraUser` cmdlet, and then stores it in the $User variable.

- The second command removes the user in $User.

## Parameters

### -ObjectId

Specifies the ID of a user (as a User Principle Name or ObjectId) in Microsoft Entra ID.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

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

[Get-EntraUserManager](Get-EntraUserManager.md)

[Set-EntraUserManager](Set-EntraUserManager.md)
