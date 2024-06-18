---
title: Get-EntraBetaMSLifecyclePolicyGroup.
description: This article provides details on the Get-EntraBetaMSLifecyclePolicyGroup command.

ms.service: active-directory
ms.topic: reference
ms.date: 06/18/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Get-EntraBetaMSLifecyclePolicyGroup

## SYNOPSIS
Retrieves the lifecycle policy object to which a group belongs.

## SYNTAX

```powershell
Get-EntraBetaMSLifecyclePolicyGroup 
 -Id <String> 
 [<CommonParameters>]
```

## DESCRIPTION
The Get-EntraBetaMSLifecyclePolicyGroup retrieves the lifecycle policy object to which a group belongs.

## EXAMPLES

### Example 1
```powershell
Connect-Entra -Scopes 'Directory.Read.All'
Get-EntraBetaMSLifecyclePolicyGroup -Id cffd97bd-6b91-4c4e-b553-6918a320211c
```
```output
Id                                   AlternateNotificationEmails GroupLifetimeInDays ManagedGroupTypes
--                                   --------------------------- ------------------- -----------------
bbbbbbbb-1111-2222-3333-cccccccccccc admingroup@contoso.com      200                 All
```

This example demonstrates how to retrieve lifecycle policy object by `Id` in Microsoft Entra ID.  
This command retrieves the lifecycle policy object to which a group belongs.

## PARAMETERS

### -Id
Specifies the ID of a group in in Microsoft Entra ID. 

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
