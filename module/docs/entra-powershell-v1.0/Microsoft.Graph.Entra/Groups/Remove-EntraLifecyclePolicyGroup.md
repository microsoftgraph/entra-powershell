---
title: Remove-EntraLifecyclePolicyGroup
description: This article provides details on the Remove-EntraLifecyclePolicyGroup command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Remove-EntraLifecyclePolicyGroup

schema: 2.0.0
---

# Remove-EntraLifecyclePolicyGroup

## Synopsis

Removes a group from a lifecycle policy.

## Syntax

```powershell
Remove-EntraLifecyclePolicyGroup
 -GroupId <String>
 -GroupLifecyclePolicyId <String>
 [<CommonParameters>]
```

## Description

The `Remove-EntraLifecyclePolicyGroup` cmdlet removes a group from a lifecycle policy in Microsoft Entra ID.

## Examples

### Example 1: Remove lifecycle policy group

```powershell
Connect-Entra -Scopes 'Directory.ReadWrite.All'
$group = Get-EntraGroup -Filter "DisplayName eq 'Office365 group'"
$policy = Get-EntraLifecyclePolicyGroup -Id $group.ObjectId
$params = @{
    GroupLifecyclePolicyId = $policy.Id
    GroupId = $group.ObjectId
}
Remove-EntraLifecyclePolicyGroup @params
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

## Related Links

[Get-EntraLifecyclePolicyGroup](Get-EntraLifecyclePolicyGroup.md)

[Add-EntraLifecyclePolicyGroup](Add-EntraLifecyclePolicyGroup.md)
