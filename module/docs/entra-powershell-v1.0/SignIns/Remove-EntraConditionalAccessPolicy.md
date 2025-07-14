---
author: msewaweru
description: This article provides details on the Remove-EntraConditionalAccessPolicy command.
external help file: Microsoft.Entra.SignIns-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra
ms.author: eunicewaweru
ms.date: 06/26/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Remove-EntraConditionalAccessPolicy
schema: 2.0.0
title: Remove-EntraConditionalAccessPolicy
---

# Remove-EntraConditionalAccessPolicy

## SYNOPSIS

Deletes a conditional access policy in Microsoft Entra ID by Id.

## SYNTAX

```powershell
Remove-EntraConditionalAccessPolicy
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
$policy = Get-EntraConditionalAccessPolicy | Where-Object {$_.DisplayName -eq 'MFA policy'}
Remove-EntraConditionalAccessPolicy -PolicyId $policy.Id
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

[Get-EntraConditionalAccessPolicy](Get-EntraConditionalAccessPolicy.md)

[New-EntraConditionalAccessPolicy](New-EntraConditionalAccessPolicy.md)

[Set-EntraConditionalAccessPolicy](Set-EntraConditionalAccessPolicy.md)
