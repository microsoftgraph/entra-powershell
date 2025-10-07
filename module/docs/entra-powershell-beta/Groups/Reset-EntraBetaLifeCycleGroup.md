---
author: msewaweru
description: This article provides details on the Reset-EntraBetaLifeCycleGroup command.
external help file: Microsoft.Entra.Beta.Groups-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.Beta.Groups
ms.author: eunicewaweru
ms.date: 07/23/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta.Groups/Reset-EntraBetaLifeCycleGroup
schema: 2.0.0
title: Reset-EntraBetaLifeCycleGroup
---

# Reset-EntraBetaLifeCycleGroup

## SYNOPSIS

Renews a group by updating the RenewedDateTime property on a group to the current DateTime.

## SYNTAX

```powershell
Reset-EntraBetaLifeCycleGroup
 -GroupId <String>
 [<CommonParameters>]
```

## DESCRIPTION

The `Reset-EntraBetaLifeCycleGroup` renews a group by updating the RenewedDateTime property on a group to the current DateTime.
When a group is renewed, the group expiration is extended by the number of days defined in the policy.

## EXAMPLES

### Example 1: Renew a group

```powershell
Connect-Entra -Scopes 'Group.ReadWrite.All'
$group = Get-EntraBetaGroup -Filter "DisplayName eq 'Sales and Marketing'"
Reset-EntraBetaLifeCycleGroup -GroupId $group.Id
```

This example demonstrates how to renew a specified group.

- `-GroupId` - Specifies the lifecycle policy object ID.

## PARAMETERS

### -GroupId

Specifies the ID of a group in Microsoft Entra ID.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS
