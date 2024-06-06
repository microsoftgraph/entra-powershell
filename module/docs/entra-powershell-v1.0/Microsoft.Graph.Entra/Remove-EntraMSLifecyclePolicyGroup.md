---
title: Remove-EntraMSLifecyclePolicyGroup
description: This article provides details on the Remove-EntraMSLifecyclePolicyGroup command.

ms.service: entra
ms.topic: reference
ms.date: 03/16/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Remove-EntraMSLifecyclePolicyGroup

## SYNOPSIS

Removes a group from a lifecycle policy.

## SYNTAX

```powershell
Remove-EntraMSLifecyclePolicyGroup 
 -GroupId <String> 
 -Id <String> 
 [<CommonParameters>]
```

## DESCRIPTION

The Remove-EntraMSLifecyclePolicyGroup cmdlet removes a group from a lifecycle policy in Microsoft Entra ID.

## EXAMPLES

### Example 1: Remove a group from a lifecycle policy

```powershell
Connect-Entra -Scopes 'Directory.ReadWrite.All'
Remove-EntraMSLifecyclePolicyGroup -Id '1aaaaaa1-2bb2-3cc3-4dd4-5eeeeeeeeee5' -GroupId 'kkkkkkkk-3333-5555-1111-nnnnnnnnnnnn'
```

This example demonstrates how to  remove a group from a lifecycle policy in Microsoft Entra ID with specified Id and groupId.  

Id - Specifies the ID of the lifecycle policy object.  

GroupId - Specifies the ID of a group.

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

## INPUTS

### System.String

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS

[Get-EntraMSLifecyclePolicyGroup](Get-EntraMSLifecyclePolicyGroup.md)

[Add-EntraMSLifecyclePolicyGroup](Add-EntraMSLifecyclePolicyGroup.md)
