---
author: msewaweru
description: This article provides details on the Remove-EntraFeatureRolloutPolicyDirectoryObject command.
external help file: Microsoft.Entra.SignIns-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra
ms.author: eunicewaweru
ms.date: 07/22/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Remove-EntraFeatureRolloutPolicyDirectoryObject
schema: 2.0.0
title: Remove-EntraFeatureRolloutPolicyDirectoryObject
---

# Remove-EntraFeatureRolloutPolicyDirectoryObject

## SYNOPSIS

Allows an admin to remove a group from the cloud authentication rollout policy in Microsoft Entra ID.
Users in this group revert back to the authenticating using the global policy (in most cases this will be federation).

## SYNTAX

```powershell
Remove-EntraFeatureRolloutPolicyDirectoryObject
 -DirectoryObjectId <String>
 -FeatureRolloutPolicyId <String>
 [<CommonParameters>]
```

## DESCRIPTION

An admin uses the `Remove-EntraFeatureRolloutPolicyDirectoryObject` cmdlet to remove groups from the cloud authentication roll-out policy.

Users in these groups start authenticating against the global authentication policy (for example,
federation). Specify `DirectoryObjectId` and `FeatureRolloutPolicyId` parameter to remove groups from the cloud authentication roll-out policy.

## EXAMPLES

### Example 1: Removes a group from the cloud authentication roll-out policy from Microsoft Entra ID

```powershell
Connect-Entra -Scopes 'Directory.ReadWrite.All'
$policy = Get-EntraFeatureRolloutPolicy -Filter "displayName eq 'MFA Rollout Policy'"
$group = Get-EntraGroup -Filter "displayName eq 'Sales and Marketing'"
Remove-EntraFeatureRolloutPolicyDirectoryObject -FeatureRolloutPolicyId $policy.Id  -DirectoryObjectId $group.Id
```

This command removes a group from the cloud authentication roll-out policy from Microsoft Entra ID.

- `-FeatureRolloutPolicyId` Parameter specifies the ID of the cloud authentication roll-out policy.
- `-DirectoryObjectId` parameter specifies the ID of the specific Microsoft Entra ID directory object that assigned to the cloud authentication roll-out policy.

## PARAMETERS

### -FeatureRolloutPolicyId

The unique identifier of the cloud authentication roll-out policy in Microsoft Entra ID.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: Id

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -DirectoryObjectId

The unique identifier of the specific Microsoft Entra ID object that assigned to the cloud authentication roll-out policy in Microsoft Entra ID.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: ObjectId

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
