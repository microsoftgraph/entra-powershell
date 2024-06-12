---
title: Remove-EntraMSFeatureRolloutPolicy
description: This article provides details on the Remove-EntraMSFeatureRolloutPolicy command.
ms.service: entra
ms.topic: reference
ms.date: 06/11/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Remove-EntraMSFeatureRolloutPolicy

## SYNOPSIS

Allows an admin to remove the policy for cloud authentication roll-out in Microosoft Entra ID.

## SYNTAX

```powershell
Remove-EntraMSFeatureRolloutPolicy 
 -Id <String> 
 [<CommonParameters>]
```

## DESCRIPTION

An admin will use this cmdlet to remove the cloud authentication roll-out policy and have all users where policy applied to be free of the policy.
Users in groups that were assigned to the policy will fall back to the global authentication method (most common case will be federation). Specify `Id` parameter for remove an policy for cloud authentication roll-out.

## EXAMPLES

### Example 1: Removes the policy for cloud authentication roll-out in Microsoft Entra ID

```powershell
Connect-Entra -Scopes 'User.Read.All'
Remove-EntraMSFeatureRolloutPolicy -Id 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb' 
```

This command removes the policy for cloud authentication roll-out in Microsoft Entra ID.

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

[New-EntraMSFeatureRolloutPolicy](New-EntraMSFeatureRolloutPolicy.md)

[Get-EntraMSFeatureRolloutPolicy](Get-EntraMSFeatureRolloutPolicy.md)

[Set-EntraMSFeatureRolloutPolicy](Set-EntraMSFeatureRolloutPolicy.md)
