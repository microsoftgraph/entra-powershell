---
title: Add-EntraLifecyclePolicyGroup
description: This article provides details on the Add-EntraLifecyclePolicyGroup command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Add-EntraLifecyclePolicyGroup

schema: 2.0.0
---

# Add-EntraLifecyclePolicyGroup

## Synopsis

Adds a group to a lifecycle policy.

## Syntax

```powershell
Add-EntraLifecyclePolicyGroup
 -GroupId <String>
 -GroupLifecyclePolicyId <String>
 [<CommonParameters>]
```

## Description

The `Add-EntraLifecyclePolicyGroup` cmdlet adds a group to a lifecycle policy in Microsoft Entra ID.

## Examples

### Example 1: Add a group to the lifecycle policy

```powershell
Connect-Entra -Scopes 'Directory.ReadWrite.All'
$group = Get-EntraGroup -Filter "DisplayName eq 'Office365 group'"
$policy = Get-EntraGroupLifecyclePolicy | Select-Object -First 1
$params = @{
    GroupLifecyclePolicyId = $policy.Id
    groupId = $group.ObjectId
}
Add-EntraLifecyclePolicyGroup @params
```

This example adds a group to the lifecycle policy.

- `-GroupLifecyclePolicyId` parameter specifies the ID of the Lifecycle Policy add to the group.
- `-GroupId`  parameter specifies the ID of the group add to the Lifecycle Policy.

## Parameters

### -GroupId

Specifies the ID of an Office365 group in Microsoft Entra ID.

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

## Related Links

[Get-EntraLifecyclePolicyGroup](Get-EntraLifecyclePolicyGroup.md)

[Remove-EntraLifecyclePolicyGroup](Remove-EntraLifecyclePolicyGroup.md)
