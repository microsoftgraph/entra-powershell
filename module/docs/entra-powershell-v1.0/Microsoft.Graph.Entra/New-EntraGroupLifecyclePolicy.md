---
title: New-EntraGroupLifecyclePolicy.
description: This article provides details on the New-EntraGroupLifecyclePolicy command.

ms.service: entra
ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# New-EntraGroupLifecyclePolicy

## Synopsis

Creates a new groupLifecyclePolicy.

## Syntax

```powershell
New-EntraGroupLifecyclePolicy 
 -ManagedGroupTypes <String> 
 -GroupLifetimeInDays <Int32>
 -AlternateNotificationEmails <String> 
 [<CommonParameters>]
```

## Description

Creates a new groupLifecyclePolicy in Microsoft Entra ID.

## Examples

### Example 1: Creates a new groupLifecyclePolicy

```powershell
Connect-Entra -Scopes 'Directory.ReadWrite.All'
New-EntraGroupLifecyclePolicy -GroupLifetimeInDays 99 -ManagedGroupTypes 'Selected' -AlternateNotificationEmails 'example@contoso.com'
```

```output
Id                                   AlternateNotificationEmails GroupLifetimeInDays ManagedGroupTypes
--                                   --------------------------- ------------------- -----------------
3cccccc3-4dd4-5ee5-6ff6-7aaaaaaaaaa7 example@contoso.com         99                  Selected
```

This example creates a new groupLifecyclePolicy setting the group lifetime to 99 days for a selected set of Office 365 groups and sends renewal notification emails to groups that have no owners to 'example@contoso.com'.

## Parameters

### -AlternateNotificationEmails

Notification emails for groups that have no owners sent to these email addresses.
List of email addresses separated by a ";"

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

### -GroupLifetimeInDays

The number of days a group can exist before it needs to be renewed.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ManagedGroupTypes

This parameter allows the admin to select which office 365 groups the policy applies to.
"None" create the policy in a disabled state.
"All" apply the policy to every Office 365 group in the tenant.
"Selected" allow the admin to choose specific Office 365 groups that the policy applies to.

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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

### None

## Outputs

### System.Object

## Notes

## Related Links

[Get-EntraGroupLifecyclePolicy](Get-EntraGroupLifecyclePolicy.md)

[Set-EntraGroupLifecyclePolicy](Set-EntraGroupLifecyclePolicy.md)

[Remove-EntraGroupLifecyclePolicy](Remove-EntraGroupLifecyclePolicy.md)
