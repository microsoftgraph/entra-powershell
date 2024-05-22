---
title: Add-EntraMSLifecyclePolicyGroup
description: This article provides details on the Add-EntraMSLifecyclePolicyGroup command.

ms.service: active-directory
ms.topic: reference
ms.date: 03/22/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi254
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Add-EntraMSLifecyclePolicyGroup

## SYNOPSIS

Adds a group to a lifecycle policy

## SYNTAX

```powershell
Add-EntraMSLifecyclePolicyGroup 
 -GroupId <String> 
 -Id <String> 
 [<CommonParameters>]
```

## DESCRIPTION

The Add-EntraMSLifecyclePolicyGroup cmdlet adds a group to a lifecycle policy in Microsoft Entra ID.

## EXAMPLES

### Example 1: Add a group to the lifecycle policy

```powershell
PS C:\>Connect-Entra -Scopes 'Directory.ReadWrite.All'
PS C:\>Add-EntraMSLifecyclePolicyGroup -Id 'b4c908b0-3595-4add-91b4-c5400b31b57b' -groupId 'cffd97bd-6b91-4c4e-b553-6918a320211c'
```

This command is used to add a group to a Microsoft Lifecycle Policy. The `-Id` parameter specifies the ID of the Lifecycle Policy to which the group should be added. The `-groupId` parameter specifies the ID of the group to be added to the Lifecycle Policy.

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
