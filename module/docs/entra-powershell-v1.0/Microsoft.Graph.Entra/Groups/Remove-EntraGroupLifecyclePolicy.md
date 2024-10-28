---
title: Remove-EntraGroupLifecyclePolicy
description: This article provides details on the Remove-EntraGroupLifecyclePolicy command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Remove-EntraGroupLifecyclePolicy

schema: 2.0.0
---

# Remove-EntraGroupLifecyclePolicy

## Synopsis

Deletes a groupLifecyclePolicies object

## Syntax

```powershell
Remove-EntraGroupLifecyclePolicy
 -GroupLifecyclePolicyId <String>
 [<CommonParameters>]
```

## Description

The `Remove-EntraGroupLifecyclePolicy` command deletes a groupLifecyclePolicies object in Microsoft Entra ID. Specify `Id` parameter deletes the groupLifecyclePolicies object.

## Examples

### Example 1: Remove a groupLifecyclePolicies

```powershell
Connect-Entra -Scopes 'Directory.ReadWrite.All'
Remove-EntraGroupLifecyclePolicy -GroupLifecyclePolicyId '1aaaaaa1-2bb2-3cc3-4dd4-5eeeeeeeeee5'
```

This example demonstrates how to delete the groupLifecyclePolicies object that has the specified ID. You can use `Get-EntraGroupLifecyclePolicy` to get Id details.

## Parameters

### -GroupLifecyclePolicyId

Specifies the ID of the groupLifecyclePolicies object that this cmdlet removes.

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

[Get-EntraGroupLifecyclePolicy](Get-EntraGroupLifecyclePolicy.md)

[New-EntraGroupLifecyclePolicy](New-EntraGroupLifecyclePolicy.md)

[Set-EntraGroupLifecyclePolicy](Set-EntraGroupLifecyclePolicy.md)
