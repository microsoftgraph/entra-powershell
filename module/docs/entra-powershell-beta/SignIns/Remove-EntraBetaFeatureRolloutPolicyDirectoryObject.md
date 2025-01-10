---
title: Remove-EntraBetaFeatureRolloutPolicyDirectoryObject
description: This article provides details on the Remove-EntraBetaFeatureRolloutPolicyDirectoryObject command.


ms.topic: reference
ms.date: 07/04/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Entra.Beta.SignIns-Help.xml
Module Name: Microsoft.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Remove-EntraBetaFeatureRolloutPolicyDirectoryObject

schema: 2.0.0
---

# Remove-EntraBetaFeatureRolloutPolicyDirectoryObject

## Synopsis

Allows an admin to remove a group from the cloud authentication rollout policy in Microsoft Entra ID.
Users in this group revert back to the authenticating using the global policy (in most cases this will be federation).

## Syntax

```powershell
Remove-EntraBetaFeatureRolloutPolicyDirectoryObject
 -ObjectId <String>
 -Id <String>
 [<CommonParameters>]
```

## Description

An admin uses the `Remove-EntraBetaFeatureRolloutPolicyDirectoryObject` cmdlet to remove groups from the cloud authentication roll-out policy.

Users in these groups start authenticating against the global authentication policy (for example,
federation). Specify `ObjectId` and `Id` parameter to remove groups from the cloud authentication roll-out policy.

## Examples

### Example 1: Removes a group from the cloud authentication roll-out policy from Microsoft Entra ID

```powershell
Connect-Entra -Scopes 'Directory.ReadWrite.All'
$params = @{
    Id = '00aa00aa-bb11-cc22-dd33-44ee44ee44ee'
    ObjectId = 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'
}
Remove-EntraBetaFeatureRolloutPolicyDirectoryObject @params
```

This command removes a group from the cloud authentication roll-out policy from Microsoft Entra ID.

- `-Id` Parameter specifies the ID of the cloud authentication roll-out policy.
- `-ObjectId` parameter specifies the ID of the specific Microsoft Entra ID object that assigned to the cloud authentication roll-out policy.

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

### -ObjectId

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

[Add-EntraBetaFeatureRolloutPolicyDirectoryObject](Add-EntraBetaFeatureRolloutPolicyDirectoryObject.md)
