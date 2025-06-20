---
author: msewaweru
description: This article provides details on the Remove-EntraBetaTrustFrameworkPolicy command.
external help file: Microsoft.Entra.Beta.SignIns-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 08/08/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Remove-EntraBetaTrustFrameworkPolicy
schema: 2.0.0
title: Remove-EntraBetaTrustFrameworkPolicy
---

# Remove-EntraBetaTrustFrameworkPolicy

## Synopsis

Deletes a trust framework policy (custom policy) in the Microsoft Entra ID.

## Syntax

```powershell
Remove-EntraBetaTrustFrameworkPolicy
 -Id <String>
 [<CommonParameters>]
```

## Description

The `Remove-EntraBetaTrustFrameworkPolicy` cmdlet deletes a trust framework policy in the Microsoft Entra ID. The trust framework policy is permanently deleted.

In delegated scenarios with work or school accounts, the admin must have a supported Microsoft Entra role or a custom role with the required permissions. The `B2C IEF Policy Administrator` is the least privileged role that supports this operation.

## Examples

### Example 1: Removes the specified trust framework policy

```powershell
Connect-Entra -Scopes 'Policy.ReadWrite.TrustFramework'
Remove-EntraBetaTrustFrameworkPolicy -Id 'B2C_1A_signup_signin'
```

This example removes the specified trust framework policy.

- `-Id` parameter specifies unique identifier for a trust framework policy.

## Parameters

### -Id

The unique identifier for a trust framework policy.

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

### System.String

## Outputs

### System.Object

## Notes

## Related links

[Get-EntraBetaTrustFrameworkPolicy](Get-EntraBetaTrustFrameworkPolicy.md)

[New-EntraBetaTrustFrameworkPolicy](New-EntraBetaTrustFrameworkPolicy.md)

[Set-EntraBetaTrustFrameworkPolicy](Set-EntraBetaTrustFrameworkPolicy.md)
