---
title:  Remove-EntraBetaTrustFrameworkPolicy
description: This article provides details on the Remove-EntraBetaTrustFrameworkPolicy command.


ms.topic: reference
ms.date: 08/08/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Remove-EntraBetaTrustFrameworkPolicy

schema: 2.0.0
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

The work or school account must have the `B2C IEF Keyset Administrator` role in Microsoft Entra.

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

## Related Links

[Get-EntraBetaTrustFrameworkPolicy](Get-EntraBetaTrustFrameworkPolicy.md)

[New-EntraBetaTrustFrameworkPolicy](New-EntraBetaTrustFrameworkPolicy.md)

[Set-EntraBetaTrustFrameworkPolicy](Set-EntraBetaTrustFrameworkPolicy.md)
