---
title: Remove-EntraPolicy
description: This article provides details on the Remove-EntraPolicy command.

ms.topic: reference
ms.date: 07/16/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Remove-EntraPolicy
schema: 2.0.0
---

# Remove-EntraPolicy

## Synopsis

Removes a policy.

## Syntax

```powershell
Remove-EntraPolicy
 -Id <String>
 [<CommonParameters>]
```

## Description

The `Remove-EntraPolicy` cmdlet removes a policy from Microsoft Entra ID. Specify `Id` parameter to remove a specific policy.

## Examples

### Example 1: Remove a policy

```powershell
Connect-Entra -Scopes 'Policy.Read.ApplicationConfiguration'
$policy = Get-EntraPolicy | Where-Object {$_.DisplayName -eq 'Microsoft User Default Recommended Policy'}
Remove-EntraPolicy -Id $policy.Id
```

This command removes the specified policy from Microsoft Entra ID.

- `-Id` - specifies the ID of the policy you want to remove.

## Parameters

### -Id

The Id of the policy you want to remove.

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

[Get-EntraPolicy](Get-EntraPolicy.md)

[New-EntraPolicy](New-EntraPolicy.md)

[Set-EntraPolicy](Set-EntraPolicy.md)
