---
title: Get-EntraUserExtension.
description: This article provides details on the Get-EntraUserExtension command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/en-us/powershell/module/Microsoft.Graph.Entra/Get-EntraUserExtension

schema: 2.0.0
---

# Get-EntraUserExtension

## Synopsis

Gets a user extension.

## Syntax

```powershell
Get-EntraUserExtension
 -ObjectId <String>
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

The Get-EntraUserExtension cmdlet gets a user extension in Microsoft Entra ID.

## Examples

### Example 1: Retrieve extension attributes for a user

```powershell
Connect-Entra -Scopes 'User.Read'
$UserId = (Get-EntraUser -Top 1).ObjectId
Get-EntraUserExtension -ObjectId $UserId
```

This example shows how to retrieve the extension attributes for a specified user.

- The first command gets the ID of a Microsoft Entra ID user by using the `Get-EntraUser` (./Get-EntraUser.md) cmdlet. The command stores the value in the $UserId variable.  

- The second command retrieves all extension attributes that have a value assigned to them for the user identified by $UserId.

## Parameters

### -ObjectId

Specifies the ID of an object.

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

### -Property

Specifies properties to be returned

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related Links

[Get-EntraUser](Get-EntraUser.md)

[Remove-EntraUserExtension](Remove-EntraUserExtension.md)

[Set-EntraUserExtension](Set-EntraUserExtension.md)
