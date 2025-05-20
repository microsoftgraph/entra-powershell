---
title: Remove-EntraBetaFeatureRolloutPolicy
description: This article provides details on the Remove-EntraBetaFeatureRolloutPolicy command.


ms.topic: reference
ms.date: 07/04/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Remove-EntraBetaFeatureRolloutPolicy

schema: 2.0.0
---

# Remove-EntraBetaFeatureRolloutPolicy

## Synopsis

Allows an admin to remove the policy for cloud authentication roll-out in Microsoft Entra ID.

## Syntax

```powershell
Remove-EntraBetaFeatureRolloutPolicy
 -Id <String>
 [<CommonParameters>]
```

## Description

An admin uses `Remove-EntraBetaFeatureRolloutPolicy` cmdlet to remove the cloud authentication roll-out policy and have all users where policy applied to be free of the policy.

Users in groups that were assigned to the policy falls back to the global authentication method (most common case will be federation). Specify `Id` parameter to remove the cloud authentication roll-out policy.

## Examples

### Example 1: Removes the policy for cloud authentication roll-out in Microsoft Entra ID

```powershell
Connect-Entra -Scopes 'Directory.ReadWrite.All'
$Policy = Get-EntraBetaFeatureRolloutPolicy -Filter "DisplayName eq 'Feature-Rollout-Policy'"
Remove-EntraBetaFeatureRolloutPolicy -Id $Policy.Id
```

This example removes the policy for cloud authentication roll-out in Microsoft Entra ID.

- `-Id` - specifies the unique identifier of the cloud authentication roll-out policy. You can use `Get-EntraBetaFeatureRolloutPolicy` to retrieve policy details.

## Parameters

### -Id

The unique identifier of the cloud authentication roll-out policy in Microsoft Entra ID.

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

[New-EntraBetaFeatureRolloutPolicy](New-EntraBetaFeatureRolloutPolicy.md)

[Get-EntraBetaFeatureRolloutPolicy](Get-EntraBetaFeatureRolloutPolicy.md)

[Set-EntraBetaFeatureRolloutPolicy](Set-EntraBetaFeatureRolloutPolicy.md)
