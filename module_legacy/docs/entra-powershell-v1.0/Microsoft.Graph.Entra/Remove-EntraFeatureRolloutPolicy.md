---
title: Remove-EntraFeatureRolloutPolicy
description: This article provides details on the Remove-EntraFeatureRolloutPolicy command.


ms.topic: reference
ms.date: 07/22/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: mwongerapk
author: msewaweru

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Remove-EntraBetaFeatureRolloutPolicy
schema: 2.0.0
---

# Remove-EntraFeatureRolloutPolicy

## Synopsis

Allows an admin to remove the policy for cloud authentication roll-out in Microsoft Entra ID.

## Syntax

```powershell
Remove-EntraFeatureRolloutPolicy
 -Id <String>
 [<CommonParameters>]
```

## Description

An admin uses `Remove-EntraFeatureRolloutPolicy` cmdlet to remove the cloud authentication roll-out policy and have all users where policy applied to be free of the policy.

Users in groups that were assigned to the policy falls back to the global authentication method (most common case will be federation). Specify `Id` parameter to remove the cloud authentication roll-out policy.

## Examples

### Example 1: Removes the policy for cloud authentication roll-out in Microsoft Entra ID

```powershell
Connect-Entra -Scopes 'Directory.ReadWrite.All'
$Policy = Get-EntraFeatureRolloutPolicy -Filter "DisplayName eq 'Feature-Rollout-Policy'"
Remove-EntraFeatureRolloutPolicy -Id $Policy.Id
```

This example removes the policy for cloud authentication roll-out in Microsoft Entra ID.

- `-Id` - specifies the unique identifier of the cloud authentication roll-out policy. You can use `Get-EntraFeatureRolloutPolicy` to retrieve policy details.

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

## Related Links

[New-EntraFeatureRolloutPolicy](New-EntraFeatureRolloutPolicy.md)

[Get-EntraFeatureRolloutPolicy](Get-EntraFeatureRolloutPolicy.md)

[Set-EntraFeatureRolloutPolicy](Set-EntraFeatureRolloutPolicy.md)
