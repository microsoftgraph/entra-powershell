---
description: This article provides details on the Remove-EntraBetaConditionalAccessPolicy command.
external help file: Microsoft.Entra.Beta.SignIns-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 07/30/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Remove-EntraBetaConditionalAccessPolicy
schema: 2.0.0
title: Remove-EntraBetaConditionalAccessPolicy
---

# Remove-EntraBetaConditionalAccessPolicy

## SYNOPSIS

Deletes a conditional access policy in Microsoft Entra ID by Id.

## SYNTAX

```powershell
Remove-EntraBetaConditionalAccessPolicy
 -PolicyId <String>
 [<CommonParameters>]
```

## DESCRIPTION

This cmdlet allows an admin to delete a conditional access policy in Microsoft Entra ID by Id.

Conditional access policies are custom rules that define an access scenario.

In delegated scenarios with work or school accounts, when acting on another user, the signed-in user must have a supported Microsoft Entra role or custom role with the necessary permissions. The least privileged roles for this operation are:

- Security Administrator  
- Conditional Access Administrator

## EXAMPLES

### Example 1: Deletes a conditional access policy in Microsoft Entra ID by PolicyId

```powershell
Connect-Entra -Scopes 'Policy.ReadWrite.ConditionalAccess','Policy.Read.All'
$policy = Get-EntraBetaConditionalAccessPolicy | Where-Object {$_.DisplayName -eq 'MFA policy'}
Remove-EntraBetaConditionalAccessPolicy -PolicyId $policy.Id
```

This command deletes a conditional access policy in Microsoft Entra ID.

- `-PolicyId` parameter specifies the Id of a conditional access policy.

## PARAMETERS

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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraBetaConditionalAccessPolicy](Get-EntraBetaConditionalAccessPolicy.md)

[New-EntraBetaConditionalAccessPolicy](New-EntraBetaConditionalAccessPolicy.md)

[Set-EntraBetaConditionalAccessPolicy](Set-EntraBetaConditionalAccessPolicy.md)
