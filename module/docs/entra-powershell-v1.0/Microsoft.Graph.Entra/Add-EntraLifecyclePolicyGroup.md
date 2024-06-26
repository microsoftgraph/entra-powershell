---
title: Add-EntraLifecyclePolicyGroup
description: This article provides details on the Add-EntraLifecyclePolicyGroup command.

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

# Add-EntraLifecyclePolicyGroup

## Synopsis

adds a group to a lifecycle policy

## Syntax

```powershell
Add-EntraLifecyclePolicyGroup 
 -GroupId <String> 
 -Id <String> 
 [<CommonParameters>]
```

## Description

the Add-EntraLifecyclePolicyGroup cmdlet adds a group to a lifecycle policy in Microsoft Entra ID.

## Examples

### Example 1: Add a group to the lifecycle policy

```powershell
Connect-Entra -Scopes 'Directory.ReadWrite.All'
Add-EntraLifecyclePolicyGroup -Id '2bbbbbb2-3cc3-4dd4-5ee5-6ffffffffff6' -groupId 'hhhhhhhh-3333-5555-3333-qqqqqqqqqqqq'
```

This command adds a group to a Microsoft Lifecycle Policy. The `-Id` parameter specifies the ID of the Lifecycle Policy to which the group should be added. The `-groupId` parameter specifies the ID of the group to be added to the Lifecycle Policy.

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

### -Id

Specifies the ID of the lifecycle policy object in Microsoft Entra ID.

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

### System.String

## Outputs

### System.Object

## Notes

## Related Links
