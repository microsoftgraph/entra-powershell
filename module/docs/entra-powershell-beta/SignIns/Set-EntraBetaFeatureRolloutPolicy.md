---
title: Set-EntraBetaFeatureRolloutPolicy
description: This article provides details on the Set-EntraBetaFeatureRolloutPolicy command.


ms.topic: reference
ms.date: 07/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Entra.Beta.SignIns-Help.xml
Module Name: Microsoft.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Set-EntraBetaFeatureRolloutPolicy
schema: 2.0.0
---

# Set-EntraBetaFeatureRolloutPolicy

## Synopsis

Allows an admin to modify the policy for cloud authentication roll-out in Microsoft Entra ID.

## Syntax

```powershell
Set-EntraBetaFeatureRolloutPolicy
 [-Feature <FeatureEnum>]
 [-IsEnabled <Boolean>]
 -Id <String>
 [-IsAppliedToOrganization <Boolean>]
 [-AppliesTo <System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.MsDirectoryObject]>]
 [-Description <String>]
 [-DisplayName <String>]
 [<CommonParameters>]
```

## Description

An admin uses the `Set-EntraBetaFeatureRolloutPolicy` cmdlet to modify the cloud authentication rollout policy.

This includes specifying whether the method for cloud authentication is Pass-through Authentication or Password Hash Synchronization, and whether Seamless Single Sign-On (SSO) is enabled.

Users in groups assigned to the policy will start authenticating using the new method and Seamless SSO, if it is specified.

## Examples

### Example 1: Updates the policy for cloud authentication roll-out in Microsoft Entra ID

```powershell
Connect-Entra -Scopes 'Directory.ReadWrite.All'
$policy = Get-EntraBetaFeatureRolloutPolicy -Filter "DisplayName eq 'Feature-Rollout-Policy'"
Set-EntraBetaFeatureRolloutPolicy -Id $policy.Id -DisplayName 'Feature-Rollout-Policytest' -IsEnabled $false
```

This command updates the policy for cloud authentication roll-out in Microsoft Entra ID.

- `-Id` - specifies the ID of cloud authentication roll-out policy.
- `-DisplayName` - specifies the display name of the cloud authentication roll-out policy.
- `-IsEnabled` - specifies the status of cloud authentication roll-out policy.

### Example 2: Updates the Description

```powershell
Connect-Entra -Scopes 'Directory.ReadWrite.All'
$policy = Get-EntraBetaFeatureRolloutPolicy -Filter "DisplayName eq 'Feature-Rollout-Policy'"
Set-EntraBetaFeatureRolloutPolicy -Id $policy.Id -Description 'Feature-Rollout-Policytest'
```

This command updates the `-Description` of policy for cloud authentication roll-out in Microsoft Entra ID.

- `-Id` Specify the ID of cloud authentication roll-out policy.
- `-Description` Specifies the description of the cloud authentication roll-out policy.

### Example 3: Updates the IsAppliedToOrganization

```powershell
Connect-Entra -Scopes 'Directory.ReadWrite.All'
$policy = Get-EntraBetaFeatureRolloutPolicy -Filter "DisplayName eq 'Feature-Rollout-Policy'"
Set-EntraBetaFeatureRolloutPolicy -Id $policy.Id -IsAppliedToOrganization $false
```

This command updates the `-IsAppliedToOrganization` parameter of policy for cloud authentication roll-out in Microsoft Entra ID to indicate that the feature should be applied to the entire organization.

- `-Id` Specify the ID of cloud authentication roll-out policy.
- `-IsAppliedToOrganization` Parameter determines whether a particular feature rollout policy should be applied to the entire organization or not.

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

### -DisplayName

Specifies the display name of the cloud authentication roll-out policy.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Feature

Specifies a feature assigned to the cloud authentication roll-out policy.

Possible values are:
- passthroughAuthentication  
- seamlessSso  
- passwordHashSync  
- emailAsAlternateId  
- unknownFutureValue  
- certificateBasedAuthentication  
- multiFactorAuthentication

```yaml
Type: FeatureEnum
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IsEnabled

Specifies the status of cloud authentication roll-out policy.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Description

Specifies the description of the cloud authentication roll-out policy.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AppliesTo

Specifies a list of Microsoft Entra ID objects that is assigned to the feature.

```yaml
Type: System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.MsDirectoryObject]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IsAppliedToOrganization

Specifies if the cloud authentication roll-out policy applied to the entire organization.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

See more details - <https://learn.microsoft.com/graph/api/resources/featurerolloutpolicy>

## Related links

[New-EntraBetaFeatureRolloutPolicy](New-EntraBetaFeatureRolloutPolicy.md)

[Get-EntraBetaFeatureRolloutPolicy](Get-EntraBetaFeatureRolloutPolicy.md)

[Remove-EntraBetaFeatureRolloutPolicy](Remove-EntraBetaFeatureRolloutPolicy.md)
