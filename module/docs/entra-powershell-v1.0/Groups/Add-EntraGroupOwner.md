---
description: This article explains the Add-EntraGroupOwner command.
external help file: Microsoft.Entra.Groups-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra
ms.author: eunicewaweru
ms.date: 02/08/2025
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Add-EntraGroupOwner
schema: 2.0.0
title: Add-EntraGroupOwner
---

# Add-EntraGroupOwner

## Synopsis

Add a user or service principal as an owner of a Microsoft 365 or security group.

## Syntax

```powershell
Add-EntraGroupOwner
 -GroupId <String>
 -OwnerId <String>
 [-WhatIf]
 [-Confirm]
 [<CommonParameters>]
```

## Description

The `Add-EntraGroupOwner` cmdlet adds a user or service principal as an owner of a Microsoft 365 or security group. Owners can modify the group.

`New-EntraGroupOwner` is an alias of `Add-EntraGroupOwner`.

In delegated scenarios, the signed-in user must have either a supported Microsoft Entra role or a custom role with the necessary permissions. The minimum roles required for this operation are:

- Group owners
- User Administrator
- Directory Writers
- Groups Administrator

## Examples

### Example 1: Add an owner to a group

```powershell
Connect-Entra -Scopes 'Group.ReadWrite.All'
$group = Get-EntraGroup -Filter "DisplayName eq 'HelpDesk Team Leaders'"
$user = Get-EntraUser -UserId 'SawyerM@contoso.com'
Add-EntraGroupOwner -GroupId $group.Id -OwnerId $user.Id
```

This example demonstrates how to add an owner to a group.

- `-GroupId` - Specifies the unique identifier (Object ID) of the group to which you want to add an owner.
- `-OwnerId` - Specifies the unique identifier (Object ID) of the owner to be added to the group.

## Parameters

### -GroupId

Specifies the ID of a group in Microsoft Entra ID.

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

### -OwnerId

Specifies the Object ID of a user or service principal to assign as a group owner.

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

## Inputs

## Outputs

## Notes

## Related links

[Get-EntraGroupOwner](Get-EntraGroupOwner.md)

[Remove-EntraGroupOwner](Remove-EntraGroupOwner.md)
