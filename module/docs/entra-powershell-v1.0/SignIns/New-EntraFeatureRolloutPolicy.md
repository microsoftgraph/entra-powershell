---
author: msewaweru
description: This article provides details on the New-EntraFeatureRolloutPolicy command.
external help file: Microsoft.Entra.SignIns-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.SignIns
ms.author: eunicewaweru
ms.date: 06/26/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.SignIns/New-EntraFeatureRolloutPolicy
schema: 2.0.0
title: New-EntraFeatureRolloutPolicy
---

# New-EntraFeatureRolloutPolicy

## SYNOPSIS

Allows an admin to create the policy for cloud authentication roll-out in Microsoft Entra ID.

## SYNTAX

```powershell
New-EntraFeatureRolloutPolicy
 -Feature <FeatureEnum>
 -IsEnabled <Boolean>
 [-Description <String>]
 [-IsAppliedToOrganization <Boolean>]
 [-AppliesTo <System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.MsDirectoryObject]>]
 -DisplayName <String>
 [<CommonParameters>]
```

## DESCRIPTION

The `New-EntraFeatureRolloutPolicy` cmdlet allows an admin to create the policy for cloud authentication roll-out (users moving from federation to cloud auth) in Microsoft Entra ID.

The policy admin can identify whether the users authenticate using password hashes in Microsoft Entra ID (Password hash-sync) or Microsoft Entra ID on-premises directly (Pass-through authentication).

## EXAMPLES

### Example 1: Creates the policy for cloud authentication roll-out in Microsoft Entra ID

```powershell
Connect-Entra -Scopes 'Directory.ReadWrite.All'
New-EntraFeatureRolloutPolicy -Feature 'PassthroughAuthentication' -DisplayName 'Passthrough Authentication Rollout Policy' -IsEnabled $false
```

```Output
Id                                   Description          DisplayName          Feature                   IsAppliedToOrganization IsEnabled
--                                   -----------          -----------          -------                   ----------------------- ---------
00aa00aa-bb11-cc22-dd33-44ee44ee44ee FeatureRolloutPolicy FeatureRolloutPolicy passthroughAuthentication False                   False

```

This example creates the policy for cloud authentication roll-out in Microsoft Entra ID.

- `-Feature` specifies a feature assigned to the cloud authentication roll-out policy.
Currently, you can assign PassthroughAuthentication | SeamlessSso | PasswordHashSync | EmailAsAlternateId.
- `-DisplayName` specifies the display name of the cloud authentication roll-out policy.
- `-IsEnabled` specifies the status of cloud authentication roll-out policy.

### Example 2: Creates the policy for cloud authentication roll-out in Microsoft Entra ID

```powershell
Connect-Entra -Scopes 'Directory.ReadWrite.All'
New-EntraFeatureRolloutPolicy -Feature 'PassthroughAuthentication' -DisplayName 'FeatureRolloutPolicy' -IsEnabled $false -IsAppliedToOrganization $false
```

```Output
Id                                   Description          DisplayName          Feature                   IsAppliedToOrganization IsEnabled
--                                   -----------          -----------          -------                   ----------------------- ---------
00aa00aa-bb11-cc22-dd33-44ee44ee44ee FeatureRolloutPolicy FeatureRolloutPolicy passthroughAuthentication False                   False

```

This command creates the policy for cloud authentication roll-out in Microsoft Entra ID.

- `-Feature` specifies a feature assigned to the cloud authentication roll-out policy.
Currently, you can assign PassthroughAuthentication | SeamlessSso | PasswordHashSync | EmailAsAlternateId.
- `-DisplayName` specifies the display name of the cloud authentication roll-out policy.
- `-IsEnabled` specifies the status of cloud authentication roll-out policy.
- `-IsAppliedToOrganization` specifies if the cloud authentication roll-out policy applied to the entire organization.

## PARAMETERS

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

## INPUTS

## OUTPUTS

### Microsoft.Online.Administration.MsFeatureRolloutPolicy

## NOTES

See more details - <https://learn.microsoft.com/graph/api/resources/featurerolloutpolicy>

## RELATED LINKS

[Get-EntraFeatureRolloutPolicy](Get-EntraFeatureRolloutPolicy.md)

[Set-EntraFeatureRolloutPolicy](Set-EntraFeatureRolloutPolicy.md)

[Remove-EntraFeatureRolloutPolicy](Remove-EntraFeatureRolloutPolicy.md)
