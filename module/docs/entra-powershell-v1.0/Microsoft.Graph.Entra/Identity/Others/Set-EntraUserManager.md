---
title: Set-EntraUserManager.
description: This article provides details on the Set-EntraUserManager command.

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

# Set-EntraUserManager

## SYNOPSIS

Updates a user's manager.

## SYNTAX

```powershell
Set-EntraUserManager 
 -ObjectId <String> 
 -RefObjectId <String> 
 [<CommonParameters>]
```

## DESCRIPTION

The Set-EntraUserManager cmdlet update the manager for a user in Microsoft Entra ID.

## EXAMPLES

### Example 1: Update a user's manager

```powershell
Connect-Entra -Scopes 'User.ReadWrite.All'
Set-EntraUserManager -ObjectId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb' -RefObjectId 'eeeeeeee-4444-5555-6666-ffffffffffff'
```

This example demonstrates how to set the manager, with ID `eeeeeeee-4444-5555-6666-ffffffffffff` for the user with the ID `aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb`.

## PARAMETERS

### -ObjectId

Specifies the ID (as a UserPrincipalName or ObjectId) of a user in Microsoft Entra ID.

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

### -RefObjectId

Specifies the ID of the Microsoft Entra ID object to assign as owner/manager/member.

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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraUserManager](Get-EntraUserManager.md)

[Remove-EntraUserManager](Remove-EntraUserManager.md)
