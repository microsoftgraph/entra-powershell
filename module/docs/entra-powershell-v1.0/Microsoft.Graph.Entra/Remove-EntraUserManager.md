---
title: Remove-EntraUserManager.
description: This article provides details on the Remove-EntraUserManager command.

ms.service: entra
ms.topic: reference
ms.date: 03/11/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Remove-EntraUserManager

## SYNOPSIS
Removes a user's manager.

## SYNTAX

```powershell
Remove-EntraUserManager 
 -ObjectId <String> 
```

## DESCRIPTION
The Remove-EntraUserManager cmdlet removes a user's manager in Microsoft Entra ID.

## EXAMPLES

### Example 1: Remove the manager of a user
```powershell
PS C:\> $User = Get-EntraUser -Top 1
PS C:\> Remove-EntraUserManager -ObjectId $User.ObjectId
```

The first command gets a user by using the [Get-EntraUser](./Get-EntraUser.md) cmdlet, and then stores it in the $User variable.

The second command removes the user in $User.

## PARAMETERS

### -ObjectId
Specifies the ID of a user (as a User Principle Name or ObjectId) in Microsoft Entra ID.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraUserManager](Get-EntraUserManager.md)

[Set-EntraUserManager](Set-EntraUserManager.md)

