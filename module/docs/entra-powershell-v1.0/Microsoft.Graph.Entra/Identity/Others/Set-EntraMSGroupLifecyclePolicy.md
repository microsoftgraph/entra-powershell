---
title: Set-EntraMSGroupLifecyclePolicy.
description: This article provides details on the Set-EntraMSGroupLifecyclePolicy command.

ms.service: entra
ms.topic: reference
ms.date: 03/15/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Set-EntraMSGroupLifecyclePolicy

## Synopsis

Updates a specific group Lifecycle Policy in Microsoft Entra ID.

## Syntax

```powershell
Set-EntraMSGroupLifecyclePolicy 
 -Id <String>
 [-AlternateNotificationEmails <String>] 
 [-GroupLifetimeInDays <Int32>]
 [-ManagedGroupTypes <String>] 
 [<CommonParameters>]
```

## Description

The Set-EntraMSGroupLifecyclePolicy command updates a specific group Lifecycle Policy in Microsoft Entra ID.

## Examples

### Example 1: Updates group lifecycle policy

```powershell
Connect-Entra -Scopes 'Directory.ReadWrite.All'
Set-EntraMSGroupLifecyclePolicy -Id '1aaaaaa1-2bb2-3cc3-4dd4-5eeeeeeeeee5' -GroupLifetimeInDays 200 -AlternateNotificationEmails 'admingroup@contoso.com' -ManagedGroupTypes 'All'
```

```output
Id                                   AlternateNotificationEmails GroupLifetimeInDays ManagedGroupTypes
--                                   --------------------------- ------------------- -----------------
1aaaaaa1-2bb2-3cc3-4dd4-5eeeeeeeeee5 admingroup@contoso.com      200                 All
```

This command is used to set the properties of a specific Microsoft Group Lifecycle Policy.

- The `-Id` parameter specifies the ID of the Lifecycle Policy to be modified.
- The `-GroupLifetimeInDays` parameter sets the lifetime of the groups in the policy to 200 days. The GroupLifetimeInDays represents the number of days before a group expires and needs to be renewed. Once renewed, the group expiration is extended by the number of days defined.
- The `-AlternateNotificationEmails` parameter sets the email address that receives notifications about the policy. Multiple email address can be defined by separating email address with a semicolon.
- The `-ManagedGroupTypes` parameter sets the types of groups that the policy manages. Possible values are `All`, `Selected`, or `None`.

In this case, "All" suggests that the policy manages all types of groups.

## Parameters

### -AlternateNotificationEmails

Notification emails for groups that have no owners are sent to these email addresses.
List of email addresses separated by a ";".

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

### -GroupLifetimeInDays

The number of days a group can exist before it needs to be renewed.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Id

Specifies the ID of a groupLifecyclePolicies object in Microsoft Entra ID.

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

### -ManagedGroupTypes

Allows the admin to select which office 365 groups the policy applies to.  
"None" create the policy in a disabled state.  
"All" apply the policy to every Office 365 group in the tenant.  
"Selected" allow the admin to choose specific Office 365 groups that the policy applies to.

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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

### System.String

## Outputs

### System.Object

## Notes

## Related LINKS

[Get-EntraMSGroupLifecyclePolicy](Get-EntraMSGroupLifecyclePolicy.md)

[New-EntraMSGroupLifecyclePolicy](New-EntraMSGroupLifecyclePolicy.md)

[Remove-EntraMSGroupLifecyclePolicy](Remove-EntraMSGroupLifecyclePolicy.md)