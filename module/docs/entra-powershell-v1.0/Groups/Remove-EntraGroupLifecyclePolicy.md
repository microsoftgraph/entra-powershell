---
author: msewaweru
description: This article provides details on the Remove-EntraGroupLifecyclePolicy command.
external help file: Microsoft.Entra.Groups-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra
ms.author: eunicewaweru
ms.date: 06/26/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Remove-EntraGroupLifecyclePolicy
schema: 2.0.0
title: Remove-EntraGroupLifecyclePolicy
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
Get-EntraGroupLifecyclePolicy | Where-Object {$_.AlternateNotificationEmails -eq 'example@contoso.com'} | Remove-EntraGroupLifecyclePolicy
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
