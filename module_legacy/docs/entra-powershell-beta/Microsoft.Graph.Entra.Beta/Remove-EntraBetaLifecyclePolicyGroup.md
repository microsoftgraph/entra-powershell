---
title: Remove-EntraBetaLifecyclePolicyGroup
description: This article provides details on the Remove-EntraBetaLifecyclePolicyGroup command.


ms.topic: reference
ms.date: 07/23/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Remove-EntraBetaLifecyclePolicyGroup

schema: 2.0.0
---

# Remove-EntraBetaLifecyclePolicyGroup

## Synopsis

Removes a group from a lifecycle policy.

## Syntax

```powershell
Remove-EntraBetaLifecyclePolicyGroup
 -GroupLifecyclePolicyId <String>
 -GroupId <String>
 [<CommonParameters>]
```

## Description

The `Remove-EntraBetaLifecyclePolicyGroup` cmdlet removes a group from a lifecycle policy in Microsoft Entra ID.

## Examples

### Example 1: Remove lifecycle policy group

```powershell
Connect-Entra -Scopes 'Directory.ReadWrite.All'
$group = Get-EntraBetaGroup -Filter "DisplayName eq 'Office365 group'"
$policy = Get-EntraBetaLifecyclePolicyGroup -Id $group.Id
Remove-EntraBetaLifecyclePolicyGroup -GroupLifecyclePolicyId $policy.Id -GroupId $group.Id
```

```Output
Value
-----
True
```

This example demonstrates how to  remove a group from a lifecycle policy in Microsoft Entra ID with specified Id and groupId.

- `-GroupLifecyclePolicyId` parameter specifies the lifecycle policy object ID.  
- `-GroupId` parameter specifies the ID of Office365 group.

## Parameters

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

### -GroupLifecyclePolicyId

Specifies the ID of the lifecycle policy object in Microsoft Entra ID.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: Id

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

### System.String

## Outputs

### System.Object

## Notes

## Related links

[Add-EntraBetaLifecyclePolicyGroup](Add-EntraBetaLifecyclePolicyGroup.md)

[Get-EntraBetaLifecyclePolicyGroup](Get-EntraBetaLifecyclePolicyGroup.md)
