---
title: Set-EntraMSGroupLifecyclePolicy.
description: This article provides details on the Set-EntraMSGroupLifecyclePolicy command.

ms.service: active-directory
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

## SYNOPSIS
Updates a specific group Lifecycle Policy in Microsoft Entra ID.

## SYNTAX

```powershell
Set-EntraMSGroupLifecyclePolicy 
 -Id <String>
 [-AlternateNotificationEmails <String>] 
 [-GroupLifetimeInDays <Int32>]
 [-ManagedGroupTypes <String>] 
 [<CommonParameters>]
```

## DESCRIPTION
The Set-EntraMSGroupLifecyclePolicy command updates a specific group Lifecycle Policy in Microsoft Entra ID.

## EXAMPLES

### Example 1: Updates group lifecycle policy
```powershell
PS C:\>  Set-EntraMSGroupLifecyclePolicy -Id "098e32e0-06e0-4ca2-b398-f521b6a7ddef" -GroupLifetimeInDays 200 -AlternateNotificationEmails "admingroup@contoso.com" -ManagedGroupTypes "All"
```
```output
Id                                   AlternateNotificationEmails GroupLifetimeInDays ManagedGroupTypes
--                                   --------------------------- ------------------- -----------------
098e32e0-06e0-4ca2-b398-f521b6a7ddef admingroup@contoso.com      200                 All
```
This example demonstrates how to update the specified group lifecycle policy in Microsoft Entra ID.

## PARAMETERS

### -AlternateNotificationEmails
Notification emails for groups that have no owners are sent to these email addresses.
List of email addresses separated by a ";".

```yaml
Type: String
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
Type: Int32
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
Type: String
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
Type: String
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

## INPUTS

### System.String
## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS

[Get-EntraMSGroupLifecyclePolicy](Get-EntraMSGroupLifecyclePolicy.md)

[New-EntraMSGroupLifecyclePolicy](New-EntraMSGroupLifecyclePolicy.md)

[Remove-EntraMSGroupLifecyclePolicy](Remove-EntraMSGroupLifecyclePolicy.md)