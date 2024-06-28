---
title: Reset-EntraLifeCycleGroup.
description: This article provides details on the Reset-EntraLifeCycleGroup command.

ms.service: entra
ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Reset-EntraLifeCycleGroup

## Synopsis

Renews a group by updating the RenewedDateTime property on a group to the current DateTime.

## Syntax

```powershell
Reset-EntraLifeCycleGroup 
 -Id <String> 
 [<CommonParameters>]
```

## Description

The Reset-EntraLifeCycleGroup renews a group by updating the RenewedDateTime property on a group to the current DateTime.
When a group is renewed, it extends the group expiration by the number of days defined in the policy.

## Examples

### Example 1: Renew a group

```powershell
Connect-Entra -Scopes 'Group.ReadWrite.All'
Reset-EntraLifeCycleGroup -Id 'hhhhhhhh-8888-9999-8888-cccccccccccc'
```

This example demonstrates how to renew a specified group.  
The Reset-EntraLifeCycleGroup renews a specified group by updating the RenewedDateTime property on a group to the current DateTime.

## Parameters

### -Id

The unique identifier of group.

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

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

### None

## Outputs

### System.Object

## Notes

## Related Links
