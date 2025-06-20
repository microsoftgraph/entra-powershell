---
author: msewaweru
description: This article provides details on the Add-EntraBetaGroupOwner command.
external help file: Microsoft.Entra.Beta.Groups-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 02/08/2025
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Add-EntraBetaGroupOwner
schema: 2.0.0
title: Add-EntraBetaGroupOwner
---

# Add-EntraBetaGroupOwner

## Synopsis

Add a user or service principal as an owner of a Microsoft 365 or security group.

## Syntax

```powershell
Add-EntraBetaGroupOwner
 -GroupId <String>
 -OwnerId <String>
 [-WhatIf]
 [-Confirm]
 [<CommonParameters>]
```

## Description

The `Add-EntraBetaGroupOwner` cmdlet adds a user or service principal as an owner of a Microsoft 365 or security group. Owners can modify the group.

`New-EntraBetaGroupOwner` is an alias of `Add-EntraBetaGroupOwner`.

In delegated scenarios, the signed-in user must have either a supported Microsoft Entra role or a custom role with the necessary permissions. The minimum roles required for this operation are:

- Group owners
- User Administrator
- Directory Writers
- Groups Administrator

## Examples

### Example 1: Add an owner to a group

```powershell
Connect-Entra -Scopes 'Group.ReadWrite.All'
$group = Get-EntraBetaGroup -Filter "DisplayName eq 'HelpDesk Team Leaders'"
$user = Get-EntraBetaUser -UserId 'SawyerM@contoso.com'
Add-EntraBetaGroupOwner -GroupId $group.Id -OwnerId $user.Id
```

This example demonstrates how to add an owner to a group.

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

[Get-EntraBetaGroupOwner](Get-EntraBetaGroupOwner.md)

[Remove-EntraBetaGroupOwner](Remove-EntraBetaGroupOwner.md)
