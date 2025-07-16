---
author: msewaweru
description: This article provides details on the Remove-EntraLifecyclePolicyGroup command.
external help file: Microsoft.Entra.Groups-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra
ms.author: eunicewaweru
ms.date: 06/26/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Remove-EntraLifecyclePolicyGroup
schema: 2.0.0
title: Remove-EntraLifecyclePolicyGroup
---

# Remove-EntraLifecyclePolicyGroup

## SYNOPSIS

Removes a group from a lifecycle policy.

## SYNTAX

```powershell
Remove-EntraLifecyclePolicyGroup
 -GroupId <String>
 -GroupLifecyclePolicyId <String>
 [<CommonParameters>]
```

## DESCRIPTION

The `Remove-EntraLifecyclePolicyGroup` cmdlet removes a group from a lifecycle policy in Microsoft Entra ID.

## EXAMPLES

### Example 1: Remove lifecycle policy group

```powershell
Connect-Entra -Scopes 'Directory.ReadWrite.All'
$group = Get-EntraGroup -Filter "DisplayName eq 'Office365 group'"
$policy = Get-EntraLifecyclePolicyGroup -Id $group.Id
Remove-EntraLifecyclePolicyGroup -GroupLifecyclePolicyId $policy.Id -GroupId $group.Id
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

[Get-EntraLifecyclePolicyGroup](Get-EntraLifecyclePolicyGroup.md)

[Add-EntraLifecyclePolicyGroup](Add-EntraLifecyclePolicyGroup.md)
