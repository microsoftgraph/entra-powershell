---
title: Remove-EntraBetaNamedLocationPolicy
description: This article provides details on the Remove-EntraBetaNamedLocationPolicy command.


ms.topic: reference
ms.date: 08/01/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Entra.Beta.SignIns-Help.xml
Module Name: Microsoft.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Remove-EntraBetaNamedLocationPolicy

schema: 2.0.0
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

## Examples

### Example 1: Deletes a named location policy in Microsoft Entra ID

```powershell
Connect-Entra -Scopes 'Policy.ReadWrite.ConditionalAccess'
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

## Related Links

[New-EntraBetaNamedLocationPolicy](New-EntraBetaNamedLocationPolicy.md)

[Set-EntraBetaNamedLocationPolicy](Set-EntraBetaNamedLocationPolicy.md)

[Get-EntraBetaNamedLocationPolicy](Get-EntraBetaNamedLocationPolicy.md)
