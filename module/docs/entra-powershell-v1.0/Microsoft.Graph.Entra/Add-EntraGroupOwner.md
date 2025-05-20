---
title: Add-EntraGroupOwner
description: This article explains the Add-EntraGroupOwner command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Add-EntraGroupOwner

schema: 2.0.0
---

# Add-EntraGroupOwner

## Synopsis

Adds an owner to a group.

## Syntax

```powershell
Add-EntraGroupOwner
 -GroupId <String>
 -RefObjectId <String>
 [<CommonParameters>]
```

## Description

The `Add-EntraGroupOwner` cmdlet adds an owner to a Microsoft Entra ID group. Specify the `GroupId` and `RefObjectId` parameters to add an owner to a group.

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
Add-EntraGroupOwner -GroupId $group.Id -RefObjectId $user.Id
```

This example demonstrates how to add an owner to a group.

- `-GroupId` - Specifies the unique identifier (Object ID) of the group to which you want to add an owner.
- `-RefObjectId` - Specifies the unique identifier (Object ID) of the owner to be added to the group.

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

### -RefObjectId

Specifies the ID of the Microsoft Entra ID object that will be assigned as owner/manager/member.

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

[Get-EntraGroupOwner](Get-EntraGroupOwner.md)

[Remove-EntraGroupOwner](Remove-EntraGroupOwner.md)
