---
author: msewaweru
description: This article provides details on the Set-EntraBetaGroupLifecyclePolicy command.
external help file: Microsoft.Entra.Beta.Groups-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.Beta.Groups
ms.author: eunicewaweru
ms.date: 07/23/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta.Groups/Set-EntraBetaGroupLifecyclePolicy
schema: 2.0.0
title: Set-EntraBetaGroupLifecyclePolicy
---

# Set-EntraBetaGroupLifecyclePolicy

## SYNOPSIS

Updates a specific group Lifecycle Policy in Microsoft Entra ID.

## SYNTAX

```powershell
Set-EntraBetaGroupLifecyclePolicy
 -GroupLifecyclePolicyId <String>
 [-AlternateNotificationEmails <String>]
 [-ManagedGroupTypes <String>]
 [-GroupLifetimeInDays <Int32>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Set-EntraBetaGroupLifecyclePolicy` command updates a specific group Lifecycle Policy in Microsoft Entra ID.

## EXAMPLES

### Example 1: Updates group lifecycle policy

```powershell
Connect-Entra -Scopes 'Directory.ReadWrite.All'
$policy = Get-EntraBetaGroupLifecyclePolicy | Where-Object {$_.AlternateNotificationEmails -eq 'example@contoso.com'}
Set-EntraBetaGroupLifecyclePolicy -GroupLifecyclePolicyId $policy.Id -GroupLifetimeInDays 200 -AlternateNotificationEmails 'example@contoso.com' -ManagedGroupTypes 'All'
```

```Output
Id                                   AlternateNotificationEmails GroupLifetimeInDays ManagedGroupTypes
--                                   --------------------------- ------------------- -----------------
ffffffff-5555-6666-7777-aaaaaaaaaaaa example@contoso.com                     200                 All
```

This example updates the specified groupLifecyclePolicy in Microsoft Entra ID.

- `-GroupLifecyclePolicyId` parameter specifies the ID of the Lifecycle Policy to be modified.
- `-GroupLifetimeInDays` parameter specifies the lifetime of the groups in the policy to 200 days. The GroupLifetimeInDays represents the number of days before a group expires and needs to be renewed. Once renewed, the group expiration is extended by the number of days defined.
- `-AlternateNotificationEmails` parameter specifies the email address that receives notifications about the policy. Multiple email address can be defined by separating email address with a semicolon.
- `-ManagedGroupTypes` parameter specifies which office 365 groups the policy applies to. Possible values are `All`, `Selected`, or `None`.  
In this case, 'All' suggests that the policy manages all types of groups.

## PARAMETERS

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

### -GroupLifecyclePolicyId

Specifies the ID of a groupLifecyclePolicies object in Microsoft Entra ID.

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

### -ManagedGroupTypes

Allows the admin to select which office 365 groups the policy applies to.

- "None" will create the policy in a disabled state.
- "All" will apply the policy to every Office 365 group in the tenant.
- "Selected" will allow the admin to choose specific Office 365 groups that the policy applies to.

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

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS

[Get-EntraBetaGroupLifecyclePolicy](Get-EntraBetaGroupLifecyclePolicy.md)

[New-EntraBetaGroupLifecyclePolicy](New-EntraBetaGroupLifecyclePolicy.md)

[Remove-EntraBetaGroupLifecyclePolicy](Remove-EntraBetaGroupLifecyclePolicy.md)
