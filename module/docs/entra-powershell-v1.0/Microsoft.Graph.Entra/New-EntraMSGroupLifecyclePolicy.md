---
title: New-EntraMSGroupLifecyclePolicy.
description: This article provides details on the New-EntraMSGroupLifecyclePolicy command.

ms.service: active-directory
ms.topic: reference
ms.date: 03/14/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# New-EntraMSGroupLifecyclePolicy

## SYNOPSIS

Creates a new groupLifecyclePolicy.

## SYNTAX

```powershell
New-EntraMSGroupLifecyclePolicy 
 -ManagedGroupTypes <String> 
 -GroupLifetimeInDays <Int32>
 -AlternateNotificationEmails <String> 
 [<CommonParameters>]
```

## DESCRIPTION

Creates a new groupLifecyclePolicy in Microsoft Entra ID.

## EXAMPLES

### Example 1: Creates a new groupLifecyclePolicy.

```powershell
PS C:\>Connect-Entra -Scopes 'Directory.ReadWrite.All'
PS C:\>New-EntraMSGroupLifecyclePolicy -GroupLifetimeInDays 99 -ManagedGroupTypes 'Selected' -AlternateNotificationEmails 'example@contoso.com'
```

```output
Id                                   AlternateNotificationEmails GroupLifetimeInDays ManagedGroupTypes
--                                   --------------------------- ------------------- -----------------
357ab978-332e-474d-b30c-c04709e4bd32 example@contoso.com         99                  Selected
```

This example creates a new groupLifecyclePolicy setting the group lifetime to 99 days for a selected set of Office 365 groups and sends renewal notification emails to groups that have no owners to 'example@contoso.com'.

## PARAMETERS

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

## INPUTS

### None

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS

[Get-EntraMSGroupLifecyclePolicy](Get-EntraMSGroupLifecyclePolicy.md)

[Set-EntraMSGroupLifecyclePolicy](Set-EntraMSGroupLifecyclePolicy.md)

[Remove-EntraMSGroupLifecyclePolicy](Remove-EntraMSGroupLifecyclePolicy.md)
