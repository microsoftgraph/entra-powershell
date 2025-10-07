---
author: msewaweru
description: This article provides details on the Remove-EntraBetaGroupLifecyclePolicy command.
external help file: Microsoft.Entra.Beta.Groups-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.Beta.Groups
ms.author: eunicewaweru
ms.date: 06/26/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta.Groups/Remove-EntraBetaGroupLifecyclePolicy
schema: 2.0.0
title: Remove-EntraBetaGroupLifecyclePolicy
---

# Remove-EntraBetaGroupLifecyclePolicy

## SYNOPSIS

Deletes a groupLifecyclePolicies object

## SYNTAX

```powershell
Remove-EntraBetaGroupLifecyclePolicy
 -GroupLifecyclePolicyId <String>
 [<CommonParameters>]
```

## DESCRIPTION

The `Remove-EntraBetaGroupLifecyclePolicy` command deletes a groupLifecyclePolicies object in Microsoft Entra ID. Specify `GroupLifecyclePolicyId` parameter deletes the groupLifecyclePolicies object.

## EXAMPLES

### Example 1: Remove a groupLifecyclePolicies

```powershell
Connect-Entra -Scopes 'Directory.ReadWrite.All'
Get-EntraBetaGroupLifecyclePolicy | Where-Object {$_.AlternateNotificationEmails -eq 'example@contoso.com'} | Remove-EntraBetaGroupLifecyclePolicy
```

This example demonstrates how to delete the groupLifecyclePolicies object that has the specified ID. You can use `Get-EntraBetaGroupLifecyclePolicy` to get Id details.

## PARAMETERS

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

## INPUTS

### System.String

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS

[Get-EntraBetaGroupLifecyclePolicy](Get-EntraBetaGroupLifecyclePolicy.md)

[New-EntraBetaGroupLifecyclePolicy](New-EntraBetaGroupLifecyclePolicy.md)

[Set-EntraBetaGroupLifecyclePolicy](Set-EntraBetaGroupLifecyclePolicy.md)
