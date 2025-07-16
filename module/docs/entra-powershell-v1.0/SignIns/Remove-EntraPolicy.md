---
author: msewaweru
description: This article provides details on the Remove-EntraPolicy command.
external help file: Microsoft.Entra.SignIns-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra
ms.author: eunicewaweru
ms.date: 07/16/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Remove-EntraPolicy
schema: 2.0.0
title: Remove-EntraPolicy
---

# Remove-EntraPolicy

## SYNOPSIS

Removes a policy.

## SYNTAX

```powershell
Remove-EntraPolicy
 -Id <String>
 [<CommonParameters>]
```

## DESCRIPTION

The `Remove-EntraPolicy` cmdlet removes a policy from Microsoft Entra ID. Specify `Id` parameter to remove a specific policy.

## EXAMPLES

### Example 1: Remove a policy

```powershell
Connect-Entra -Scopes 'Policy.Read.ApplicationConfiguration'
$policy = Get-EntraPolicy | Where-Object { $_.DisplayName -eq 'Microsoft User Default Recommended Policy' }
Remove-EntraPolicy -Id $policy.Id
```

This command removes the specified policy from Microsoft Entra ID.

- `-Id` - specifies the ID of the policy you want to remove.

## PARAMETERS

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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraPolicy](Get-EntraPolicy.md)

[New-EntraPolicy](New-EntraPolicy.md)

[Set-EntraPolicy](Set-EntraPolicy.md)
