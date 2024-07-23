---
title: Get-EntraBetaLifecyclePolicyGroup.
description: This article provides details on the Get-EntraBetaLifecyclePolicyGroup command.


ms.topic: reference
ms.date: 06/18/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/en-us/powershell/module/Microsoft.Graph.Entra.Beta/Get-EntraBetaLifecyclePolicyGroup

schema: 2.0.0
---

# Get-EntraBetaLifecyclePolicyGroup

## Synopsis

Retrieves the lifecycle policy object to which a group belongs.

## Syntax

```powershell
Get-EntraBetaLifecyclePolicyGroup 
 -Id <String> 
 [<CommonParameters>]
```

## Description

The `Get-EntraBetaLifecyclePolicyGroup` retrieves the lifecycle policy object to which a group belongs. Specify the `-Id` parameter to get the lifecycle policy object to which a group belongs.

## Examples

### Example 1: Retrieve lifecycle policy object

```powershell
Connect-Entra -Scopes 'Directory.Read.All'
Get-EntraBetaLifecyclePolicyGroup -Id 'ffffffff-5555-6666-7777-aaaaaaaaaaaa'
```

```Output
Id                                   AlternateNotificationEmails GroupLifetimeInDays ManagedGroupTypes
--                                   --------------------------- ------------------- -----------------
bbbbbbbb-1111-2222-3333-cccccccccccc admingroup@contoso.com      200                 All
```

This example demonstrates how to retrieve lifecycle policy object for a group.

## Parameters

### -ID

Specifies the ID of a group in Microsoft Entra ID.

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

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

### System.String

## Outputs

### System.Object

## Notes

## Related Links

[Add-EntraBetaLifecyclePolicyGroup](Add-EntraBetaLifecyclePolicyGroup.md)

[Remove-EntraBetaLifecyclePolicyGroup](Remove-EntraBetaLifecyclePolicyGroup.md)
