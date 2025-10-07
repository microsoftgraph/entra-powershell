---
author: msewaweru
description: This article provides details on the Remove-EntraBetaGroupMember command.
external help file: Microsoft.Entra.Beta.Groups-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.Beta.Groups
ms.author: eunicewaweru
ms.date: 06/18/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta.Groups/Remove-EntraBetaGroupMember
schema: 2.0.0
title: Remove-EntraBetaGroupMember
---

# Remove-EntraBetaGroupMember

## SYNOPSIS

Removes a member from a group.

## SYNTAX

```powershell
Remove-EntraBetaGroupMember
 -GroupId <String>
 -MemberId <String>
 [<CommonParameters>]
```

## DESCRIPTION

The `Remove-EntraBetaGroupMember` cmdlet removes a member from a group in Microsoft Entra ID. Specify the `GroupId` and `MemberId` parameters to remove a member from a group.

## EXAMPLES

### Example 1: Remove a member

```powershell
Connect-Entra -Scopes 'GroupMember.ReadWrite.All'
$group = Get-EntraBetaGroup -Filter "DisplayName eq 'HelpDesk Team Leaders'"
$groupMember = Get-EntraBetaGroup -GroupId $group.Id | Get-EntraBetaGroupMember | Where-Object {$_.displayName -eq 'Adele Vance'}
Remove-EntraBetaGroupMember -GroupId $group.Id -MemberId $groupMember.Id
```

This example demonstrates how to remove a member from a group in Microsoft Entra ID.

## PARAMETERS

### -MemberId

Specifies the ID of the member to remove.

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

### -GroupId

Specifies the object ID of a group in Microsoft Entra ID.

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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Add-EntraBetaGroupMember](Add-EntraBetaGroupMember.md)

[Get-EntraBetaGroupMember](Get-EntraBetaGroupMember.md)
