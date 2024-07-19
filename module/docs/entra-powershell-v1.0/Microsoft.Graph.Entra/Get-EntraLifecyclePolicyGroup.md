---
title: Get-EntraLifecyclePolicyGroup.
description: This article provides details on the Get-EntraLifecyclePolicyGroup command.


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

# Get-EntraLifecyclePolicyGroup

## Synopsis

Retrieves the lifecycle policy object to which a group belongs.

## Syntax

```powershell
Get-EntraLifecyclePolicyGroup
 -Id <String>
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

The Get-EntraLifecyclePolicyGroup retrieves the lifecycle policy object to which a group belongs.

## Examples

### Example 1: Retrieve lifecycle policy object

```powershell
Connect-Entra -Scopes 'Directory.Read.All'
Get-EntraLifecyclePolicyGroup -Id 'bbbbbbbb-1111-2222-3333-cccccccccccc'
```

```output
Id                                   AlternateNotificationEmails GroupLifetimeInDays ManagedGroupTypes
--                                   --------------------------- ------------------- -----------------
bbbbbbbb-1111-2222-3333-cccccccccccc admingroup@contoso.com      200                 All
```

This example demonstrates how to retrieve lifecycle policy object by Id in Microsoft Entra ID.  
This command retrieves the lifecycle policy object to which a group belongs.

## Parameters

### -Id

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

### -Property

Specifies properties to be returned

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
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
