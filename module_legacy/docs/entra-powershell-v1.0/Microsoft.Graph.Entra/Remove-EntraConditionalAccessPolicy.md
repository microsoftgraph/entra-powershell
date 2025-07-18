---
title: Remove-EntraConditionalAccessPolicy
description: This article provides details on the Remove-EntraConditionalAccessPolicy command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: mwongerapk
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Remove-EntraConditionalAccessPolicy

schema: 2.0.0
---

# Remove-EntraConditionalAccessPolicy

## Synopsis

Deletes a conditional access policy in Microsoft Entra ID by Id.

## Syntax

```powershell
Remove-EntraConditionalAccessPolicy
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
$policy = Get-EntraConditionalAccessPolicy | Where-Object {$_.DisplayName -eq 'MFA policy'}
Remove-EntraConditionalAccessPolicy -PolicyId $policy.ObjectId
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

[Get-EntraConditionalAccessPolicy](Get-EntraConditionalAccessPolicy.md)

[New-EntraConditionalAccessPolicy](New-EntraConditionalAccessPolicy.md)

[Set-EntraConditionalAccessPolicy](Set-EntraConditionalAccessPolicy.md)
