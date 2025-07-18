---
title: Remove-EntraBetaConditionalAccessPolicy
description: This article provides details on the Remove-EntraBetaConditionalAccessPolicy command.


ms.topic: reference
ms.date: 07/30/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: mwongerapk

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Remove-EntraBetaConditionalAccessPolicy

schema: 2.0.0
---

# Remove-EntraBetaConditionalAccessPolicy

## Synopsis

Deletes a conditional access policy in Microsoft Entra ID by Id.

## Syntax

```powershell
Remove-EntraBetaConditionalAccessPolicy
 -PolicyId <String>
 [<CommonParameters>]
```

## Description

This cmdlet allows an admin to delete a conditional access policy in Microsoft Entra ID by Id.

Conditional access policies are custom rules that define an access scenario.

## Examples

### Example 1: Deletes a conditional access policy in Microsoft Entra ID by PolicyId

```powershell
Connect-Entra -Scopes 'Policy.Read.All'
$policy = Get-EntraBetaConditionalAccessPolicy | Where-Object {$_.DisplayName -eq 'MFA policy'}
Remove-EntraBetaConditionalAccessPolicy -PolicyId $policy.ObjectId
```

This command deletes a conditional access policy in Microsoft Entra ID.

- `-PolicyId` parameter specifies the Id of a conditional access policy.

## Parameters

### -PolicyId

Specifies the policy Id of a conditional access policy in Microsoft Entra ID.

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

[Get-EntraBetaConditionalAccessPolicy](Get-EntraBetaConditionalAccessPolicy.md)

[New-EntraBetaConditionalAccessPolicy](New-EntraBetaConditionalAccessPolicy.md)

[Set-EntraBetaConditionalAccessPolicy](Set-EntraBetaConditionalAccessPolicy.md)
