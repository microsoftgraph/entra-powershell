---
title: Remove-EntraBetaGroupLifecyclePolicy
description: This article provides details on the Remove-EntraBetaGroupLifecyclePolicy command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Remove-EntraBetaGroupLifecyclePolicy

schema: 2.0.0
---

# Remove-EntraBetaGroupLifecyclePolicy

## Synopsis

Deletes a groupLifecyclePolicies object

## Syntax

```powershell
Remove-EntraBetaGroupLifecyclePolicy
 -GroupLifecyclePolicyId <String>
 [<CommonParameters>]
```

## Description

The `Remove-EntraBetaGroupLifecyclePolicy` command deletes a groupLifecyclePolicies object in Microsoft Entra ID. Specify `GroupLifecyclePolicyId` parameter deletes the groupLifecyclePolicies object.

## Examples

### Example 1: Remove a groupLifecyclePolicies

```powershell
Connect-Entra -Scopes 'Directory.ReadWrite.All'
Get-EntraBetaGroupLifecyclePolicy | Where-Object {$_.AlternateNotificationEmails -eq 'example@contoso.com'} | Remove-EntraBetaGroupLifecyclePolicy
```

This example demonstrates how to delete the groupLifecyclePolicies object that has the specified ID. You can use `Get-EntraBetaGroupLifecyclePolicy` to get Id details.

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

## Related Links

[Get-EntraBetaGroupLifecyclePolicy](Get-EntraBetaGroupLifecyclePolicy.md)

[New-EntraBetaGroupLifecyclePolicy](New-EntraBetaGroupLifecyclePolicy.md)

[Set-EntraBetaGroupLifecyclePolicy](Set-EntraBetaGroupLifecyclePolicy.md)
