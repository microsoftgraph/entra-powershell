---
author: msewaweru
description: This article provides details on the Remove-EntraBetaLifecyclePolicyGroup command.
external help file: Microsoft.Entra.Beta.Groups-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 07/23/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Remove-EntraBetaLifecyclePolicyGroup
schema: 2.0.0
title: Remove-EntraBetaLifecyclePolicyGroup
---

# Remove-EntraBetaLifecyclePolicyGroup

## SYNOPSIS

Removes a group from a lifecycle policy.

## SYNTAX

```powershell
Remove-EntraBetaLifecyclePolicyGroup
 -GroupLifecyclePolicyId <String>
 -GroupId <String>
 [<CommonParameters>]
```

## DESCRIPTION

The `Remove-EntraBetaLifecyclePolicyGroup` cmdlet removes a group from a lifecycle policy in Microsoft Entra ID.

## EXAMPLES

### Example 1: Remove lifecycle policy group

```powershell
Connect-Entra -Scopes 'Directory.ReadWrite.All'
$group = Get-EntraBetaGroup -Filter "DisplayName eq 'Office365 group'"
$policy = Get-EntraBetaLifecyclePolicyGroup -Id $group.Id
Remove-EntraBetaLifecyclePolicyGroup -GroupLifecyclePolicyId $policy.Id -GroupId $group.Id
```

```Output
Value
-----
True
```

This example demonstrates how to  remove a group from a lifecycle policy in Microsoft Entra ID with specified Id and groupId.

- `-GroupLifecyclePolicyId` parameter specifies the lifecycle policy object ID.  
- `-GroupId` parameter specifies the ID of Office365 group.

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

[Add-EntraBetaLifecyclePolicyGroup](Add-EntraBetaLifecyclePolicyGroup.md)

[Get-EntraBetaLifecyclePolicyGroup](Get-EntraBetaLifecyclePolicyGroup.md)
