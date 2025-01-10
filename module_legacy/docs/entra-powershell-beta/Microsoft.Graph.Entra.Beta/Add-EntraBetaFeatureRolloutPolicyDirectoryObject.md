---
title: Add-EntraBetaFeatureRolloutPolicyDirectoryObject
description: This article provides details on the  Add-EntraBetaFeatureRolloutPolicyDirectoryObject command.


ms.topic: reference
ms.date: 07/05/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Add-EntraBetaFeatureRolloutPolicyDirectoryObject

schema: 2.0.0
---

# Add-EntraBetaFeatureRolloutPolicyDirectoryObject

## Synopsis

Allows an admin to add a group to the cloud authentication roll-out policy in Microsoft Entra ID.
Users in this group start authenticating to the cloud per policy.

## Syntax

```powershell
Add-EntraBetaFeatureRolloutPolicyDirectoryObject
 -Id <String>
 -RefObjectId <String>
 [<CommonParameters>]
```

## Description

An admin uses `Add-EntraBetaFeatureRolloutPolicyDirectoryObject` cmdlet to add a group to the cloud authentication roll-out policy.
Users in these groups start authenticating against the cloud per policy (for example,
with Seamless single sign-on or not, or whether Passthrough auth or not). Specify `Id` and `RefObjectId` parameter to add a group to the cloud authentication roll-out policy.

## Examples

### Example 1: Adds a group to the cloud authentication roll-out policy in Microsoft Entra ID

```powershell
Connect-Entra -Scopes 'Directory.ReadWrite.All'
$params = @{
    Id = '00aa00aa-bb11-cc22-dd33-44ee44ee44ee'
    RefObjectId = 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'
}
Add-EntraBetaFeatureRolloutPolicyDirectoryObject @params
```

This command adds a group to the cloud authentication roll-out policy in Microsoft Entra ID.

- `-Id` Parameter specifies the ID of the cloud authentication roll-out policy.
- `-RefObjectId` Parameter specifies the ID of the specific Microsoft Entra ID object that assigned to the cloud authentication roll-out policy.

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

### -RefObjectId

The unique identifier of the specific Microsoft Entra ID object that assigned to the cloud authentication roll-out policy in Microsoft Entra ID.

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

[Remove-EntraBetaFeatureRolloutPolicyDirectoryObject](Remove-EntraBetaFeatureRolloutPolicyDirectoryObject.md)
