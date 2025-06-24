---
author: msewaweru
description: This article provides details on the Remove-EntraBetaNamedLocationPolicy command.
external help file: Microsoft.Entra.Beta.SignIns-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 08/01/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Remove-EntraBetaNamedLocationPolicy
schema: 2.0.0
title: Remove-EntraBetaNamedLocationPolicy
---

# Remove-EntraBetaNamedLocationPolicy

## Synopsis

Deletes a Microsoft Entra ID named location policy by PolicyId.

## Syntax

```powershell
Remove-EntraBetaNamedLocationPolicy
 -PolicyId <String>
 [<CommonParameters>]
```

## Description

This cmdlet allows an admin to delete the Microsoft Entra ID named location policy.

Named locations are custom rules that define network locations, which can then be used in a Conditional Access policy.

In delegated scenarios with work or school accounts, when acting on another user, the signed-in user must have a supported Microsoft Entra role or custom role with the required permissions. Supported roles include:

- Security Administrator  
- Conditional Access Administrator

## Examples

### Example 1: Deletes a named location policy in Microsoft Entra ID

```powershell
Connect-Entra -Scopes 'Policy.ReadWrite.ConditionalAccess','Policy.Read.All'
$policy = Get-EntraBetaNamedLocationPolicy | Where-Object {"$_.DisplayName -eq 'IP named location policy'"}
Remove-EntraBetaNamedLocationPolicy -PolicyId $policy.Id
```

This command demonstrates how to delete the named location policy in Microsoft Entra ID.

- `-PolicyId` parameter specifies the Id of named location policy.

## Parameters

### -PolicyId

Specifies the ID of a named location policy in Microsoft Entra ID.

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

## Outputs

## Notes

## Related links

[New-EntraBetaNamedLocationPolicy](New-EntraBetaNamedLocationPolicy.md)

[Set-EntraBetaNamedLocationPolicy](Set-EntraBetaNamedLocationPolicy.md)

[Get-EntraBetaNamedLocationPolicy](Get-EntraBetaNamedLocationPolicy.md)
