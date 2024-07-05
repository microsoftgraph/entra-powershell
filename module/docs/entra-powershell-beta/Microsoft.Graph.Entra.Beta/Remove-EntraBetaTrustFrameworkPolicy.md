---
title:  Remove-EntraBetaTrustFrameworkPolicy.
description: This article provides details on the Remove-EntraBetaTrustFrameworkPolicy command.

ms.service: entra
ms.topic: reference
ms.date: 07/05/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Remove-EntraBetaTrustFrameworkPolicy

## Synopsis

This cmdlet is used to delete a trust framework policy (custom policy) in the Microsoft Entra ID.

## Syntax

```powershell
Remove-EntraBetaTrustFrameworkPolicy 
 -Id <String> 
 [<CommonParameters>]
```

## Description

This `Remove-EntraBetaTrustFrameworkPolicy` cmdlet is used to delete a trust framework policy in the Microsoft Entra ID. The trust framework policy is permanently deleted. Specify `Id` parameter to delete a trust framework policy.

## Examples

### Example 1: Removes the specified trust framework policy

```powershell
Remove-EntraBetaTrustFrameworkPolicy -Id B2C_1A_signup_signin
```

This example removes the specified trust framework policy.

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
