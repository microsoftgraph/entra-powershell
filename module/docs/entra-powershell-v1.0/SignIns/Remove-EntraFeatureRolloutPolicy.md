---
author: msewaweru
description: This article provides details on the Remove-EntraFeatureRolloutPolicy command.
external help file: Microsoft.Entra.SignIns-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra
ms.author: eunicewaweru
ms.date: 07/22/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Remove-EntraBetaFeatureRolloutPolicy
schema: 2.0.0
title: Remove-EntraFeatureRolloutPolicy
---

# Remove-EntraFeatureRolloutPolicy

## SYNOPSIS

Allows an admin to remove the policy for cloud authentication roll-out in Microsoft Entra ID.

## SYNTAX

```powershell
Remove-EntraFeatureRolloutPolicy
 -Id <String>
 [<CommonParameters>]
```

## DESCRIPTION

An admin uses `Remove-EntraFeatureRolloutPolicy` cmdlet to remove the cloud authentication roll-out policy and have all users where policy applied to be free of the policy.

Users in groups that were assigned to the policy falls back to the global authentication method (most common case will be federation). Specify `Id` parameter to remove the cloud authentication roll-out policy.

## EXAMPLES

### Example 1: Removes the policy for cloud authentication roll-out in Microsoft Entra ID

```powershell
Connect-Entra -Scopes 'Directory.ReadWrite.All'
$policy = Get-EntraFeatureRolloutPolicy -Filter "DisplayName eq 'Feature-Rollout-Policy'"
Remove-EntraFeatureRolloutPolicy -Id $policy.Id
```

This example removes the policy for cloud authentication roll-out in Microsoft Entra ID.

- `-Id` - specifies the unique identifier of the cloud authentication roll-out policy. You can use `Get-EntraFeatureRolloutPolicy` to retrieve policy details.

## PARAMETERS

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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[New-EntraFeatureRolloutPolicy](New-EntraFeatureRolloutPolicy.md)

[Get-EntraFeatureRolloutPolicy](Get-EntraFeatureRolloutPolicy.md)

[Set-EntraFeatureRolloutPolicy](Set-EntraFeatureRolloutPolicy.md)
