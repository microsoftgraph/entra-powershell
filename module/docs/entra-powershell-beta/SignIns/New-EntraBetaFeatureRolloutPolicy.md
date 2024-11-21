---
title: New-EntraBetaFeatureRolloutPolicy
description: This article provides details on the New-EntraBetaFeatureRolloutPolicy command.


ms.topic: reference
ms.date: 07/05/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Entra.Beta-Help.xml
Module Name: Microsoft.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/New-EntraBetaFeatureRolloutPolicy

schema: 2.0.0
---

# New-EntraBetaFeatureRolloutPolicy

## Synopsis

Allows an admin to create the policy for cloud authentication roll-out in Microsoft Entra ID.

## Syntax

```powershell
New-EntraBetaFeatureRolloutPolicy
 -Feature <FeatureEnum>
 -IsEnabled <Boolean>
 [-Description <String>]
 [-IsAppliedToOrganization <Boolean>]
 [-AppliesTo <System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.MsDirectoryObject]>]
 -DisplayName <String>
 [<CommonParameters>]
```

## Description

The `New-EntraBetaFeatureRolloutPolicy` cmdlet allows an admin to create the policy for cloud authentication roll-out (users moving from federation to cloud auth) in Microsoft Entra ID.

The policy admin can identify whether the users authenticate using password hashes in Microsoft Entra ID (Password hash-sync) or Microsoft Entra ID on-premises directly (Pass-through authentication).

## Examples

### Example 1: Creates the policy for cloud authentication roll-out in Microsoft Entra ID

```powershell
Connect-Entra -Scopes 'Directory.ReadWrite.All'
$params = @{
    Feature = 'PassthroughAuthentication'
    DisplayName = 'Passthrough Authentication Rollout Policy'
    IsEnabled = $false
}
New-EntraBetaFeatureRolloutPolicy @params
```

```Output

Id                                   Description DisplayName                               Feature                   IsAppliedToOrganization IsEnabled
--                                   ----------- -----------                               -------                   ----------------------- ---------
00aa00aa-bb11-cc22-dd33-44ee44ee44ee            Passthrough Authentication Rollout Policy passthroughAuthentication False                   False
```

This example creates the policy for cloud authentication roll-out in Microsoft Entra ID.

- `-Feature` specifies a feature assigned to the cloud authentication roll-out policy.
Currently, you can assign PassthroughAuthentication | SeamlessSso | PasswordHashSync | EmailAsAlternateId.

- `-DisplayName` specifies the display name of the cloud authentication roll-out policy.

- `-IsEnabled` specifies the status of cloud authentication roll-out policy.

### Example 2: Creates the policy for cloud authentication roll-out in Microsoft Entra ID

```powershell
Connect-Entra -Scopes 'Directory.ReadWrite.All'
$params = @{
    Feature = 'PassthroughAuthentication'
    DisplayName = 'FeatureRolloutPolicy'
    IsEnabled = $false
    IsAppliedToOrganization = $false
}
New-EntraBetaFeatureRolloutPolicy @params
```

```Output

Id                                   Description DisplayName          Feature                   IsAppliedToOrganization IsEnabled
--                                   ----------- -----------          -------                   ----------------------- ---------
00aa00aa-bb11-cc22-dd33-44ee44ee44ee           FeatureRolloutPolicy passthroughAuthentication False                   False
```

This command creates the policy for cloud authentication roll-out in Microsoft Entra ID.

- `-Feature` specifies a feature assigned to the cloud authentication roll-out policy.
Currently, you can assign PassthroughAuthentication | SeamlessSso | PasswordHashSync | EmailAsAlternateId.

- `-DisplayName` specifies the display name of the cloud authentication roll-out policy.

- `-IsEnabled` specifies the status of cloud authentication roll-out policy.

- `-IsAppliedToOrganization` specifies if the cloud authentication roll-out policy applied to the entire organization.

## Parameters

### -DisplayName

Specifies the display name of the cloud authentication roll-out policy.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Feature

Specifies a feature assigned to the cloud authentication roll-out policy.

Currently, you can assign PassthroughAuthentication | SeamlessSso | PasswordHashSync | EmailAsAlternateId.

```yaml
Type: FeatureEnum
Parameter Sets: (All)
Aliases:

Required: True
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

Required: True
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

### Microsoft.Online.Administration.MsFeatureRolloutPolicy

## Notes

## Related Links

[Get-EntraBetaFeatureRolloutPolicy](Get-EntraBetaFeatureRolloutPolicy.md)

[Set-EntraBetaFeatureRolloutPolicy](Set-EntraBetaFeatureRolloutPolicy.md)

[Remove-EntraBetaFeatureRolloutPolicy](Remove-EntraBetaFeatureRolloutPolicy.md)