---
title: Add-EntraBetaGroupOwner
description: This article provides details on the Add-EntraBetaGroupOwner command.


ms.topic: reference
ms.date: 06/17/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Add-EntraBetaGroupOwner

schema: 2.0.0
---

# Add-EntraBetaGroupOwner

## Synopsis

Adds an owner to a group.

## Syntax

```powershell
Add-EntraBetaGroupOwner 
 -ObjectId <String>
 -RefObjectId <String>
 [<CommonParameters>]
```

## Description

The `Add-EntraBetaGroupOwner` cmdlet adds an owner to a Microsoft Entra ID group. Specify the `ObjectId` and `RefObjectId` parameters to add an owner to a group.

`-ObjectId` - specifies the unique identifier (Object ID) of the group to which you want to add an owner.

`-RefObjectId` - specifies the unique identifier (Object ID) of the owner to be added to the group (user or service principal).

## Examples

### Example 1: Add an owner to a group

```powershell
Connect-Entra -Scopes 'Group.ReadWrite.All'
$group = Get-EntraBetaGroup -Filter "DisplayName eq 'HelpDesk Team Leaders'"
$user = Get-EntraBetaUser -ObjectId 'SawyerM@contoso.com'
$params = @{
    ObjectId = $group.ObjectId
    RefObjectId = $user.ObjectId
}

Add-EntraBetaGroupOwner @params
```

This example demonstrates how to add an owner to a group.

## Parameters

### -ObjectId

Specifies the ID of a group in Microsoft Entra ID.

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

## Related Links

[Get-EntraBetaGroupOwner](Get-EntraBetaGroupOwner.md)

[Remove-EntraBetaGroupOwner](Remove-EntraBetaGroupOwner.md)
