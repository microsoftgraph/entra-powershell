---
author: msewaweru
description: This article provides details on the Add-EntraBetaLifecyclePolicyGroup command.
external help file: Microsoft.Entra.Beta.Groups-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 07/22/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Add-EntraBetaLifecyclePolicyGroup
schema: 2.0.0
title: Add-EntraBetaLifecyclePolicyGroup
---

# Add-EntraBetaLifecyclePolicyGroup

## SYNOPSIS

Adds a group to a lifecycle policy.

## SYNTAX

```powershell
Add-EntraBetaLifecyclePolicyGroup
 -GroupLifecyclePolicyId <String>
 -GroupId <String>
 [<CommonParameters>]
```

## DESCRIPTION

The `Add-EntraBetaLifecyclePolicyGroup` cmdlet adds a group to a lifecycle policy in Microsoft Entra ID.

## EXAMPLES

### Example 1

```powershell
Connect-Entra -Scopes 'Directory.ReadWrite.All'
$group = Get-EntraBetaGroup -Filter "DisplayName eq 'Office365 group'"
$policy = Get-EntraBetaGroupLifecyclePolicy | Select-Object -First 1
Add-EntraBetaLifecyclePolicyGroup -GroupLifecyclePolicyId $policy.Id -GroupId $group.Id
```

This example adds a group to the lifecycle policy.

- `-GroupLifecyclePolicyId` parameter specifies the ID of the Lifecycle Policy add to the group.
- `-GroupId`  parameter specifies the ID of the group add to the Lifecycle Policy.

## PARAMETERS

### -GroupId

Specifies the ID of a group in Microsoft Entra ID.

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

### -GroupLifecyclePolicyId

Specifies the ID of the lifecycle policy object in Microsoft Entra ID.

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

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS

[Get-EntraBetaLifecyclePolicyGroup](Get-EntraBetaLifecyclePolicyGroup.md)

[Remove-EntraBetaLifecyclePolicyGroup](Remove-EntraBetaLifecyclePolicyGroup.md)
