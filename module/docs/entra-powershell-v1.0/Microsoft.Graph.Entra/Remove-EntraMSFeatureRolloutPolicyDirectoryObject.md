---
title: Remove-EntraMSFeatureRolloutPolicyDirectoryObject
description: This article provides details on the Remove-EntraMSFeatureRolloutPolicyDirectoryObject command.
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

# Remove-EntraMSFeatureRolloutPolicyDirectoryObject

## SYNOPSIS

Allows an admin to remove a group from the cloud authentication rollout policy in Microsoft Entra ID.
Users in group revert back to the authenticating using the global policy (in most cases are federation).

## SYNTAX

```powershell
Remove-EntraMSFeatureRolloutPolicyDirectoryObject 
 -Id <String> 
 -ObjectId <String> 
 [<CommonParameters>]
```

## DESCRIPTION

An admin uses this cmdlet to remove groups from the cloud authentication roll-out policy.
Users in these groups start authenticating against the global authentication policy (for example,
federation). Specify `Id` and `ObjectId` parameter for remove groups from the cloud authentication roll-out policy.

## EXAMPLES

### Example 1: Removes a group from the cloud authentication roll-out policy from Microsoft Entra ID

```powershell
Connect-Entra -Scopes 'Directory.ReadWrite.All'
Remove-EntraMSFeatureRolloutPolicyDirectoryObject -Id 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb' -ObjectId 'aaaaaaaa-0000-1111-2222-cccccccccccc'
```

This command removes a group from the cloud authentication roll-out policy from Microsoft Entra ID.

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

### -ObjectId

The unique identifier of the specific Microsoft Entra ID object that assigns to the cloud authentication roll-out policy in Microsoft Entra ID.

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

[Add-EntraMSFeatureRolloutPolicyDirectoryObject](Add-EntraMSFeatureRolloutPolicyDirectoryObject.md)
