---
title: Remove-EntraBetaPolicy
description: This article provides details on the Remove-EntraBetaPolicy command.

ms.topic: reference
ms.date: 07/02/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Remove-EntraBetaPolicy

schema: 2.0.0
---

# Remove-EntraBetaPolicy

## Synopsis

Removes a policy.

## Syntax

```powershell
Remove-EntraBetaPolicy
 -Id <String>
 [<CommonParameters>]
```

## Description

The `Remove-EntraBetaPolicy` cmdlet removes a policy from Microsoft Entra ID. Specify `Id` parameter to remove a specific policy.

## Examples

### Example 1: Remove a policy

```powershell
Connect-Entra -Scopes 'Policy.Read.ApplicationConfiguration'
Remove-EntraBetaPolicy -Id 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'
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

## Related Links

[Get-EntraBetaPolicy](Get-EntraBetaPolicy.md)

[New-EntraBetaPolicy](New-EntraBetaPolicy.md)

[Set-EntraBetaPolicy](Set-EntraBetaPolicy.md)
