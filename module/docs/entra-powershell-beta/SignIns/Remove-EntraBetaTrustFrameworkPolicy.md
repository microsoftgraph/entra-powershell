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

## SYNOPSIS

Deletes a trust framework policy (custom policy) in the Microsoft Entra ID.

## SYNTAX

```powershell
Remove-EntraBetaTrustFrameworkPolicy
 -Id <String>
 [<CommonParameters>]
```

## DESCRIPTION

The `Remove-EntraBetaTrustFrameworkPolicy` cmdlet deletes a trust framework policy in the Microsoft Entra ID. The trust framework policy is permanently deleted.

In delegated scenarios with work or school accounts, the admin must have a supported Microsoft Entra role or a custom role with the required permissions. The `B2C IEF Policy Administrator` is the least privileged role that supports this operation.

## EXAMPLES

### Example 1: Removes the specified trust framework policy

```powershell
Connect-Entra -Scopes 'Policy.ReadWrite.TrustFramework'
Remove-EntraBetaTrustFrameworkPolicy -Id 'B2C_1A_signup_signin'
```

This example removes the specified trust framework policy.

- `-Id` parameter specifies unique identifier for a trust framework policy.

## PARAMETERS

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

## INPUTS

### System.String

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS

[Get-EntraBetaTrustFrameworkPolicy](Get-EntraBetaTrustFrameworkPolicy.md)

[New-EntraBetaTrustFrameworkPolicy](New-EntraBetaTrustFrameworkPolicy.md)

[Set-EntraBetaTrustFrameworkPolicy](Set-EntraBetaTrustFrameworkPolicy.md)
