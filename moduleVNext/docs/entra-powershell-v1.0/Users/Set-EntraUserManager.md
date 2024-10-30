---
title: Set-EntraUserManager
description: This article provides details on the Set-EntraUserManager command.

ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Set-EntraUserManager

schema: 2.0.0
---

# Set-EntraUserManager

## Synopsis

Updates a user's manager.

## Syntax

```powershell
Set-EntraUserManager
 -UserId <String>
 -RefObjectId <String>
 [<CommonParameters>]
```

## Description

The `Set-EntraUserManager` cmdlet update the manager for a user in Microsoft Entra ID. Specify the `UserId` and `RefObjectId` parameters to update the manager for a user in Microsoft Entra ID.

## Examples

### Example 1: Update a user's manager

```powershell
Connect-Entra -Scopes 'User.ReadWrite.All'
$manager = Get-EntraUser -UserId 'Manager@contoso.com'
$params = @{
    UserId = 'SawyerM@contoso.com'
    RefObjectId = $manager.ObjectId
}
Set-EntraUserManager @params
```

This example demonstrates how to update the manager for the specified user.

## Parameters

### -UserId

Specifies the ID (as a User Principle Name or ObjectId) of a user in Microsoft Entra ID.

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

## Inputs

## Outputs

## Notes

## Related links

[Get-EntraUserManager](Get-EntraUserManager.md)

[Remove-EntraUserManager](Remove-EntraUserManager.md)