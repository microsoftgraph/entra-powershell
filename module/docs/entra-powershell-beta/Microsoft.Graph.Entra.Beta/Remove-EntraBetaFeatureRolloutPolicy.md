---
title: Remove-EntraBetaFeatureRolloutPolicy.
description: This article provides details on the Remove-EntraBetaFeatureRolloutPolicy command.

ms.service: entra
ms.topic: reference
ms.date: 07/04/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Remove-EntraBetaFeatureRolloutPolicy

## Synopsis

Allows an admin to remove the policy for cloud authentication roll-out in Microsoft Entra ID

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
Remove-EntraBetaFeatureRolloutPolicy -Id '11bb11bb-cc22-dd33-ee44-55ff55ff55ff'
```

This command removes the policy for cloud authentication roll-out in Microsoft Entra ID.

## Parameters

### -ID

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

[New-EntraBetaFeatureRolloutPolicy](New-EntraBetaFeatureRolloutPolicy.md)

[Get-EntraBetaFeatureRolloutPolicy](Get-EntraBetaFeatureRolloutPolicy.md)

[Set-EntraBetaFeatureRolloutPolicy](Set-EntraBetaFeatureRolloutPolicy.md)
